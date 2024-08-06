# Terraform Notes

## Variable Assignment

If I have a `*.tfvars` file with different name, other than default `terraform` then -

```powershell
terraform plan --var="instance_type=t2.micro"
```

Here the `instance_type` is the name of the variable

## Variable Precedence

Terraform loads variables in the following order, with the later sources taking precedence over the earlier ones:

1. Environment Variables
2. The `terraform.tfvars` file if present
3. The `terraform.tfvars.json` file. if present
4. Any `*.auto.tfvars` or `*.auto.tfvars,json` files, processed in order of their file names
5. Any `-var` or `-var-file` options in command line

5 -> Highest Precedence
1 -> Lowest Precedence

## Data Types in Terraform

-   string
-   number
-   bool
-   list -

    -   Allows us to store a collection of values for a single variable/argument.
    -   Represented by a pair of square bracket containing a comma-separated sequence of values
    -   Useful when multiple values needs to be added for a specific argument
    -   E.g - `["a", 15, true]`

    ```terraform
        variable "my-list" {
        type = "list"
        default = ["mumbai", "bangalore", "delhi"]
        }

    ```

-   set
-   map
    -   A map data type represents a collection of key-value pair elements
-   null

## Count Meta-Argument

### Use Case

-   Sometimes you want to manage several similar objects (like a fixed pool of compute instances) without writing a separate block for each one.

### Count Argument

-   The count argument accepts a whole number, and creates that many instances of the resource.

```terraform
resource "aws_instance" "myEC2" {
  ami = "ami-068e0f1a600cd311c"
  instance_type = "t2.micro"
  count = 3
}
```

### Challenges with Count

-   The instances created through count and identical copies, but you might want to customize certain properties for each one.
-   For many resources, the exact copy may not be required and will not work. E.g. - IAM User

## Introducing Count Index

-   When using count, you can also make use of `count.index` which allows better flexibility. This attribute holds a distinct index number, starting from 0, that uniquely identifies each index created by count meta-argument.

-   `0` -> First EC2 Instance
-   `1` -> Second EC2 Instance
-   `2` -> Third EC2 Instance

### Enhancing with count index

-   You can use the `count.index` to iterate through the list to have more customization

## Conditional Expressions

-   Conditional Expression in Terraform allow you to choose between two values based on a condition

Syntax -

```terraform
condition ? true_val : false_val
```

-   In conditional expressions, when we give no default value to the variable and have `"" ? "t2.micro" : "t2.nano"`, here the output will be `t2.micro`.
-   You can also use conditional expression with multiple variables. E.g. -
    `instance_type = var.environment == "production" && var.region == "us-east-1" ? "t2.micro" : "t2.nano"`

## Functions

### Introducing Terraform Console

-   Terraform console provides an interactive environment specifically designed to test functions and experiment with expressions before integrating them into your main code.
-   Command - `terraform console`

**Importance of File Function**

-   File function can reduce the overall Terraform code size by loading contents from external sources during Terraform operations.

| Function Categories  | Functions Available                      |
| -------------------- | ---------------------------------------- |
| Numeric Functions    | abs, ceil, floor, max, min               |
| String Functions     | concat, replace, split, tolower, toupper |
| Collection Functions | element, keys, length, merge, sort       |
| Filesystem Functions | file, filebase64, dirname                |

## Local Values

-   Local Values are similar to variables in a sense that it allows you to store data centrally and that can be referenced in multiple parts of configuration.
-   **Additional Benefits of Locals** - You can add expressions to locals, which allows you to compute values dynamically

**Locals v/s Variables** -

-   Variable value can be defined in wide variety of places like `terraform.tfvars`, `ENV Variables`, `CLI` and so on.
-   Locals are more of a private resource. You have to directly modify the source code.
-   Locals are used when you want to avoid repeating the same expression multiple times.

**Important Points** -

-   Local values are often just referred as just `locals`
-   Local values are created by a `locals` block (plural), but you reference them as attributes on an object `local` (singular)

## Data Sources

-   Data sources allow Terraform to ` use / fetch information outside information of Terraform`
-   `${path.module}` returns the current file system path where your code is located
-   A data source is accessed via a special kind of resource known as `data resource`, declared using data block;
-   Following data block requests that Terraform read from a given data source("aws_instance") and export the result under the given local name("foo")

**Filter Structure** - Within the body(between { and } ) are query constraints defined by the data source

## Debugging in Terraform

-   Terraform has detailed logs which can be enabled by setting the `TF_LOG` environment variable to any value
-   You can set the `TF_LOG` to one of the log levels `TRACE`, `DEBUG`, `INFO`, `WARN` or `ERROR` to change the verbosity of the logs
-   `TRACE` is the most verbose and it is the default if `TF_LOG` is set to something other than a log level name
-   To persist log output you can set `TF_LOG_PATH` in order to force the log to always be appended to a specific file when logging is enabled

## Load Order & Semantics

-   Terraform generally loads all the configuration files within the directory specified in the alphabetic order
-   The files loaded must end in either `.tf` or `.tf.json` to specify the format thats in use

## Dynamic Blocks

-   Dynamic Blocks allows us to dynamically construct repeatable nested blocks which is supported inside resource, data, provider, and provisioner block

**Iterators** -

-   The iterator argument(optional) sets the name of a temporary variable that represents the current element of the complex value.
-   If omitted, the name of the variable defaults to the label of the dynamic block("ingress" in the above example)

## Terraform Validate

-   Terraform validate primarily checks whether a configuration is syntactically valid.
-   It can check various aspects including unsupported arguments, undeclared variables and others

## Terraform Taint

**Understanding Use-Case**

-   Users may have made a lot of manual changes(both infrastructure and inside the server). Two ways to deal to with this: Import Changes into Terraform / Delete and Recreate the resource.

**Recreating the resource**

-   The `-replace` option with `terraform apply` to force Terraform to replace an object even though there are no configuration changes that would require it.

**Points to Note**

-   Similar kind of functionality was achieved using `terraform taint` command in the older versions of terraform
-   For Terraform v15.2.0 and later, HashiCorp recommended using the `-replace` option with `terraform apply`.

**Splat Expression**

-   Allows us to get a list of all the attributes.

## Terraform Graph

-   Terraform graph refers to a `visual representation of the dependency relationships` between resources defined in your Terraform configuration
-   Terraform graphs are a valuable tool for visualization and understanding the relationships between resources in your infrastructure with Terraform.
-   It can improve your overall workflow by aiding in planning, debugging, and managing complex infrastructure configurations

## Apply from Plan File

-   Terraform allows you to saving a plan to a file
-   Command - `terraform plan -out ec2.plan`

-   You can run the `terraform apply` by referencing a plan file.
-   This ensures the infrastructure state remains exactly as shown in the plan to ensure consistency
-   Command - `terraform apply ec2.plan`

**Exploring terraform plan file** 
- You can use `terraform show` command to read the contents in detail
- You can't read the file through file explorer, since it's a binary file

**Use-Case of SAving Plan to a File**
- Many organizations require documented proof of planned changes before implementation


## Terraform Output

- The terraform output command is used to extract the value of an output variable from the state file
- 