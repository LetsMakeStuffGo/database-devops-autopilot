---
layout: splash
title: "Lab 2: Repository Configuration"
description: "Flyway project setup and Git integration for version control"
toc: true
toc_label: "Lab Steps"
toc_icon: "tasks"
prev_lab:
  title: "Lab 1: Environment Setup"
  url: "/database-devops-autopilot/training/flyway-autopilot/labs/lab1-environment-setup"
next_lab:
  title: "Lab 3: Database Provisioning"
  url: "/database-devops-autopilot/training/flyway-autopilot/labs/lab3-database-provisioning"
---

## Overview

In this lab, you'll clone the official Database DevOps AutoPilot training repository and set it up with Flyway Desktop for AutoPilot functionality. This repository contains a complete e-commerce platform example with migrations, schema models, and CI/CD pipelines.

## Learning Objectives

- Clone the official training repository from GitHub
- Connect the repository to Flyway Desktop
- Understand the project structure and configuration
- Configure environment variables for Azure SQL Database
- Handle initial setup and connection configuration

## Prerequisites

- Completed Lab 1 (Flyway Desktop Enterprise installed with 28-day trial)
- Git 2.30+ installed and configured
- Access to Azure SQL Database (provided in training)
- GitHub account (optional, for forking)

## Step 1: Fork and Clone the Training Repository

### 1. Fork the Repository (Create Your Own Copy)

First, you'll create your own copy of the training repository on GitHub:

1. **Go to the training repository**: [https://github.com/LetsMakeStuffGo/database-devops-autopilot](https://github.com/LetsMakeStuffGo/database-devops-autopilot)
2. **Click the "Fork" button** in the top-right corner of the page
3. **Choose your GitHub account** as the destination for the fork
4. **Wait for GitHub to create your fork** - this creates `https://github.com/yourusername/database-devops-autopilot`

> **Why Fork?** This creates your own copy that you can modify, commit to, and use throughout all the labs. It's the standard workflow for contributing to projects and gives you full control over your learning environment.

### 2. Clone Your Forked Repository

Now clone YOUR forked version to your local machine:

```bash
# Clone YOUR forked repository (replace 'yourusername' with your actual GitHub username)
git clone https://github.com/yourusername/database-devops-autopilot.git

# Navigate to the project directory
cd database-devops-autopilot

# Verify the repository structure
ls -la
```

> **Important**: Make sure you're cloning from YOUR GitHub account (yourusername), not the original LetsMakeStuffGo account!

### 3. Verify Your Fork Setup

Confirm everything is set up correctly:

```bash
# Check your remote repository configuration
git remote -v

# You should see something like:
# origin  https://github.com/yourusername/database-devops-autopilot.git (fetch)
# origin  https://github.com/yourusername/database-devops-autopilot.git (push)
```

**Perfect!** You now have:
✅ Your own fork of the training repository  
✅ Full read/write access to commit and push changes  
✅ A complete local copy ready for Flyway Desktop  
✅ The ability to use Git throughout all labs

### 4. Explore the Repository Structure

After cloning, explore what you've downloaded:

```bash
# View the main directory structure
tree -L 2
# or use: ls -la
```

You should see a structure like this:

```
database-devops-autopilot/
├── README.md                          # Project documentation
├── 1.flyway-desktop.toml              # Flyway Desktop configuration
├── 2.flyway-pipeline.toml             # CI/CD pipeline configuration
├── migrations/                        # Database migration scripts
│   ├── B001__baseline.sql             # E-commerce platform baseline
│   ├── V002__Welcome.sql              # Welcome migration
│   ├── V003__Add_Customer_Loyalty.sql # Customer loyalty features
│   └── V004__Enhanced_Product_Catalog.sql # Product reviews system
├── Scripts/                           # Database setup scripts
│   ├── CreateAutopilotDatabases.sql   # Database creation script
│   └── SetupSchemas.sql               # Schema setup script
├── Reports/                           # Migration reports output
├── schema-model/                      # Schema model files
│   ├── Security/Schemas/              # Schema definitions
│   ├── Stored Procedures/             # Stored procedure definitions
│   ├── Tables/                        # Table definitions
│   └── Views/                         # View definitions
├── .github/workflows/                 # GitHub Actions CI/CD pipelines
└── training/                          # Training materials and labs
    └── flyway-autopilot/
        └── labs/                      # Lab instructions (this file!)
```

### 5. Understanding the Repository Components

This forked repository contains everything you need for Database DevOps with Flyway AutoPilot:

**🗄️ Database Components:**

- **E-commerce platform** with customers, products, orders, and loyalty program
- **Sample data** from international customers and real products
- **Business intelligence views** for analytics and reporting
- **Stored procedures** for business operations

**🔧 DevOps Components:**

- **Multiple Flyway configurations** for different environments
- **CI/CD pipeline templates** for GitHub Actions and Azure DevOps
- **Schema model** for change tracking and collaboration
- **Migration reports** for deployment validation

**📚 Training Materials:**

- **Step-by-step labs** for hands-on learning
- **Documentation and guides** for best practices
- **Reference implementations** following Redgate patterns
- Git 2.30+ installed

## Step 2: Review Flyway Configuration

### 1. Understanding the Two Configuration Files

The repository contains two main Flyway configuration files for different use cases (If not exists, you can create one):

#### Configuration 1: Flyway Desktop Development

**File: `1.flyway-desktop.toml`** - Used for Flyway Desktop development and testing

```toml
id = "database-devops-autopilot-local"
name = "Database DevOps AutoPilot (Local Development)"
databaseType = "SqlServer"

[environments.development]
url = "jdbc:sqlserver://your-server.database.windows.net:1433;databaseName=db-autopilot-dev-001;encrypt=true;trustServerCertificate=false"
user = "sqladmin"
password = "YourPassword123!"
displayName = "Development Database"

[environments.shadow]
url = "jdbc:sqlserver://your-server.database.windows.net:1433;databaseName=db-autopilot-shadow-001;encrypt=true;trustServerCertificate=false"
user = "sqladmin"
password = "YourPassword123!"
displayName = "Shadow Database (Validation)"
provisioner = "clean"

[environments.uat]
url = "jdbc:sqlserver://your-server.database.windows.net:1433;databaseName=db-autopilot-uat-001;encrypt=true;trustServerCertificate=false"
user = "sqladmin"
password = "YourPassword123!"
displayName = "UAT Database"

[environments.production]
url = "jdbc:sqlserver://your-server.database.windows.net:1433;databaseName=db-autopilot-prod-001;encrypt=true;trustServerCertificate=false"
user = "sqladmin"
password = "YourPassword123!"
displayName = "Production Database"

[flyway]
locations = [ "filesystem:migrations" ]
mixed = true
outOfOrder = true
validateMigrationNaming = true
defaultSchema = "Customers"
baselineOnMigrate = true
baselineVersion = "001"
errorOverrides = [ "S0001:0:I-" ]

[flywayDesktop]
developmentEnvironment = "development"
shadowEnvironment = "shadow"
schemaModel = "./schema-model"

[flywayDesktop.generate]
undoScripts = true
```

````

**✅ Use this configuration for:**

- **Flyway Desktop** development and testing
- **Local command line** Flyway operations
- **Training exercises** and hands-on labs
- **Quick database connections** without environment setup

#### Configuration 2: CI/CD Pipelines (Production)

**File: `2.flyway-pipeline.toml`** - Used for CI/CD pipelines and production deployments

```toml
id = "database-devops-autopilot-training"
name = "Database DevOps AutoPilot Training"
databaseType = "SqlServer"

[environments.development]
url = "jdbc:sqlserver://${env.AZURE_SQL_SERVER}.database.windows.net:1433;databaseName=${env.FLYWAY_DEV_DATABASE};encrypt=true;trustServerCertificate=false"
user = "${env.AZURE_SQL_USER}"
password = "${env.AZURE_SQL_PASSWORD}"
displayName = "Development database"
provisioner = "clean"

[environments.shadow]
url = "jdbc:sqlserver://${env.AZURE_SQL_SERVER}.database.windows.net:1433;databaseName=${env.FLYWAY_SHADOW_DATABASE};encrypt=true;trustServerCertificate=false"
user = "${env.AZURE_SQL_USER}"
password = "${env.AZURE_SQL_PASSWORD}"
displayName = "Shadow database (validation)"
provisioner = "clean"

[environments.uat]
url = "jdbc:sqlserver://${env.AZURE_SQL_SERVER}.database.windows.net:1433;databaseName=${env.FLYWAY_UAT_DATABASE};encrypt=true;trustServerCertificate=false"
user = "${env.AZURE_SQL_USER}"
password = "${env.AZURE_SQL_PASSWORD}"
displayName = "UAT (User Acceptance Testing) database"

[environments.production]
url = "jdbc:sqlserver://${env.AZURE_SQL_SERVER}.database.windows.net:1433;databaseName=${env.FLYWAY_PROD_DATABASE};encrypt=true;trustServerCertificate=false"
user = "${env.AZURE_SQL_USER}"
password = "${env.AZURE_SQL_PASSWORD}"
displayName = "Production database"

[flyway]
locations = [ "filesystem:migrations" ]
mixed = true
outOfOrder = true
validateMigrationNaming = true
defaultSchema = "Customers"
baselineOnMigrate = true
baselineVersion = "001"
errorOverrides = [ "S0001:0:I-" ]

[flywayDesktop]
developmentEnvironment = "development"
shadowEnvironment = "shadow"
schemaModel = "./schema-model"

[flywayDesktop.generate]
undoScripts = true
````

**🚀 Use this configuration for:**

- **GitHub Actions** workflows
- **CI/CD pipelines**
- **Production deployments**
- **Environment variable** based credential management
- **Team collaboration** with secure secrets

### 2. Configuration Comparison

Here's a quick comparison of the two configurations:

| Feature          | Flyway Desktop (`1.flyway-desktop.toml`) | CI/CD Pipeline (`2.flyway-pipeline.toml`) |
| ---------------- | ---------------------------------------- | ----------------------------------------- |
| **Primary Use**  | Flyway Desktop & Development             | GitHub Actions & CI/CD Pipelines          |
| **Credentials**  | Hardcoded (example values)               | Environment Variables (secure)            |
| **Environments** | 4 (dev, shadow, uat, production)         | 4 (dev, shadow, uat, production)          |
| **Security**     | ⚠️ Training only                         | ✅ Production ready                       |
| **Team Sharing** | ❌ Contains passwords                    | ✅ Uses secrets                           |
| **Best For**     | Learning & Development                   | Production Deployment                     |

> **For this training**, we'll use `1.flyway-desktop.toml` with Flyway Desktop for hands-on learning, then explore `2.flyway-pipeline.toml` to understand production patterns.

> **Note**: This configuration uses Azure SQL Database with environment variables for secure credential management. The environment variables (${env.VARIABLE_NAME}) are resolved at runtime from:
>
> - GitHub Secrets (in CI/CD pipelines)
> - Local environment variables (for local development)
> - Flyway Desktop credential management

### 2. Review the Repository Structure

Your repository already contains all the necessary files and directories for Flyway AutoPilot:

```
database-devops-autopilot/
├── flyway.toml                    # Main Flyway configuration
├── migrations/                    # Database migration scripts
│   ├── B001__baseline.sql         # Baseline migration
│   ├── V002__Welcome.sql          # Sample versioned migration
│   ├── V003__Add_Customer_Loyalty.sql     # Customer loyalty features
│   ├── V004__Enhanced_Product_Catalog.sql # Product catalog enhancements
│   ├── U002__UNDO-Welcome.sql     # Undo script for V002
│   ├── U003__UNDO-Add_Customer_Loyalty.sql # Undo script for V003
│   └── U004__UNDO-Enhanced_Product_Catalog.sql # Undo script for V004
├── Scripts/                       # Database setup scripts
│   └── CreateAutopilotDatabases.sql
├── Reports/                       # Migration reports output
├── schema-model/                  # Schema model files
│   ├── Security/Schemas/
│   ├── Stored Procedures/
│   ├── Tables/
│   └── Views/
├── .github/workflows/             # GitHub Actions CI/CD
```

### 3. Review the Migration Files

The repository already contains the initial migration files for training:

**migrations/B001\_\_baseline.sql** - Baseline migration:

**migrations/V002\_\_Welcome.sql** - Welcome migration:

**migrations/V003\_\_Add_Customer_Loyalty.sql** - Customer loyalty features:

```sql
-- V003: Customer Loyalty Program Enhancement
-- Adding exciting customer loyalty features to boost engagement!
```

**migrations/V004\_\_Enhanced_Product_Catalog.sql** - Product catalog enhancements:

```sql
-- V004: Enhanced Product Catalog
-- Adding product reviews and inventory tracking
```

**Corresponding Undo Scripts:**

- **U002\_\_UNDO-Welcome.sql** - Undo script for V002
- **U003\_\_UNDO-Add_Customer_Loyalty.sql** - Undo script for V003
- **U004\_\_UNDO-Enhanced_Product_Catalog.sql** - Undo script for V004

> **Note**: Additional migration files (V005+) will be created during the hands-on labs to demonstrate the migration workflow.

### 4. Database Setup and Credentials

**📋 Databases and Credentials Provided**

For this training, Hamish will provide you with individual database names and credentials to avoid server overload. You'll receive:

- **Server name** (Azure SQL Database server)
- **Username and password** for your training account
- **Individual database names** for each environment:
  - Development database (e.g., `db-autopilot-dev-xxx`)
  - Shadow database (e.g., `db-autopilot-shadow-xxx`)
  - UAT database (e.g., `db-autopilot-uat-xxx`)

**🔧 Update Your Configuration**

Once you receive your credentials, update your `1.flyway-desktop.toml` file with your assigned values:

```toml
[environments.development]
url = "jdbc:sqlserver://your-assigned-server.database.windows.net:1433;databaseName=your-assigned-dev-db;encrypt=true;trustServerCertificate=false"
user = "your-assigned-username"
password = "your-assigned-password"
```

> **Note**: This approach ensures stable performance during training and gives everyone their own isolated environment to work with.

## Benefits of the Fork + Personal Database Approach

This training setup gives you the best of both worlds:

**✅ Your Own Repository (via Fork):**

- Full Git control - commit, push, and track your progress
- Personal learning space you can modify freely
- Real-world GitHub workflow experience
- All labs work seamlessly (especially Lab 4 version control)
- Your work becomes part of your portfolio

**✅ Your Own Database Environment (via Hamish):**

- Isolated databases prevent server crashes
- No interference from other students
- Realistic multi-environment setup
- Personalized learning experience

**🎯 Professional Workflow**: This fork → personal databases → commit → push approach mirrors exactly how you'll work in professional development teams!## Step 3: Connect Repository to Flyway Desktop

### 1. Open Project in Flyway Desktop

1. Launch **Flyway Desktop**
2. Click **"Open project..."**
3. Select **"Open local file"**
4. Navigate to your **cloned repository folder** (`database-devops-autopilot`)
5. Select the **existing** `1.flyway-desktop.toml` file
6. Click **"Open"**

![Find Toml File](../../../assets/images/Find_Toml.png)

> **Note**: You now have a local copy of the complete training repository with all migrations, schema models, and configurations ready for use!

### 2. Success! Flyway Desktop Connected

If you've updated your `1.flyway-desktop.toml` file with the correct credentials provided by Hamish, Flyway Desktop should connect successfully and show you the main interface with:

- **Schema model view** showing your database structure

### 3. If You See Connection Errors

**Only if you haven't updated your credentials yet**, you might see connection errors. This happens when:

- You're still using the example credentials (`your-server.database.windows.net`, `YourPassword123!`)
- Your assigned databases haven't been created yet
- Network connectivity issues

**Quick Fix**: Double-check that you've updated your `1.flyway-desktop.toml` file with the real credentials provided by Hamish.

### 3. Explore the Project Structure

Now click the **blue folder icon** in the upper right to jump to the files on disk and explore what you've cloned:

```
database-devops-autopilot/
├── 1.flyway-desktop.toml              # Flyway Desktop configuration
├── 2.flyway-pipeline.toml             # CI/CD pipeline configuration
├── migrations/                        # Database migration scripts
│   ├── B001__baseline.sql             # E-commerce platform baseline
│   ├── V002__Welcome.sql              # Welcome migration
│   ├── V003__Add_Customer_Loyalty.sql # Customer loyalty features
│   └── V004__Enhanced_Product_Catalog.sql # Product reviews system
├── Scripts/                           # Database setup scripts
│   └── CreateAutopilotDatabases.sql   # Database creation script
├── Reports/                           # Migration reports output
├── schema-model/                      # Schema model files
│   ├── Security/                      # Schema security objects
│   ├── Stored Procedures/             # Stored procedure definitions
│   ├── Tables/                        # Table definitions
│   └── Views/                         # View definitions
├── .github/workflows/                 # GitHub Actions CI/CD
├── assets/                            # Web assets (CSS, images, JS)
├── docs/                              # Additional documentation
└── training/flyway-autopilot/         # Training materials (including these labs!)
```

This is a complete, production-ready Database DevOps repository that demonstrates:

- **Multi-environment configuration** (development, shadow, UAT, production)
- **CI/CD pipeline integration** (GitHub Actions + Azure DevOps)
- **Schema model management** for collaboration

### 4. Key Configuration Features

The flyway.toml includes important AutoPilot features:

- **Four Environments**: Development, Shadow, UAT, and Production
- **Azure SQL Database**: Cloud-hosted SQL Server instances
- **Environment Variables**: Secure credential management using ${env.VARIABLE_NAME} syntax
- **Shadow Database**: Dedicated environment for schema validation
- **Default Schema**: Set to "Customers"
- **Error Overrides**: Configured for SQL Server best practices
- **Flyway Desktop Integration**: Configured for development environment and schema modeling
- **CI/CD Ready**: Environment variables can be set via GitHub Secrets or local environment

## Next Steps

Now that you've successfully connected your repository to Flyway Desktop:

1. **Next Lab**: Lab 3 - Provisioning Your Databases

   - You'll use SQL Server Management Studio (SSMS) or your prefeered IDE to provision the databases
   - Follow the official Redgate guidance for database setup
   - Connect your AutoPilot environments to real databases

2. **What You've Accomplished**:
   - ✅ Repository connected to Flyway Desktop
   - ✅ Project structure understood
   - ✅ Configuration reviewed and validated

## Database Environments Overview

Your configuration is ready with these environments, this is for `2.flyway-pipeline.toml` (using Azure SQL Database):

| Environment | Purpose                  | Environment Variable   | Example Database Name   |
| ----------- | ------------------------ | ---------------------- | ----------------------- |
| development | Primary development work | FLYWAY_DEV_DATABASE    | db-autopilot-dev-xxx    |
| shadow      | Schema validation        | FLYWAY_SHADOW_DATABASE | db-autopilot-shadow-xxx |
| uat         | User Acceptance Testing  | FLYWAY_UAT_DATABASE    | db-autopilot-uat-xxx    |
| production  | Production deployment    | FLYWAY_PROD_DATABASE   | db-autopilot-prod-xxx   |

### Required Environment Variables

For this configuration to work, you need to set the following environment variables:

```bash
# Azure SQL Server Configuration
AZURE_SQL_SERVER=your-server-name          # Without .database.windows.net suffix
AZURE_SQL_USER=your-username
AZURE_SQL_PASSWORD=your-password

# Database Names
FLYWAY_DEV_DATABASE=db-autopilot-dev-xxx
FLYWAY_SHADOW_DATABASE=db-autopilot-shadow-xxx
FLYWAY_UAT_DATABASE=db-autopilot-uat-xxx
FLYWAY_PROD_DATABASE=db-autopilot-prod-xxx
```

## Reference Materials

This lab uses your forked copy of the official Database DevOps AutoPilot training repository:

- **[Your Forked Repository](https://github.com/yourusername/database-devops-autopilot)** - Your own copy for hands-on learning
- **[Original Training Repository](https://github.com/LetsMakeStuffGo/database-devops-autopilot)** - The source repository you forked from
- **[Official SQL Server FastTrack](https://github.com/red-gate/Flyway-AutoPilot-FastTrack)** - Reference implementation patterns
- **[Official Repository Setup Guide](https://documentation.red-gate.com/flyway/getting-started-with-flyway/first-steps-flyway-autopilot-a-beginners-guide/flyway-autopilot-fasttrack/2-getting-your-repository-ready)**
- **[Flyway Desktop Documentation](https://documentation.red-gate.com/flyway/getting-started-with-flyway/installers)**

## 🔗 Navigation

**⬅️ [Previous: Lab 1 - Environment Setup](/database-devops-autopilot/training/flyway-autopilot/labs/lab1-environment-setup)** | **🏠 [Workshop Overview](/database-devops-autopilot/training/flyway-autopilot/labs/)** | **➡️ [Next: Lab 3 - Database Provisioning](/database-devops-autopilot/training/flyway-autopilot/labs/lab3-database-provisioning)**

---
