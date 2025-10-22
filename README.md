
"modules/" = directory contains individual modules to abstract and reuse infrastructure definitions.
"dev.tf", "uat.tf", and "prod.tf"  = These are environment-specific root Terraform configurations that make use of these modules.

Features:
- Modular design = decouples infrastructure components into reusable modules.
- Environment segregation = separate configuration files ("dev", "uat", "prod") for different stages.
- Azure provider usage with the "azurerm" provider (Azure Resource Manager).
- Demonstrates best practices for infrastructure-as-code with Terraform and Azure.

Prerequisites:
- Terraform (version compatible with used provider, e.g., ">= 1.x").
- Azure account and sufficient permissions (to create resource groups, virtual networks, subnets, etc.). But I have just checked locally using "validate" command.
- Azure CLI or Service Principal credentials for authentication.

Why Modules?
Improve reusability and maintainability: define once, use many times.
Environment consistency: dev/uat/prod share similar definitions, differing only in variables.
Better state management and resource lifecycle control.
Promotes best practices of infrastructure as code (IaC).
