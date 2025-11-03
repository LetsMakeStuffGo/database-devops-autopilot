# Database DevOps Autopilot: Flyway Migration Training

A comprehensive, hands-on training course for mastering database migrations, continuous integration, and automated deployments using **Flyway**. This course is designed for database professionals, DevOps engineers, and development teams transitioning from manual database management to modern, version-controlled database deployments.

---

## Quick Start

- **Duration**: 3–4 hours (full course) or modular 30–45 minute labs
- **Format**: Self-paced, hands-on labs with instructor notes
- **Prerequisites**: Basic SQL knowledge, familiarity with Git/GitHub, SQL Server or PostgreSQL installed locally or accessible
- **Learning Outcome**: Participants will implement a complete database CI/CD pipeline, manage migrations safely, and understand database DevOps best practices

---

## Course Overview

This training transforms your understanding of database development from isolated, manual deployments to a collaborative, automated, and repeatable process using Flyway. Over the course of this series, you'll experience the complete workflow: capturing schema changes, generating versioned migrations, validating deployments, and orchestrating releases through CI/CD pipelines.

By the end, you'll understand how to:
- Version control your database schema alongside application code
- Automate database builds and deployment validation
- Integrate database changes into GitHub Actions or Azure DevOps pipelines
- Handle database rollbacks and conflict resolution safely
- Apply industry best practices for database DevOps in your organization

---

## Learning Objectives

After completing this course, participants will be able to:

1. **Understand the fundamentals** of database version control and why DevOps principles apply to databases
2. **Set up and navigate** Flyway's project structure with sample databases
3. **Capture and version** schema changes using Flyway's migration framework
4. **Generate migration scripts** from schema models and understand baseline migrations
5. **Execute and validate** database deployments using Flyway's built-in checks and reports
6. **Automate deployments** through CI/CD platforms (GitHub Actions and Azure DevOps)
7. **Implement rollback strategies** and recover from failed deployments
8. **Apply best practices** for team-based database development and production deployments

---

## Workshop Labs

Each lab is a self-contained, 30–45 minute hands-on exercise. Labs build sequentially but can also be completed independently with provided sample data. 

### **Lab 1: Setup and First Steps**
**Time**: 30 minutes | **Difficulty**: Beginner

Get up and running with Flyway. Download Flyway CLI, create your first project, provision test databases, and explore the command-line interface. Verify your environment is ready for development.

- Explore the Flyway project structure and configuration
- Create sample databases for development, test, and production environments
- Navigate the Flyway CLI and understand key concepts
- Validate connectivity to all database environments

**Learner Outcomes**: Familiar with Flyway tooling and project layout.

**File**: [Lab 1: Getting Started](training/flyway-autopilot/labs/lab1-getting-started/)

---

### **Lab 2: Understanding Migrations and Pipelines**
**Time**: 40 minutes | **Difficulty**: Beginner

Learn the core migration strategies that Flyway uses: versioned migrations and pipeline automation. Understand when and why to use each approach, explore naming conventions, and examine existing migration scripts.

- Understand versioned migrations (V1, V2, V3…) and naming conventions
- Set up automated migration pipelines
- Learn Flyway metadata tracking and the flyway_schema_history table
- Implement CI/CD pipeline integration basics

**Learner Outcomes**: Confident with migration concepts and automation setup.

**File**: [Lab 2: Pipelines & Automation](training/flyway-autopilot/labs/lab2-pipelines-automation/)

---

### **Lab 3: Advanced Deployments**
**Time**: 45 minutes | **Difficulty**: Intermediate

Master complex deployment scenarios including schema changes, data migrations, and environment-specific configurations. Use Flyway to handle real-world deployment challenges safely.

- Handle complex schema changes and data migrations
- Implement environment-specific deployment strategies
- Configure blue-green database deployments
- Manage deployment validation and testing

**Learner Outcomes**: Comfortable with complex deployment scenarios and validation.

**File**: [Lab 3: Advanced Deployments](training/flyway-autopilot/labs/lab3-deployments/)

---

### **Lab 4: Version Control and Rollbacks**
**Time**: 40 minutes | **Difficulty**: Intermediate

Transform captured schema changes into versioned migration scripts. Learn advanced versioning strategies, implement safe rollback procedures, and handle migration conflicts.

- Implement advanced versioning strategies and branching
- Create and execute safe rollback procedures
- Handle migration conflicts and repairs
- Baseline existing databases and manage legacy systems

**Learner Outcomes**: Generate production-ready migration scripts with confidence.

**File**: [Lab 4: Version Control & Rollbacks](training/flyway-autopilot/labs/lab4-version-control/)

---

### **Lab 5: Monitoring and Troubleshooting**
**Time**: 35 minutes | **Difficulty**: Intermediate

Set up comprehensive monitoring for database deployments. Learn to debug failed migrations, optimize performance for large datasets, and implement audit trails.

- Set up migration monitoring and alerting systems
- Debug failed migrations and performance issues
- Optimize migrations for large datasets
- Implement audit trails and compliance reporting

**Learner Outcomes**: Self-sufficient in monitoring and troubleshooting deployments.

**File**: [Lab 5: Monitoring & Troubleshooting](training/flyway-autopilot/labs/lab5-monitoring/)

---

### **Lab 6: Production Strategies**
**Time**: 50 minutes | **Difficulty**: Advanced

Prepare for and execute production deployments with enterprise-grade safety measures. Implement zero-downtime patterns, security controls, and disaster recovery procedures.

- Implement zero-downtime deployment patterns
- Configure multi-environment coordination strategies
- Apply security and access management controls
- Set up disaster recovery and backup strategies

**Learner Outcomes**: Execute production releases with minimal risk and maximum reliability.

**File**: [Lab 6: Production Strategies](training/flyway-autopilot/labs/lab6-production/)

---

## Repository Structure

```
database-devops-autopilot/
├── README.md                              # Main course guide (this file)
├── _config.yml                            # Jekyll configuration
├── index.md                               # Home page for GitHub Pages
├── INSTRUCTOR_NOTES.md                    # Guidance for instructors/facilitators
│
├── training/                              # All training materials
│   └── flyway-autopilot/
│       ├── index.md                       # Training overview
│       └── labs/                          # Individual lab exercises
│           ├── lab1-getting-started.md
│           ├── lab2-pipelines-automation.md
│           ├── lab3-deployments.md
│           ├── lab4-version-control.md
│           ├── lab5-monitoring.md
│           └── lab6-production.md
│
├── docs/                                  # Supporting documentation
│   ├── workshop-overview.md               # Course overview and objectives
│   ├── prerequisites.md                   # Setup requirements and tools
│   ├── references.md                      # External resources and links
│   └── troubleshooting.md                 # Common issues and solutions
│
├── assets/                                # Course assets and resources
│   ├── images/                            # Screenshots and diagrams
│   ├── templates/                         # Code templates and examples
│   └── glossary.md                        # Database DevOps terminology
│
└── _data/
    └── navigation.yml                     # Site navigation structure
```

---

## Prerequisites and Requirements

Before starting, ensure you have:

### **Software & Tools**
- **Flyway CLI**: [Download the latest version](https://flywaydb.org/download/) (Community Edition is free)
- **Git & GitHub**: [Create a GitHub account](https://github.com) if you don't have one
- **Database**: SQL Server 2019+ or PostgreSQL 12+ (local, cloud-based, or containerized)
- **Text Editor**: Visual Studio Code or similar for editing migration scripts and configuration files

### **Knowledge & Experience**
- Basic SQL (CREATE TABLE, ALTER TABLE, INSERT, SELECT)
- Comfort with command-line/terminal usage
- Familiarity with Git basics (clone, commit, push, pull)
- Understanding of CI/CD concepts (pipelines, builds, deployments)

### **Optional but Recommended**
- Docker or container experience (for spinning up test databases)
- Azure DevOps or GitHub Actions experience
- Database administration background

---

## Key Concepts at a Glance

| **Concept** | **Definition** |
|---|---|
| **Migration** | A versioned SQL script that evolves your database schema from one version to the next |
| **Baseline** | A migration script that establishes the starting point for a database version |
| **Schema Model** | A collection of object-level SQL scripts that represent the desired end state of your database |
| **Versioned Migration** | A timestamped migration script (V prefix) that describes an incremental change |
| **Checksum** | A hash Flyway calculates for each migration to ensure integrity |
| **flyway_schema_history** | The metadata table Flyway maintains to track applied migrations |
| **Drift Detection** | A feature that identifies untracked schema changes |
| **Rollback Script** | A migration script that reverses changes from a forward migration |
| **CI/CD Pipeline** | An automated workflow that tests, validates, and deploys database changes |

---

## Getting Started

Ready to begin your database DevOps journey?

1. **Review Prerequisites**: Check [Prerequisites](docs/prerequisites/) to ensure your environment is ready
2. **Start with Lab 1**: Begin with [Setup and First Steps](training/flyway-autopilot/labs/lab1-getting-started/)
3. **Follow the Path**: Work through labs sequentially for the best learning experience
4. **Get Support**: Use [Troubleshooting Guide](docs/troubleshooting/) if you encounter issues

---

## About the Authors

This workshop is brought to you by [LetsMakeStuffGo](https://www.makestuffgo.com), a company dedicated to bringing AI services to both Cloud and DevOps Engineering practices. Our mission is to help organizations implement world-class DevOps practices that deliver real business value.

**Want to see how your company measures up?** Take our [FREE DevOps & FinOps Assessment](https://assessment.makestuffgo.com) to benchmark against industry standards.

With 25+ years of combined experience in database management, DevOps automation, and enterprise software delivery, our team is passionate about education and helping others master practical skills that drive business outcomes.

---

## Support and Contributing

- **Report Issues**: [Open a GitHub issue](https://github.com/LetsMakeStuffGo/database-devops-autopilot/issues)
- **Suggest Improvements**: Submit a pull request with updated content
- **Get Help**: Contact us through [MakeStuffGo](https://www.makestuffgo.com)

---

## License

This training material is provided under the MIT License. You're free to use, adapt, and share these materials for educational purposes with attribution.

---

**Last Updated**: November 2025  
**Maintained by**: LetsMakeStuffGo Team  
**Version**: 1.0

For the latest updates and additional resources, visit [MakeStuffGo](https://www.makestuffgo.com).
