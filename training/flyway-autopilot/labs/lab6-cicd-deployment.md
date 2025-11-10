---
layout: splash
title: "Lab 6: CI/CD Deployment"
description: "GitHub Actions pipeline implementation for automated deployments"
toc: true
toc_label: "Lab Steps"
toc_icon: "tasks"
prev_lab:
  title: "Lab 5: Migration Script Generation"
  url: "/database-devops-autopilot/training/flyway-autopilot/labs/lab5-migration-script-generation"
next_lab:
  title: "Course Summary"
  url: "/database-devops-autopilot/training/flyway-autopilot/course-summary"
---

## Overview

Now that you've committed your V005 wishlist migration scripts to your GitHub repository (Lab 5), it's time to set up continuous integration and deployment (CI/CD) using GitHub Actions. This setup will automatically deploy your database changes across all environments, ensuring a smooth and consistent deployment process from development through to production.

## Learning Objectives

- Understand GitHub Actions for database CI/CD automation
- Configure self-hosted runners for Flyway deployment execution
- Set up Personal Access Tokens (PATs) for secure Flyway authentication
- Configure environment-specific database connection secrets
- Deploy wishlist feature to UAT environment using automated pipelines
- Monitor deployment progress and review deployment reports

## Prerequisites

- Completed Lab 5 (V005 migration scripts committed to GitHub)
- GitHub repository with your Flyway project
- Access to create self-hosted runners in GitHub
- Redgate Portal account with Flyway Enterprise license
- UAT database (`db-autopilot-uat-001`) configured and accessible

## Step 1: Navigate to GitHub Actions

### 1. Enable GitHub Actions

1. **Go to your GitHub repository** where your Flyway project is hosted
2. **Click on "Actions"** in the top menu
3. **Enable GitHub Actions** if prompted (you may need repository admin permissions)

### 2. Locate the Workflow Files

Your repository should already contain pre-configured workflow files for different operating systems:

1. **Navigate to `.github/workflows` folder** in your repository
2. **Review the available YAML files**:
   - `GitHub-Flyway-CICD-Pipeline_Windows.yml` - For Windows self-hosted runners
   - `GitHub-Flyway-CICD-Pipeline_Linux.yml` - For Linux self-hosted runners
   - `GitHub-Flyway-CICD-Pipeline_macOS.yml` - For macOS self-hosted runners

**Important:** Do not run any workflows yet - we need to configure the runner and authentication first.

## Step 2: Configuring Your Self-Hosted Runner

### 1. Add a Self-Hosted Runner

1. **Navigate to Settings** in your GitHub repository
2. **In the left-hand menu, click "Actions"** then **"Runners"**
3. **Click "New self-hosted runner"**

![GitHub Workflows](../../../assets/images/labs/lab6-cicd.png)

### 2. Follow Installation Instructions

1. **Select your operating system** (Windows, Linux, or macOS)
2. **Follow the provided instructions** to:
   - Download the runner application
   - Configure the runner with your repository
   - Install as a service (recommended for production)

![GitHub Runner Config](../../../assets/images/labs/lab6-cicd_2.png)

### 3. Verify Runner Installation

1. **Once installed, return to the Runners page**
2. **Verify your runner appears** as "Idle" status
3. **Note the runner name** for workflow configuration

**The self-hosted runner will execute all Flyway commands in your CI/CD pipeline.**

## Step 3: Adding Personal Access Token (PAT)

### 1. Create a Personal Access Token

A valid Flyway license is required for pipeline authentication. Follow these steps:

1. **Navigate to** [https://identityprovider.red-gate.com/personaltokens](https://identityprovider.red-gate.com/personaltokens)
2. **Login with your Redgate Portal account** (same account used in Flyway Desktop)
3. **Click "+ New Token"** to create a Personal Access Token
4. **Save the token securely** (treat it like a password - you cannot view it again)

![PAT Creation](../../../assets/images/labs/lab6-cicd_3.png)

### 2. Allocate License to Your Account

1. **Navigate to** [https://portal.red-gate.com/licenses](https://portal.red-gate.com/licenses)
2. **Select "Flyway Enterprise"** from the license list
3. **Click "+ Allocate"** and enter your email address
4. **Click "Add User"** to allocate the license
5. In this case, we might already there, just check.

### 3. Add GitHub Secrets

1. **In your GitHub repository, go to Settings**
2. **Navigate to "Secrets and variables" > "Actions"**
3. **Click "New repository secret"** and create these two secrets:

**Required Secrets:**

```
Secret Name: FLYWAY_EMAIL
Value: [your-redgate-account-email@domain.com]

Secret Name: FLYWAY_TOKEN
Value: [your-personal-access-token-from-step-1]
```

![GitHub Secrets](../../../assets/images/labs/lab6-cicd_4.png)

## Step 4: Configuring Database Environment Secrets

### 1. Add Database Connection Secrets

For secure database connections, add these optional repository secrets:

**Database Connection Secrets:**

```
Secret Name: TARGET_DATABASE_USERNAME
Value: [your-database-username] (Optional for Windows Auth)

Secret Name: TARGET_DATABASE_PASSWORD
Value: [your-database-password] (Optional for Windows Auth)

Secret Name: CUSTOM_PARAMS
Value: -X (Optional - enables debug mode)

```

### 2. Understanding Secret Usage

**Secret Descriptions:**

- **TARGET_DATABASE_USERNAME/PASSWORD**: For SQL authentication (optional with Windows Auth)
- **CUSTOM_PARAMS**: Additional Flyway parameters (e.g., `-X` for debug mode)
- **FLYWAY_CLI_INSTALL**: Set to `false` Set to true to enable a Flyway CLI validation on the runner, which will validate Flyway is installed and if not will download and install to the desired version
- **FLYWAY_AUTH_DISABLED**: Set to `false` This is an optional variable that will disable the Flyway Authentication step if set to true. This is valuable for scenarios where offline permit activation is utilized, which results in the Auth variable then becoming unnecessary.

## Step 5: Editing the Workflow Files

### 1. Select the Appropriate Workflow

1. **Open the `.github/workflows` folder**
2. **Select the YAML file** matching your self-hosted runner OS:
   - Windows: `GitHub-Flyway-CICD-Pipeline_Windows.yml`
   - Linux: `GitHub-Flyway-CICD-Pipeline_Linux.yml`

### 2. Review Workflow Configuration

The workflows are pre-configured to:

- **Read database connections** from your `flyway.toml` file
- **Use repository secrets** for authentication and passwords
- **Deploy to environments** defined in your Flyway project

**Key Workflow Features:**

```yaml
# Authenticates with Redgate using PAT
- name: Authenticate Flyway
  run: flyway auth -email ${{ secrets.FLYWAY_EMAIL }} -token ${{ secrets.FLYWAY_TOKEN }}

# Migrates database using project configuration
- name: Deploy to UAT
  run: flyway migrate -environment=uat
```

### 3. Verify Environment Configuration

1. **In Flyway Desktop, go to "Migration Scripts" tab**
2. **Click "Manage target databases"**
3. **Verify UAT environment** is properly configured
4. **Test connection** to ensure database accessibility

## Step 6: Running the Workflow

### 1. Trigger the Workflow

1. **Return to the "Actions" tab** in GitHub
2. **Select the appropriate workflow** (e.g., `windows.yml`)
3. **Click "Run workflow"** button
4. **Confirm the branch** and click "Run workflow"

![Trigger Workflow](../../../assets/images/labs/lab6-cicd_5.png)

### 2. Monitor the Workflow

1. **Click on the workflow run** to monitor progress
2. **Watch for "Queued" status** (normal if runner is busy)
3. **Verify runner is active** and available to execute

![Workflow Queued](../../../assets/images/labs/lab6-cicd_6.png)

### 3. View Deployment Progress

1. **Click on "Deploy Build"** job to see detailed logs
2. **Monitor Flyway commands** being executed:

![Workflow Running](../../../assets/images/labs/lab6-cicd_7.png)

## Step 7: Post-Deployment Verification

### 1. Review Deployment Reports

After successful completion:

1. **Check the workflow output** for deployment status
2. **Review migration reports** generated by Flyway
3. **Verify no errors** or drift detected

**Expected Success Output:**

```
✅ Authentication successful
✅ Connected to db-autopilot-uat-001
✅ Database schema updated successfully
✅ No drift detected
```

![Deployment Success](../../../assets/images/labs/lab6-deployment-success.png)

### 2. Verify Wishlist Feature in UAT

Connect to your UAT database and verify the wishlist feature was deployed:

```sql
-- Verify tables were created
SELECT TABLE_NAME, TABLE_SCHEMA
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME IN ('CustomerWishlists', 'WishlistItems')

-- Verify view was created
SELECT TABLE_NAME, TABLE_TYPE
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_NAME = 'CustomerWishlistAnalytics'

-- Check migration history
SELECT * FROM flyway_schema_history
WHERE version = '5' AND description LIKE '%Wishlist%'
```

### 3. Test Wishlist Functionality in UAT

```sql
-- Test the wishlist analytics view
SELECT
    CompanyName,
    WishlistName,
    ItemCount,
    TotalWishlistValue
FROM Sales.CustomerWishlistAnalytics
ORDER BY TotalWishlistValue DESC
```

## Key Concepts Learned

### CI/CD Database Automation

- **Automated Deployment**: Database changes deploy automatically via GitHub Actions
- **Environment Progression**: Code flows from development → UAT → production
- **Configuration as Code**: Pipeline behavior defined in YAML files
- **Secure Authentication**: Personal Access Tokens provide secure license authentication

### Flyway Enterprise Integration

- **Project-Based Configuration**: Workflows read from flyway.toml for environment details
- **Migration Orchestration**: Flyway handles version sequencing and dependency management
- **Drift Detection**: Automatic detection of unauthorized schema changes
- **Deployment Reports**: Comprehensive logging and status reporting

### DevOps Best Practices

- **Infrastructure as Code**: Deployment pipelines defined in version control
- **Secret Management**: Sensitive credentials stored securely in GitHub Secrets
- **Self-Hosted Execution**: Control over deployment environment and security
- **Audit Trail**: Complete history of deployments and changes

## What You've Accomplished

**Congratulations!** You have successfully completed the Flyway AutoPilot training course!

Throughout this course, you have:

1. **Lab 1**: Set up your development environment and Flyway project
2. **Lab 2**: Configured your repository with proper project structure
3. **Lab 3**: Provisioned databases and deployed your exciting e-commerce platform
4. **Lab 4**: Captured schema changes using AutoPilot workflow
5. **Lab 5**: Generated versioned migration scripts for deployment
6. **Lab 6**: Automated deployments using GitHub Actions CI/CD

### Your E-Commerce Platform Journey

- ✅ **Baseline Deployment**: Complete e-commerce platform with customers, products, orders
- ✅ **Feature Enhancement**: Added customer loyalty program and product reviews
- ✅ **Schema Evolution**: Captured and deployed wishlist functionality
- ✅ **Automated Pipeline**: Set up continuous deployment for future changes

### Technical Mastery Achieved

- ✅ **Database DevOps**: End-to-end automated database change management
- ✅ **Version Control**: Git-based workflow for database schema evolution
- ✅ **Migration Management**: Flyway-based versioned migration deployment
- ✅ **CI/CD Integration**: GitHub Actions pipeline for automated deployments
- ✅ **Enterprise Practices**: Security, auditing, and deployment best practices

## Next Steps

Now that you've mastered the fundamentals, continue your Flyway journey:

### Expand Your Skills

- **Explore Advanced Features**: Check mode, dry runs, and rollback procedures
- **Production Deployment**: Extend pipeline to production environment
- **Team Collaboration**: Set up multi-developer workflows and branching strategies
- **Monitoring & Alerts**: Add deployment notifications and failure handling

### Additional Resources

- **Continue Learning**: [Flyway Exercise Book](https://documentation.red-gate.com/flyway/getting-started-with-flyway/first-steps-flyway-autopilot-a-beginners-guide/flyway-autopilot-fasttrack/7-upskilling-with-the-flyway-exercise-book)
- **Join the Community**: [Redgate Forum](https://forum.red-gate.com/) for questions and discussions
- **Enterprise Support**: Contact [Flyway AutoPilot Team](mailto:flywayap@red-gate.com) for advanced scenarios

**You are now a Database DevOps expert with Flyway AutoPilot!**

## Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Flyway CI/CD Best Practices](https://documentation.red-gate.com/flyway/deploying-database-changes-using-flyway)
- [Personal Access Tokens Guide](https://documentation.red-gate.com/authentication/personal-access-tokens-pats)
- [Redgate Portal License Management](https://portal.red-gate.com/licenses)

---

## 🔗 Navigation

**⬅️ [Previous: Lab 5 - Migration Script Generation](/database-devops-autopilot/training/flyway-autopilot/labs/lab5-migration-script-generation)** | **🏠 [Workshop Overview](/database-devops-autopilot/training/flyway-autopilot/labs/)**

---

## 🎉 Congratulations!

You've completed the Flyway AutoPilot workshop! You now have:

- ✅ A complete database DevOps pipeline
- ✅ Automated schema capture and migration generation
- ✅ CI/CD deployment automation
- ✅ Best practices for database version control

**Continue your database DevOps journey with the Redgate community and documentation!**
