# Databricks Infrastructure as Code

Sandboxing infrastructure code for Databricks workspaces, Unity Catalog, and access controls.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Folder Structure](#folder-structure)
- [Getting Started](#getting-started)
- [Module Documentation](#module-documentation)
- [Access Control Configuration](#access-control-configuration)
- [Usage Examples](#usage-examples)

---

## Overview

This repository manages Databricks infrastructure using:
- **Terraform** for infrastructure provisioning
- **Terragrunt** for DRY configuration management
- **YAML-based access control** for Unity Catalog permissions

### Key Features

- **Unity Catalog Management**: Automated catalog and schema provisioning for DEV/PROD environments
- **Role-Based Access Control**: YAML-driven permissions for read-only and read-write access
- **Cluster Policies**: Standardized compute policies with team-specific configurations
- **Multi-Environment Support**: Separate DEV and PROD catalogs with environment-specific access controls

---

## Prerequisites

### Required Tools

1. **Terraform** (>= 1.0.0)
   ```bash
   brew install terraform
   # Verify installation
   terraform --version
   ```

2. **Terragrunt** (>= 0.50.0)
   ```bash
   brew install terragrunt
   # Verify installation
   terragrunt --version
   ```

## Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd databricks-infra
```

### 2. Set Up Authentication
Set up authentication using one of the following methods: https://registry.terraform.io/providers/databricks/databricks/latest/docs#authentication
This project uses variables defined in ```terraform.tfvars```

For the POC, the admin service principal was created in the UI with the following permissions:
- **Account Admin** (for workspace-level resources)
- **Metastore Admin** (for Unity Catalog operations)
- **Cluster creation** privileges
- **Group management** permissions

### 3. Initialize Terraform

```bash
cd workspace
terraform init
```

### 4. Review the Plan

```bash
terraform plan
```

### 5. Apply Infrastructure

```bash
terraform apply
```

---
## Hypothesis
The goal is to be able to create a name-space representing a mart using a single module that automatically sets up:
1) ```DEV``` and ```PROD``` catalogs with default bronze/silver/gold schemas
2) Roles and permissions for the catalog determined based on the access_config.yaml
3) Default cluster access and policies 

## Folder Structure

```
databricks-infra/
├── accounts/                          # WIP
│   └── (account admin configurations)
│
└── workspace/                         # Workspace-level resources
    ├── _modules/                      # Workspace modules
    │   ├── catalogs/                  # Unity Catalog module
    │   │
    │   ├── cluster_policies/          # Cluster policy module
    │   │   ├── generic_policies.tf    # Policy definitions
    │   │   ├── variables.tf
    │   │   └── version.tf
    │   │
    │   ├── cluster-access/            # Cluster permissions module
    │   │   ├── main.tf
    │   │   ├── variables.tf
    │   │   └── version.tf
    │   │
    │   ├── marts/                     # Data mart module (creates DEV/PROD catalogs)
    │   │   ├── catalog.tf             # Calls catalog module for DEV/PROD
    │   │   ├── variables.tf           # Mart configuration
    │   │   ├── outputs.tf             # Exposes catalog names
    │   │   └── version.tf
    │   │
    │   └── uc-schema-access/          # Unity Catalog access control module
    │
    └── marts/                         # Primary folder for mart creation using modules in ../_modules/
        └── finance/                   # Finance team as sample
```

### Key Directories

- **`_modules/`**: Reusable Terraform modules that can be consumed by multiple teams
- **`marts/`**: Team-specific implementations that use the shared modules

---


## Access Control Configuration

### YAML-Based Access Control

#### Privilege Levels

- **RO (Read-Only)**:
  - `USE_CATALOG` on the catalog
  - `USE_SCHEMA` on specified schemas
  - `SELECT` on all tables in the schemas

- **RW (Read-Write)**:
  - `USE_CATALOG` on the catalog
  - `USE_SCHEMA` on specified schemas
  - `SELECT`, `MODIFY`, `CREATE_TABLE` on all tables in the schemas

---

