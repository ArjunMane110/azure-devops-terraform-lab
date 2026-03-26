# Azure DevOps Terraform Lab

Enterprise-grade Azure infrastructure automation using Terraform IaC 
and Azure DevOps CI/CD pipelines. Built as a hands-on DevOps 
engineering portfolio project.

---

## Architecture Overview

Multi-environment infrastructure (dev and prod) deployed through 
a branch-based promotion pipeline:
```
feature/* → PR → dev branch → auto-deploy to DEV
dev → PR → main → approval gate → deploy to PROD
```

---

## Infrastructure

Each environment contains:

| Resource | Purpose |
|---|---|
| Resource Group | Environment isolation |
| Virtual Network + Subnet | Network foundation |
| Network Security Group | Traffic control |
| Windows VM (Standard_D2s_v3) | Compute workload |
| Load Balancer (Standard) | Traffic distribution |
| VM Scale Set | Auto-scaling compute |
| Storage Account | Blob storage |
| Key Vault | Secret management |
| Log Analytics Workspace | Centralised monitoring |
| Azure Policy | Governance enforcement |

---

## Pipeline Architecture

| Pipeline | Trigger | Purpose |
|---|---|---|
| terraform-plan | PR to dev or main | Validate + Plan |
| terraform-apply | Push to dev or main | Auto-deploy |
| terraform-apply-prod | Manual on main | Prod deployment |
| terraform-tag-audit | Daily 6PM IST | Tag compliance |

---

## Module Structure
```
modules/
  vnet/          VNet and Subnet
  vm/            Windows VM, NIC, Public IP, Auto-shutdown
  nsg/           NSG with configurable security rules
  storage/       Storage Account
  keyvault/      Key Vault with access policies
  log_analytics/ Log Analytics Workspace
  loadbalancer/  Standard LB with backend pool and health probe
  vmss/          Windows VM Scale Set
  policy/        Azure Policy assignments
```

---

## Pipeline Flow Detail

### Plan Pipeline (PR Gate)
Triggers on every PR to dev or main. Runs Terraform init, 
validate and plan. PR cannot merge until pipeline passes.

### Apply Pipeline (Auto-Deploy)
Triggers on merge to dev or main. Detects target environment 
from branch name. Runs plan then applies automatically.

### Prod Pipeline (Manual)
Dedicated pipeline for prod deployments. Hardcoded to prod 
environment and prod state file. Run manually after dev validation.

### Tag Audit (Scheduled)
PowerShell script scans all resources daily and reports 
non-compliant resources missing required tags. Publishes 
CSV report as pipeline artifact.

---

## Setup Guide

### Prerequisites
- Azure subscription
- Azure DevOps organisation and project
- Azure CLI

### Steps
1. Create storage account for Terraform state
2. Create Azure DevOps service connection
3. Create variable group `terraform-dev-vars` with state backend details
4. Register pipelines from `.azure-pipelines/`
5. Configure `dev-environment` and `prod-environment` in Azure DevOps
6. Copy `terraform.tfvars.example` to `terraform.tfvars` and fill values
7. Run plan pipeline via PR
8. Merge to trigger apply

---

## Known Limitations

### VM Scale Set
VMSS module is fully implemented. Deployed with 0 instances 
due to free subscription core quota limits (4 cores, Central US). 
In a paid subscription set `instance_count = 1` or higher.

### Azure Bastion and Application Gateway
Not deployed due to cost constraints on free subscription 
(Bastion ~$140/month, App Gateway ~$120/month). 
Terraform modules can be added following the same pattern 
as existing modules.

---

## Technologies

Azure DevOps | Terraform | Azure | PowerShell | Git | YAML Pipelines

---

## Author

Arjun Mane — Azure Cloud & DevOps Engineer  
[LinkedIn](https://www.linkedin.com/in/arjun-mane-915ba4183/)
