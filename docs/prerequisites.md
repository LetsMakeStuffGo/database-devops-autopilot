---
layout: single
title: "Prerequisites"
description: "System requirements and setup guide for Flyway AutoPilot training"
toc: true
toc_label: "Requirements"
toc_icon: "clipboard-check"
---

# Required Software

### Core Development Tools

#### 1. Git

**Purpose**: Version control for database migrations and team collaboration

**Installation:**

- **Windows**: Download from [git-scm.com](https://git-scm.com/download/win)
- **macOS**: Install via Homebrew: `brew install git` or download from git-scm.com
- **Linux**: Use package manager: `sudo apt install git` (Ubuntu) or `sudo yum install git` (CentOS)

**Configuration:**

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@company.com"
```

**Verification:**

```bash
git --version
```

#### 2. Azure CLI

**Purpose**: Azure resource management and authentication

**Installation:**

- **Windows**: Download MSI from [Azure CLI documentation](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows)
- **macOS**: Install via Homebrew: `brew install azure-cli`
- **Linux**: Follow [Azure CLI installation guide](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux)

**Verification:**

```bash
az --version
az login
```

#### 3. SQL Server Management Studio (SSMS) or Azure Data Studio

**Purpose**: Database client for Azure SQL Database management

**Choose One:**

**SQL Server Management Studio (Windows only)**

- Download from [Microsoft SSMS](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)
- Full-featured database management tool

**Azure Data Studio (Cross-platform)**

- Download from [Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio)
- Lightweight, modern database tool

**Verification:**

- Connect to a test Azure SQL Database
- Verify you can execute SQL queries

### Development Environment

#### Code Editor

**Visual Studio Code (Recommended)**

- Download from [code.visualstudio.com](https://code.visualstudio.com/)
- Install recommended extensions:
  - **SQL Server (mssql)**: Azure SQL Database connectivity
  - **GitLens**: Enhanced Git integration
  - **YAML**: GitHub Actions workflow editing
  - **Azure Account**: Azure integration

**Alternative Options:**

- IntelliJ IDEA (with Database Tools plugin)
- Sublime Text (with SQL syntax highlighting)
- Any text editor with SQL and YAML support

#### Terminal/Command Line

**Required**: Command line access for running Flyway commands and Git operations

- **Windows**: PowerShell 5.1+ (recommended) or Command Prompt
- **macOS**: Terminal.app or iTerm2
- **Linux**: Bash shell (default on most distributions)

## Training-Specific Tools

### Flyway AutoPilot

**Note**: Flyway AutoPilot will be downloaded and configured during Lab 1. No pre-installation required.

**Requirements**:

- Valid Redgate account (free registration available)
- Internet access for downloading Flyway CLI
- Java 8 or higher (automatically detected or will be guided through installation)

### GitHub Account

**Purpose**: Version control repository hosting and CI/CD pipeline execution

**Requirements**:

- Free GitHub account at [github.com](https://github.com)
- Basic familiarity with Git commands (clone, commit, push)
- Ability to create repositories and configure secrets

## Network and Access Requirements

### Internet Connectivity

Ensure your environment has access to:

- **Azure Portal**: `portal.azure.com` (HTTPS/443)
- **GitHub**: `github.com` (HTTPS/443)
- **Redgate License Server**: Various endpoints (HTTPS/443)
- **Flyway Downloads**: `repo1.maven.org` (HTTPS/443)
- **Azure SQL Database**: `*.database.windows.net` (SQL/1433)

### Azure SQL Database Connectivity

**Required Ports**:

- Port 1433 for Azure SQL Database connections
- HTTPS/443 for Azure management APIs

**Firewall Configuration**:

- Azure SQL Database firewall will be configured during lab exercises
- Corporate firewalls may need to allow connections to `*.database.windows.net`

### Corporate Environment Considerations

**Proxy Settings**: Configure Git and Azure CLI to work with corporate proxy if required

**Certificate Requirements**: Install corporate CA certificates if your organization uses custom certificates

**Security Policies**: Ensure Azure CLI and database tools comply with organizational security policies

## Knowledge Prerequisites

### Required Knowledge

**SQL Fundamentals**:

- Basic SQL syntax (SELECT, INSERT, UPDATE, DELETE)
- Understanding of database tables, views, and indexes
- Familiarity with database schema concepts

**Git Basics**:

- Understanding of version control concepts
- Basic Git commands (clone, add, commit, push, pull)
- Familiarity with branching and merging concepts

**Command Line Comfort**:

- Basic command line navigation
- Running commands and interpreting output
- Setting environment variables

### Helpful But Not Required

**Azure Experience**: Basic familiarity with Azure Portal navigation
**CI/CD Concepts**: Understanding of automated deployment pipelines
**Database DevOps**: Experience with database change management

## Pre-Training Checklist

Before starting the training, verify you have:

- [ ] Active Azure subscription with admin access
- [ ] Git installed and configured with your credentials
- [ ] Azure CLI installed and authenticated (`az login` successful)
- [ ] Database client tool installed (SSMS or Azure Data Studio)
- [ ] Visual Studio Code with recommended extensions
- [ ] GitHub account created and accessible
- [ ] Stable internet connection
- [ ] Administrative access to install software if needed

## Getting Help

### During Setup

If you encounter issues during prerequisite setup:

1. **Check Official Documentation**: Each tool provides comprehensive installation guides
2. **Verify System Compatibility**: Ensure your OS version is supported
3. **Corporate IT Support**: Contact IT if working in a managed environment
4. **Community Resources**: Check GitHub issues and Stack Overflow for common problems

### Training Support

During the training labs:

- Each lab includes detailed troubleshooting sections
- Sample error messages and solutions are provided
- Links to official documentation for advanced configuration

---

_Once you've completed all prerequisites, you're ready to begin with [Lab 1: Environment Setup](../training/flyway-autopilot/labs/lab1-environment-setup/)_
