# Ensuring Quality Releases

This project demonstrates the automation of deploying a demo REST API on Microsoft Azure using Azure App Service and executing automated tests against the API. The infrastructure is provisioned using Terraform, and a CI/CD pipeline is set up for seamless integration and testing.

## How to use?
- Fork this repository to your Github account and clone it locally 

### Depencies
For this you'll need to install the following depencies

- Azure CLI
- Terraform
- JMeter
- Postman
- Python
- Selenium
- Chromedriver
- Chrome

### Instructions

1. sesion azure, You'll need to login in to your azure account before starting in any terminal you have open

![azure login](./img/az-login.png)

2. First, you need to update the variable defined in packer-image.json, you''ll need to replace:

```
    "subscription_id": "",
    "tenant_id": "",
    "client_id": "",
    "client_secret": "",   
    "resource_group_name": "",
    "image_name": "",
    "vm_size": ""
```

3. Configure the storage account and state backend for Terraform 

```bash
chmod +x configure-tfstate-storage-account.sh
```

```bash
./configure-tfstate-storage-account.sh
```

![azure login](./img/run-config-tfstate-sh.png)

### TERRAFORM

4. Replace the values in terraform/main.tf with the output from running the create-tf-storage.sh

```
terraform {
    backend "azurerm" {
        storage_account_name = ""
        container_name       = "tfstate"
        key                  = "test.terraform.tfstate"
        access_key           = ""
    }
}
```

5. Update the values in terraform.tfvars
    
    Generate an SSH keys in azure command shell
```
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub
```

    Put the keys in terraform/modules/vm/vm.tf
```
  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = "" 
  }
```

6. Terraform init

```bash
terraform init
```

![terraform init](./img/terraform-init.png)

7. Terraform Plan

```bash
terraform plan
```

![terraform init](./img/terraform-plan-1.png)
![terraform init](./img/terraform-plan-2.png)
![terraform init](./img/terraform-plan3.png)
![terraform init](./img/terraform-plan4.png)

8. Create packer template and run

```bash
    packer build packer.json
```
![packer](./img/packer-02.png)
![packer](./img/packer-01.png)
![packer](./img/packer-img-azure.png)

9. terraform apply

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

10. pipelane

- First you'll need to create a new project
- Then create a PAT and copy it to used it later
- Make a new service connection
- Create an agent pool with access to all pipelines, add this agent to a vm
- Create an enviroment and provide it to a different vm that the one used in the previus step
- Finally create a new pipeline, selecting the GitHub repository of this project, and for the yaml select azure-pipelines.yaml

Update the terraform variables with the ones created in those steps:

```
variables:
  python.version: ''
  azureServiceConnectionId: ''
  projectRoot: $(System.DefaultWorkingDirectory)
  environmentName: ''
  tfstatenumber: '' 
  tfrg: ''
  application_type: ''  
```

11. Build API artifact by archiving the entire FakeRestAPI directory into a zip file and publishing the pipeline artifact to the artifact staging directory

12. Deploy the API to the terraform deployed Azure App Service, the url will be
```http://[yourusername]-fakerestapi-appservice.azurewebsites.net/``` 

![Deploy api](./img/deployed_api.png)

13. Automated testing

### POSTMAN

- Data validation test
![regresion](./img/data-val-test.png)
- Regression test
![regresion](./img/regresion-test.png)

### JMETER

- Stress test
![stress](./img/stress_test.png)
![stress](./img/jmeter_endurace_report.png)
- Endurance test
![endurace](./img/endurace_test.png)
![endurace](./img/jmeter_report.png)
#### Functional UI testing selenium
![selenium](./img/selenium.png)

The pipeline execution should look like this

![pipelane ok](./img/pipelane-success.png)

### MONITOR

- Go to the Azure Portal and create a new alert in the monitoring group, then execute the pipeline to trigger an alert

Monitor chart
![Monitor](./img/monitor.png)

Trigger email alert

![Trigger](./img/trigger.png)

- Configure azure log analytics by downloading the selenium-test.log artifact from Azure Devops
- Navigate to the Azure Portal and access Azure Log Analytics workspaces. Configure an agent on the virtual machine where the Selenium testing will take place. Ensure the VM is connected to Log Analytics and establish a Data Collection Rule to capture the necessary logs.
- Navigate to the Logs section and initiate the creation of a custom log. Import the file named selenium-test.log. Choose "Timestamp" with the format YYYY-MM-DD HH:MM:SS as the record separator. Specify the path of the selenium-test.log from the VM where the task was executed as the collection path for logs (please note that there might be a delay before the VM can start collecting logs).

### LOGS

- Then go to logs in general group of your log analytics, select your custom log and run it
![Logs](./img/logs.png)