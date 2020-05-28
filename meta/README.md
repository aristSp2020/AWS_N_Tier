# This structure ISN'T LOCKED (it's META)
# BE CAREFUL


At the very first time, terraform.backend.tf mustn't be
```
terraform init
terraform plan
terraform apply  #yes to apply
```

### Then,
```
cp terraform.backend.tff terraform.backend.tf
terraform init    #yes to copy the backend in the working directory.
terraform plan
rm terraform.tfstate terraform.tfstate.backup
```
