# Project Starter
This repository contains the starter code for the **Ensuring Quality Releases** project of the cd1807 Ensuring Quality Releases (Quality Assurance) course taught by Nathan Anderson. 


## How to use?
- Fork this repository to your Github account and clone it locally for further development. 
- Follow the classroom instructions, and check the rubric before a submission. 

## Suggestions and Corrections
Feel free to submit PRs to this repo should you have any proposed changes. 




#### BORRADOR ######

1. sesion azure

![azure login](./img/az-login.png)

2. Configure the storage account and state backend for Terraform 

```bash
chmod +x configure-tfstate-storage-account.sh
```

```bash
./configure-tfstate-storage-account.sh
```

![azure login](./img/run-config-tfstate-sh.png)

3. Terraform init

```bash
terraform init
```

![terraform init](./img/terraform-init.png)

4. Terraform Plan

```bash
terraform plan
```

![terraform init](./img/terraform-plan-1.png)
![terraform init](./img/terraform-plan-2.png)
![terraform init](./img/terraform-plan3.png)
![terraform init](./img/terraform-plan4.png)

3. Create packer template and run

```bash
    packer build packer.json
```
![packer](./img/packer-02.png)
![packer](./img/packer-01.png)
![packer](./img/packer-img-azure.png)

4. terraform apply

if you have already a group yo need o run 

```bash
terraform import azurerm_resource_group.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1
```
![terraform import](./img/import-terraform.png)

 run 
 ```bash
    terraform apply
 ```
 ![terraform apply](./img/terraform-apply.png)

 azure with your resource group looks like this

 ![terraform apply](./img/azure-terr.png)