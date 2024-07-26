# Terraform

## Variable Assignment

If I have a `*.tfvars` file with different name, other than default `terraform` then -

```powershell
terraform plan --var="instance_type=t2.micro"
```

Here the `instance_type` is the name of the variable
