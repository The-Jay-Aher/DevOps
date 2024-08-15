# Terraform Notes

## Read, Generate, Modify Configurations

### Variable Assignment

If I have a `*.tfvars` file with a different name, other than default `terraform` then -

```powershell
terraform plan --var="instance_type=t2.micro"
```

Here the `instance_type` is the name of the variable

### Variable Precedence

Terraform loads variables in the following order, with the later sources taking precedence over the earlier ones:

1. Environment Variables
2. The `terraform.tfvars` file if present
3. The `terraform.tfvars.json` file. if present
4. Any `*.auto.tfvars` or `*.auto.tfvars,json` files, processed in order of their file names
5. Any `-var` or `-var-file` options in the command line

`5` -> Highest Precedence

`1` -> Lowest Precedence

### Data Types in Terraform

-   `string`
-   `number`
-   `bool`
-   `list` -

    -   Allows us to store values for a single variable/argument.
    -   Represented by a pair of square brackets containing a comma-separated sequence of values
    -   Useful when multiple values need to be added for a specific argument
    -   E.g - `["a", 15, true]`

    ```terraform
        variable "my-list" {
            type    = list(string)
            default = ["Mumbai", "Bangalore", "Delhi"]
        }
    ```

-   `set`
-   `map`
    -   A map data type represents a collection of key-value pair elements
-   `null`

### Count Meta-Argument

**Use Case**

-   Sometimes you want to manage several similar objects (like a fixed pool of compute instances) without writing a separate block for each one.

**Count Argument**

-   The count argument accepts a whole number and creates many instances of the resource.

    ```terraform
    resource "aws_instance" "myEC2" {
    ami           = "ami-068e0f1a600cd311c"
    instance_type = "t2.micro"
    count         = 3
    }
    ```

**Challenges with Count**

-   The instances are created through count and identical copies, but you might want to customize certain properties for each one.
-   The exact copy may not be required for many resources and will not work. E.g. - IAM User.

### Introducing Count Index

-   When using count, you can also make use of `count.index` which allows better flexibility. This attribute holds a distinct index number, starting from 0, that uniquely identifies each index created by count meta-argument.

-   `0` -> First EC2 Instance
-   `1` -> Second EC2 Instance
-   `2` -> Third EC2 Instance

**Enhancing with count index**

-   You can use the `count.index` to iterate through the list to have more customization.

### Conditional Expressions

-   Conditional Expression in Terraform allows you to choose between two values based on a condition.

    Syntax -

    ```terraform
    condition ? true_val : false_val
    ```

-   In conditional expressions, when we give no default value to the variable and have `"" ? "t2.micro" : "t2.nano"`, here the output will be `t2.micro`.
-   You can also use conditional expressions with multiple variables. E.g. -
    `instance_type = var.environment == "production" && var.region == "us-east-1" ? "t2.micro" : "t2.nano"`

### Functions

**Introducing Terraform Console**

-   Terraform console provides an interactive environment specifically designed to test functions and experiment with expressions before integrating them into your main code.
-   Command - `terraform console`

_Importance of File Function_

-   File function can reduce the overall Terraform code size by loading contents from external sources during Terraform operations.

    | **Function Categories** | **Functions Available**                  |
    | :---------------------- | ---------------------------------------- |
    | `Numeric Functions`     | abs, ceil, floor, max, min               |
    | `String Functions`      | concat, replace, split, tolower, toupper |
    | `Collection Functions`  | element, keys, length, merge, sort       |
    | `Filesystem Functions`  | file, filebase64, dirname                |

### Local Values

-   Local Values are similar to variables in the sense that they allow you to store data centrally and that can be referenced in multiple parts of the configuration.
-   _Additional Benefits of Locals_ - You can add expressions to locals, which allows you to compute values dynamically.

_Locals v/s Variables_ -

-   Variable value can be defined in a wide variety of places like `terraform.tfvars`, `ENV Variables`, `CLI` and so on.
-   Locals are more of a private resource. You have to directly modify the source code.
-   Locals are used when you want to avoid repeating the same expression multiple times.

_Important Points_ -

-   Local values are often just referred to as `locals`.
-   Local values are created by a `locals` block (plural), but you reference them as attributes on an object `local` (singular).

### Data Sources

-   Data sources allow Terraform to ` use/fetch information outside information of Terraform`.
-   `${path.module}` returns the current file system path where your code is located.
-   A data source is accessed via a special kind of resource known as `data resource`, declared using a data block;
-   Following data block requests that Terraform read from a given data source("aws_instance") and export the result under the given local name("foo").

**Filter Structure** - Within the body(between { and } ) are query constraints defined by the data source.

### Debugging in Terraform

-   Terraform has detailed logs which can be enabled by setting the `TF_LOG` environment variable to any value
-   You can set the `TF_LOG` to one of the log levels `TRACE`, `DEBUG`, `INFO`, `WARN` or `ERROR` to change the verbosity of the logs
-   `TRACE` is the most verbose and it is the default if `TF_LOG` is set to something other than a log-level name
-   To persist log output you can set `TF_LOG_PATH` to force the log to always be appended to a specific file when logging is enabled

### Load Order & Semantics

-   Terraform generally loads all the configuration files within the directory specified in the alphabetic order.
-   The files loaded must end in either `.tf` or `.tf.json` to specify the format that's in use.

### Dynamic Blocks

-   Dynamic Blocks allows us to dynamically construct repeatable nested blocks which are supported inside resource, data, provider, and provisioner block.

**Iterators** -

-   The iterator argument(optional) sets the name of a temporary variable that represents the current element of the complex value.
-   If omitted, the name of the variable defaults to the label of the dynamic block("ingress" in the above example).

### Terraform Validate

-   `terraform validate` primarily checks whether a configuration is syntactically valid.
-   It can check various aspects including unsupported arguments, undeclared variables and others.

### Terraform Taint

**Understanding Use-Case**

-   Users may have made a lot of manual changes(both infrastructure and inside the server). Two ways to deal with this: Import Changes into Terraform / Delete and Recreate the resource.

**Recreating the resource**

-   The `-replace` option with `terraform apply` to force Terraform to replace an object even though there are no configuration changes that would require it.

_Points to Note_

-   A similar kind of functionality was achieved using the `terraform taint` command in the older versions of Terraform.
-   For Terraform v15.2.0 and later, HashiCorp recommended using the `-replace` option with `terraform apply`.

**Splat Expression**

-   Allows us to get a list of all the attributes.

### Terraform Graph

-   Terraform graph refers to a `visual representation of the dependency relationships` between resources defined in your Terraform configuration.
-   Terraform graphs are a valuable tool for visualization and understanding the relationships between resources in your infrastructure with Terraform.
-   It can improve your overall workflow by aiding in planning, debugging, and managing complex infrastructure configurations.

### Apply from Plan File

-   Terraform allows you to save a plan to a file.
-   Command - `terraform plan -out ec2.plan`

-   You can run the `terraform apply` by referencing a plan file.
-   This ensures the infrastructure state remains exactly as shown in the plan to ensure consistency.
-   Command - `terraform apply ec2.plan`

_Exploring terraform plan file_

-   You can use the `terraform show` command to read the contents in detail.
-   You can't read the file through file explorer, since it's a binary file.

_Use-Case of Saving Plan to a File_

-   Many organizations require documented proof of planned changes before implementation.

### Terraform Output

-   The terraform output command is used to extract the value of an output variable from the state file.

### Terraform Settings

-   We can use the provider block to define various aspects of the provider, like region, credentials and so on.
-   _Specific Version to run your code_ - In a Terraform project, your code might require a specific set of versions to run.
-   Terraform settings are used to configure project-specific Terraform behaviors, such as requiring a minimum Terraform version to apply your configuration.
-   Terraform settings are gathered together into `terraform blocks`.

**Use Case**

1. Specifying a required terraform version -
    - If your code is compatible with specific versions of Terraform, you can use the `required_version` block to add your constraints.
2. Specifying Provider Requirements -
    - The `required_providers` block can be used to specify all of the providers required by your terraform code.
3. Flexibility in Settings block -
    - There are vide variety of options that can be specified in the Terraform block.

### Challenges with Larger Infrastructure

-   When you have a larger infrastructure, you will face issues related to API limits for providers.
-   Switch to a smaller configuration where each can be applied independently.
-   1st way -
    -   We can prevent Terraform from querying the current state during operations like `terraform plan`. This can be achieved with the `terraform plan -refresh=false` flag.
-   2nd Way -
    -   Specify the target
    -   The `terraform plan -refresh=false -target=aws_security_group.allow_ssh_conn` flag can be used to target a specific resource.
    -   Generally used as a means to operate on isolated portions of very large configurations.
    -   The `~` sign means that there is an update going on in that place.

### Zipmap Function

-   The zipmap function constructs a map from a list of keys and a corresponding list of values
-   Command - `zipmap(keyslist, valueslist)`
-   **Simple Use Case** -
    -   You are creating multiple IAM users.
    -   You need to output which contains direct mapping of the IAM names and ARNs.

### Comment in Terraform

-   The terraform language supports 3 different syntaxes for comments:

    |  **Type**   | **Description**                                                                   |
    | :---------: | --------------------------------------------------------------------------------- |
    |     `#`     | begins a single-line comment, ending at the end of the line (recommended over //) |
    |    `//`     | also begin as a single-line comment, as an alternative to #                       |
    | `/_ and _/` | are start and end delimiters for a comment that might span over multiple lines    |

### Resource Behavior and Meta Arguments

-   A `resource block` declares that you want a particular infrastructure object to exist with the given settings.

**How terraform applies a configuration**

-   Create resources that exist in the configuration but are not associated with a real infrastructure object in the state.
-   Destroy resources that exist in a state but no longer exist in the configuration.
-   Update in-place resources whose arguments have changed.
-   Destroy and re-create resources whose arguments have changed but which cannot be updated in-place due to remote API limitations.

**Understanding the Limitations** - Some modification happened in Real Infrastructure object that is not part of Terraform but you want to ignore those changes during terraform apply. This is where the `meta-argument` comes into picture.

**Solution - Using Meta Arguments**

-   Terraform allows us to include `meta-argument` within the resource block which allows some details of this standard resource behavior to be customized on a per-resource basis.

**Different Meta Arguments**

| **Meta-Argument** | **Description**                                                                                                                                           |
| :---------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `depends_on`      | Handle hidden resources or module dependencies that Terraform automatically cannot infer                                                                  |
| `count`           | Accepts a whole number, and creates that many instance of the resource                                                                                    |
| `for_each`        | Accepts a map or a set of strings, and creates an instance for each item in that map or set                                                               |
| `lifecycle`       | Allows modification to resource lifecycle                                                                                                                 |
| `provider`        | Specifies which provider configuration to be use for a resource, overriding Terraform's default behavior of selecting one based on the resource type name |

### Meta-Argument - Lifecycle

**Arguments Available**

| **Arguments**           | **Description**                                                                                                      |
| :---------------------- | -------------------------------------------------------------------------------------------------------------------- |
| `create_before_destroy` | New replacement is created first, and the prior object is destroyed after the replacement is created                 |
| `prevent_destroy`       | Terraform to reject with an error any plan that would destroy the infrastructure object associated with the resource |
| `ignore_changes`        | Ignore certain changes to the live resource that does not match the configuration                                    |
| `replace_triggered_by`  | Replaces the resources when any of the referenced item change                                                        |

**Lifecycle Meta-Argument - Create Before Destroy**

-   By default, when Terraform must change a resource argument that cannot be updated in-place due to remote API limitations, Terraform will instead destroy the existing object and then create a new replacement object with the new configured arguments.

**Lifecycle Meta-Argument - Prevent Destroy**

-   This meta-argument, when set to true, will cause Terraform to reject with an error any plan that would destroy the infrastructure object associated with the resource, as long as argument remains present in the configuration.

_Points to Note_

-   This can be used as a measure of safety against the accidental replacement of objects that may be costly to reproduce, such as database instances.
-   Since this argument must be present in configuration for the protection to apply, note that this setting does not prevent the remote object from being destroyed if the resource block were removed from configuration entirely.

**Lifecycle Meta-Argument - Ignore Changes**

-   In cases where settings of a remote object is modified by processes outside of Terraform, the Terraform would attempt to "fix" on the run.
-   In order to change this behavior and ignore the manually applied change, we can make use of `ignore_changes` argument under lifecycle.

_Points to Note_

-   Instead of a list, the special keyword `all` may be used to instruct Terraform to ignore all attributes, which means Terraform can create or destroy remote object but will never propose updates to it.

**Meta-Argument - Count**

-   If your resources are almost identical, count is appropriate.
-   If distinctive values are needed in the arguments, usage of `for_each` is needed.

### Data Type

**List**

-   Lists are used to store multiple items in a single variable.
-   List items are ordered, changeable, and allow duplicate values.
-   List items are indexed, the first item has index `[0]`, the second item has index `[1]`, etc.

    ```terraform
    variable "iam_names" {
    type    = list(string)
    default = ["user-01", "user-02", "user-03"]
    }
    ```

**Set**

-   SET is used to store multiple items in a single variable.
-   SET items are unordered and no duplicates are allowed.
-   Command - `demoSet = {"apple", "banana", "mango"}`

_toset Function_ - `toset` function will convert a list of values to set.

### For_Each

-   `for_each` makes use of map/set as an index value of the created resource.

    ```terraform
    resource "aws_iam_user" "iam" {
    for_each = toset(["user-01", "user=02", "user-03"])
    name     = each.key
    }
    ```

**Replication Count Challenge**

-   If a new element is added, it will not affect the other resources.

**The each object**

-   In blocks where `for_each` is set, an additional each object is available.
-   The object has 2 main attributes:

    | **Each Object** | **Description**                                           |
    | :-------------- | --------------------------------------------------------- |
    | `each.key`      | The map key (or set member) corresponding to the instance |
    | `each.value`    | The map value of the corresponding to this instance       |

## Terraform Provisioners

_Not included in current exam syllabus_

### Overview of Provisioners

**Setting the base**

We have been using Terraform to create and manage resources for a specific provider.

Organizations would want end-to-end solution for creation of infrastructure and configuring appropriate packages required for the application.

**Introducing Provisioners**

Provisioners allow you to `execute scripts on a local or remote machine` as a part of resource creation or destruction.

Example: After VM is launched, install software package required for application.

### Type of Provisioners

**Setting the Base**

Provisioners are used to `execute scripts on a local or remote machine` as part of resource creation pr destruction.

There are 2-major types of provisioners:

1. `local-exec`
2. `remote-exec`
3. `file` - Minor

**Type 1 - local-exec provisioner**

The local-exec provisioner invokes a local executable after a resource is created.

Example: After EC2 instance is launched, fetch the `ip` and store it in file `server_ip.txt`

**Type 2 - remote-exec provisioner**

remote-exec provisioners allow to invoke scripts or run commands directly on the remote server.

Example: After EC2 is launched, install "apache" software

### Format of Provisioners

**Defining Provisioners** -

-   Provisioners are defined inside a specific resource.
-   Provisioners are defined by `provisioner` followed by the type od provisioner.

**Local Exec Provisioner Approach** -

-   For local provisioner, we have to specify the command that needs to be run locally.

**Remote Exec Provisioner Approach** -

-   Since commands executed are executed on remote-server, we have to provide way for terraform to connect to remote server.

**Points to Note** -

_Provisioners are Defined inside the Resource Block_

-   It is not necessary to define a `aws_instance` resource block for provisioner to run.
-   They can also be defined inside other resources types as well.

_Multiple Provisioner Blocks for Single Resources_

-   We can define multiple provisioners block in a single resource block.

### Creation-Time and Destroy-Time Provisioners

**Creation-Time Provisioners**

-   By default, provisioners run when the resources are defined within is created.
-   Creation-Time provisioners are `only run during creation`, not during updating or any other lifecycle.

**Destroy-Time Provisioners**

-   Destroy provisioner run before the provisioner is destroyed.
-   Example: Remove and De-link anti-virus software before EC2 get terminated.

**Tainting Resource in Creation-Time Provisioners**

-   If a creation-time provisioner fails, the resource is marked as tainted.
-   A tainted resource will be planned for destruction and recreation upon the next terraform apply.
-   Terraform does this because a failed provisioner can leave a resource in a semi-configured state.

### Failure Behavior for Provisioners

The `on_failure` setting can be used to change the default behavior.

| **Allowed Values** | **Description**                                                                                                 |
| :----------------- | --------------------------------------------------------------------------------------------------------------- |
| `continue`         | Ignore the error and continue with the creation or destruction.                                                 |
| `fail`             | Raise an error and stop applying (the default behavior). If this is a creation provisioner, taint the resource. |
