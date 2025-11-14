# Database DevOps AutoPilot: Flyway Training

A comprehensive, hands-on training course for mastering **Flyway AutoPilot** - the intelligent database DevOps solution that automatically detects schema changes and generates migration scripts. This course teaches enterprise-grade database DevOps practices using Azure SQL Database and realistic e-commerce platform scenarios.

---

## Quick Start

- **Format**: Self-paced, hands-on labs with realistic business scenarios
- **Prerequisites**: Basic SQL knowledge, Azure account, Git/GitHub familiarity
- **Platform**: Azure SQL Database with Flyway AutoPilot
- **Learning Outcome**: Complete automated database DevOps pipeline with GitHub Actions CI/CD

---

## Course Overview

This training transforms database development from manual, error-prone processes to intelligent, automated workflows using Flyway AutoPilot. Learn through a progressive e-commerce platform that evolves from basic customer management to a complete online shopping system with advanced features.

By the end, you'll master:

- **AutoPilot Schema Detection**: Automatically capture database changes without manual scripting
- **Azure SQL Database Integration**: Enterprise cloud database environments and connectivity
- **Migration Script Generation**: Automated production-ready migration script creation
- **GitHub Actions CI/CD**: Complete automated deployment pipelines across environments
- **E-commerce Platform Evolution**: Real-world business scenarios and data modeling

---

## Learning Objectives

After completing this course, participants will be able to:

1. **Configure AutoPilot Environment** - Set up Flyway AutoPilot with Azure SQL Database and establish secure connections
2. **Implement Schema Change Detection** - Use AutoPilot's intelligent comparison engine to automatically detect database changes
3. **Generate Migration Scripts** - Create production-ready migration scripts automatically without manual coding
4. **Deploy Through CI/CD** - Implement complete GitHub Actions pipelines for automated database deployments
5. **Manage E-commerce Platform Evolution** - Apply learned concepts through realistic business scenarios and progressive feature development
6. **Apply Enterprise Best Practices** - Implement security, monitoring, and rollback strategies for production environments

# Database DevOps AutoPilot: Flyway Training

Hands-on training for **Flyway AutoPilot** - intelligent database DevOps with automated schema change detection and migration generation using Azure SQL Database.

## Quick Start

- **Duration**: 4-6 hours (6 labs)
- **Platform**: Azure SQL Database + Flyway AutoPilot
- **Outcome**: Complete CI/CD pipeline with GitHub Actions

## Training Labs

1. **[Environment Setup](training/flyway-autopilot/labs/lab1-environment-setup/)** - Azure SQL Database and AutoPilot configuration
2. **[Repository Configuration](training/flyway-autopilot/labs/lab2-repository-configuration/)** - Flyway project setup
3. **[Database Provisioning](training/flyway-autopilot/labs/lab3-database-provisioning/)** - E-commerce platform baseline
4. **[Schema Change Capture](training/flyway-autopilot/labs/lab4-schema-change-capture/)** - AutoPilot change detection
5. **[Migration Script Generation](training/flyway-autopilot/labs/lab5-migration-script-generation/)** - Automated script creation
6. **[CI/CD Deployment](training/flyway-autopilot/labs/lab6-cicd-deployment/)** - GitHub Actions pipeline

## Database Environment Strategy

This training implements a **4-environment database DevOps pipeline** following Flyway enterprise best practices:

### Environment Architecture

```
DEV ↔ SHADOW → UAT → PRODUCTION
```

**Environment Descriptions:**

- 🔧 **Development** (`db-autopilot-dev-001`) - Primary development database where schema changes are made
- 👥 **Shadow** (`db-autopilot-shadow-001`) - Clean validation database for schema drift detection and migration testing
- 🧪 **UAT** (`db-autopilot-uat-001`) - User Acceptance Testing environment for stakeholder validation
- 🚀 **Production** (`db-autopilot-prod-001`) - Live production database with approval gates and rollback capabilities

### Shadow Database Benefits

The **Shadow Database** is a key differentiator in professional database DevOps:

- **Schema Drift Detection** - Identifies changes made directly in development that aren't scripted
- **Migration Validation** - Tests migration scripts against a clean database state
- **Source of Truth** - Represents the exact state that results from running all migration scripts
- **CI/CD Safety** - Validates deployments before they reach UAT or Production

This architecture ensures **zero-downtime deployments** and **consistent schema management** across all environments.

## What You'll Learn

- AutoPilot schema change detection and automated migration generation
- Azure SQL Database integration and enterprise cloud database management
- Complete GitHub Actions CI/CD pipeline implementation
- Real-world e-commerce platform scenarios and progressive feature development

## Prerequisites

- Basic SQL knowledge
- Azure account with database creation permissions
- Git/GitHub familiarity
- Command line comfort

## Getting Started

1. Check [Prerequisites](docs/prerequisites/)
2. Start with [Lab 1: Environment Setup](training/flyway-autopilot/labs/lab1-environment-setup/)
3. Follow labs 1-6 in sequence

---

**Training by [LetsMakeStuffGo](https://www.makestuffgo.com)** | Take our [FREE DevOps Assessment](https://assessment.makestuffgo.com)
