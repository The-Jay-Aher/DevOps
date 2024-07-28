# Terraform

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

    ```hcl
        variable "my-list" {
        type = "list"
        default = ["mumbai", "bangalore", "delhi"]
        }

    ```

-   set
-   map
    - A map data type represents a collection of key-value pair elements
-   null
