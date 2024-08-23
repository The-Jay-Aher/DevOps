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

-   Provisioners allow you to `execute scripts on a local or remote machine` as a part of resource creation or destruction.

-   Example: After VM is launched, install software package required for application.

### Type of Provisioners

**Setting the Base**

Provisioners are used to `execute scripts on a local or remote machine` as part of resource creation pr destruction.

There are 2-major types of provisioners:

1. `local-exec`
2. `remote-exec`
3. `file` - Minor

**Type 1 - local-exec provisioner**

-   The local-exec provisioner invokes a local executable after a resource is created.
-   Example: After EC2 instance is launched, fetch the `ip` and store it in file `server_ip.txt`

**Type 2 - remote-exec provisioner**

-   `remote-exec` provisioners allow to invoke scripts or run commands directly on the remote server.
-   Example: After EC2 is launched, install "apache" software

### Format of Provisioners

**Defining Provisioners**

-   Provisioners are defined inside a specific resource.
-   Provisioners are defined by `provisioner` followed by the type od provisioner.

**Local Exec Provisioner Approach**

-   For local provisioner, we have to specify the command that needs to be run locally.

**Remote Exec Provisioner Approach**

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

## Terraform Modules

### Basics of Terraform Modules

**Understanding the Basic** -

In software engineering, `don't repeat yourself` (DRY) is a principle of software development aimed at reducing repetition of software patterns.

**Challenges** -

1. Repetition of code.
2. Change in AWS Provider specific option will require change in EC2 code blocks all the teams.
3. Lack of standardization.
4. Difficulty to manage.
5. Difficult for developers to use.

**Better Approach** -

-   In this approach, the DevOps team has defined standard Ec2 template in a central location that all can use.

**Introducing Terraform Modules** -

-   Terraform Modules allows us to centralize the resource configuration and it makes it easier for multiple projects to re-use the Terraform code for projects.

Example -

```terraform
module "e2_instance" {
    source = "terraform-aws-modules/ec2-instance/aws"
}
```

**Multiple Modules for a Single Project**

-   Instead of writing code from scratch, we can use multiple ready-made modules available.

### Points to Note -

**Understanding the Base**

For some infrastructure resources, you can directly use the module calling code, and the entire infrastructure will be created for you.

**Avoiding Confusion**

-   Just by referencing any module, it is not always the case that the infrastructure will be created for you directly.
-   Some of the modules require specific inputs and values from the user side to be filled in before a resource gets created.

**Example Module - AWS EKS**

-   If you try to use an AWS EKS Module directly and run `terraform apply`, it will throw an `error`.

**Module Structure can be Different**

-   Some modules in GitHub can contain multiple sets of modules together for different features. In such cases, you have to reference the exact sub-module required.

### Choosing the right Terraform module

**Understanding the Base** -

Terraform registry can contain multiple modules for a specific infrastructure resource maintained by different users.

**1 - Check total downloads**

-   Module downloads can provide early indication of level of acceptance by users in the Terraform community.

**2 - Check the GitHub page of the Module**

-   GitHUb pages can provide important information related to the contributors, reported issues, and other data.

**3 - Avoid Modules written by individual participant**

-   Avoid module that are maintained by a single contributor as regular updates, issues and other areas might not always be maintained.

**4 - Analyze Module Documentation**

-   Good documentation must include an overview, usage instructions, input and output variables, and examples.

**5 - Check version history of Module**

-   Look at the version history. Frequent versions and a clear versioning strategy suggest active maintenance.

**6 - Analyze the Code**

-   Inspect the module's source code on GitHub or another platform. Clean, well-structured code us a good sign.

**7 - Check the community feedback**

-   The number of starts and forks on GitHub can indicate the popularity and community interest.

**8 - Modules maintained by the Hashicorp Partner**

-   Search for modules maintained by Hashicorp partners.

**Important Point to Note**

-   Avoid directly trying any random Terraform Module that is not actively maintained and looks shady(primarily by sole individual contributors)
-   An attacker can include malicious code in a module that sends information about environment to the attacker.

**Which modules do organizations use?**

-   In most scenarios, organizations maintain their own set of modules
-   They might initially fork a module from the Terraform Registry and modify it based on their use case.

### Creating Base Module Structure for custom module

**Understanding the Base**

-   A base `modules` folder.
-   A sub-folder containing name for each modules that are available.

**What is Inside each Sub-Folders**

-   Each module's sub-folder contains the actual module Terraform code that other projects can reference from.

**Calling the Module**

-   Each team can call various set of modules that are available in the modules folder based on their requirements.

**Our Practical Structure**

-   Our practical structure will include two main folders(modules and teams).
-   Modules sub-folder will contain sub-folder of modules that are available.
-   Teams sub-folder will contain list of teams that we want to be made available.

### Module Sources - Calling a Module

**Understanding the Base**

Module source code can be present in wide variety of locations.

These include:

1. GitHub
2. HTTP URLs
3. S3 Buckets
4. Terraform Registry
5. Local Paths

**Base- Calling the Module**

-   In order to reference the module, you need to make use of `module` block.
-   The module block must contain tha source argument that contains location to the referenced module.

**Example 1 - Local Paths**

-   Local paths are used to reference to module that is available in the filesystem.
-   A local path must begin with `./` or `../` to indicate that a local path.

**Example 2 - Generic Git Repository**

-   Arbitrary Git repositories can be used by prefixing with the special `git::` prefix.

    ```terraform
        module "vpc" {
            source = "git::https://example.com/vpc.git"
        }
    ```

**Module Version**

-   A specific module can have multiple versions
-   You can reference to specific version of module with the `version` block.

### Improvements in Custom Module Code

**Our Simple Module**

-   We had created a very simple module that allows developers to launch an EC2 instance when calling the module.

**Challenge 1 - Hardcoded Values**

-   The values are hardcoded as part of the module.
-   If developer is calling the module, he will have to stick with same values.
-   Developer will not be able to override the hardcoded values of the module.

**Challenge 2 - Provider Improvements**

-   Avoid hard-coding region in the Module code as much as possible.
-   A `required_provider` block with version control for module to work is important.

### Variables in Terraform Modules

**Convert Hard-Coded values to Variables**

-   For modules, it is especially recommended to convert hard-coded values to `variables` so that it can be overridden based on user requirement.

**Advantages of variables in module code**

-   Variable based approach allows teams to override the values.

**Reviewing Professional EC2 Module Code**

-   Reviewing an EC2 module code that is professionally written, we see that the values associate with arguments are not hardcoded and variables were used extensively.

### Module Outputs

**Revising Output Values**

-   `Output Values` make information about your infrastructure available on the command line, and can expose information for other Terraform configuration to use.

**Understanding the challenge**

-   If you want to create a resource that has an dependency on an infrastructure created through a module, you won't be able to implicitly call it without output values. In simpler terms, we can't get the ID of the instance while it's created, hence we create an output which helps us access the ID of the instance.

**Accessing Child Module Outputs**

-   Ensure that include output values in the output code for better flexibility and integration with other resources and projects.

**Revising Output Values**

-   `Output Values` make information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use.

**Accessing Child Module Outputs**

-   Ensure to include output values in the middle code for better flexibility and integration with other resources and projects.
-   Format : `module.<MODULE NAME>.<OUTPUT NAME>`

### Root Module v/s Child Module

**Root Module**

-   Root Module resides in the `main working directory of Terraform configuration`. This is the entry point for your infrastructure definition.

**Child Module**

-   A `module that has been called by another module` is often referred to as a child module.

### Standard Module Structure

**Setting the Base**

-   At this stage, we have been keeping the overall module structure very simple to understand the concepts.
-   In production environments, it is important to follow recommendation and best-practices set by HashiCorp.

**Basic of Standard Module Structure**

-   The `standard module structure` is a file and directory layout by HashiCorp recommends for re-usable models.

**Planning the Module Structure** -

-   In this scenario, a team of Terraform Producers, who write Terraform code from scratch, will build a collection of modules to provision the infrastructure and applications.
-   The members of the team in charge of the application will consume these modules to provision the infrastructure they need.

**Final Module Output** -

-   After reviewing the consumer team's requirement, the producer team has `broken up the application infrastructure in the following modules`:
    -   Network
    -   Web
    -   App
    -   Database
    -   Routing
    -   Security

### Publishing Modules in Terraform Registry

**Overview of Publishing Modules** -

-   Anyone can publish and share modules on the Terraform Registry.
-   Published modules support versioning, automatic generate documentation, allow browsing version histories, show examples, and READMEs and more.

**Requirement for Publishing Module** -

| **Requirement**           | **Description**                                                                                                                                                              |
| :------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| GitHub                    | The module must be on GitHub and must be a public repo. This is only a requirement for the public registry.                                                                  |
| Named                     | Module repository must use this three-part name format `terraform-<PROVIDER>-<NAME>`.                                                                                        |
| Repository Description    | The GitHub repository description is used to populate the short description of the module.                                                                                   |
| Standard Module Structure | The module must adhere to standard module structure.                                                                                                                         |
| x.y.x tags for releases   | The registry uses tags to identify module versions. Release tag names must be a semantic version, which can often be prefixed with a `v.`. For example, `v1.0.4` and `0.9.2` |

**Standard Module Structure** -

-   The standard module structure is a file and directory layout that is recommended for reuseable modules distributed in separate repositories.
-   There are 2 Primary formats -
    -   Minimal
    -   Complete

### Terraform Workspace

**Setting the Base** -

-   An infrastructure created through Terraform is `tied to the` underlying Terraform configuration in state file.

**What If?** -

-   What if we have multiple state files for single Terraform configuration?
-   Can we manage different env's through it separately?

**Introducing Terraform Workspaces** -

-   Terraform workspaces enable us to `manage multiple set of deployments from the same sets of configuration file`.

## Remote State Management

### Terraform and .gitignore

**Overview of gitignore** -

-   The `.gitignore` file is a text file that tells Git which files or folders to ignore in a project.
-   Depending on the environment, it is recommended to avoid committing certain files to GIT.

| **Files to Ignore** | **Description**                                                       |
| :------------------ | --------------------------------------------------------------------- |
| .terraform          | This file will be recreated when terraform init is run.               |
| terraform.tfvars    | Likely to contain secretive data like username/passwords and secrets. |
| terraform.tfstate   | Should be stored in the remote site.                                  |
| crash.log           | If terraform crashes, the logs are stored to file named `crash.log`   |

### Terraform Backend

**Basics of Backend** -

-   Backends primarily determine where Terraform stores it's state.
-   By default, Terraform implicitly uses a backend called local to store state as a local file on disk.

**Challenge with Local Backend** -

-   Nowadays project is handled and collaborated by an entire team.
-   Storing the state file in the local laptop will not allow collaboration.

**Ideal Architecture** -

Following describes one of the recommended architecture -

1. The Terraform code is stored in GIT Repository.
2. The state file is stored in central backend.

**Backends Supported in Terraform** -

-   Terraform supports multiple backends that allows remote service related operations.
-   Some of the popular backends include:
    -   S3
    -   Consul
    -   Azurerm
    -   Kubernetes
    -   HTTP
    -   ETCD

**Important Note** -

-   Accessing state in a remote service generally requires some kind of access credentials
-   Some backends act like plain "remote disks" for state files; other support locking the state while operations are being performed, which helps prevent conflict and inconsistencies.
