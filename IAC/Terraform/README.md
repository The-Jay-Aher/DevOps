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

Sometimes you want to manage several similar objects (like a fixed pool of compute instances) without writing a separate block for each one.

### Count Argument

The count argument accepts a whole number, and creates that many instances of the resource.

```terraform
resource "aws_instance" "myEC2" {
  ami = "ami-068e0f1a600cd311c"
  instance_type = "t2.micro"
  count = 3
}
```

### Challenges with Count

1. The instances created through count and identical copies, but you might want to customize certain properties for each one.
2. For many resources, the exact copy may not be required and will not work. E.g. - IAM User

## Introducing Count Index

When using count, you can also make use of `count.index` which allows better flexibility. This attribute holds a distinct index number, starting from 0, that uniquely identifies each index created by count meta-argument.

0 -> First EC2 Instance
1 -> Second EC2 Instance
2 -> Third EC2 Instance

### Enhancing with count index

You can use the `count.index` to iterate through the list to have more customization

## Conditional Expressions

Conditional Expression in Terraform allow you to choose between two values based on a condition

Syntax -

```terraform
condition ? true_val : false_val
```

In conditional expressions, when we give no default value to the variable and have `"" ? "t2.micro" : "t2.nano"`, here the output will be `t2.micro`.

You can also use conditional expression with multiple variables. E.g. -
`instance_type = var.environment == "production" && var.region == "us-east-1" ? "t2.micro" : "t2.nano"`

## Functions

### Introducing Terraform Console

Terraform console provides an interactive environment specifically designed to test functions and experiment with expressions before integrating them into your main code.

Command - `terraform console`

**Importance of File Function**

File function can reduce the overall Terraform code size by loading contents from external sources during Terraform operations.

| Function Categories  | Functions Available                      |
| -------------------- | ---------------------------------------- |
| Numeric Functions    | abs, ceil, floor, max, min               |
| String Functions     | concat, replace, split, tolower, toupper |
| Collection Functions | element, keys, length, merge, sort       |
| Filesystem Functions | file, filebase64, dirname                |


