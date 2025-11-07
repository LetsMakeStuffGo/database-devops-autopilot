# Database DevOps AutoPilot Training

This repository provides hands-on training for Flyway AutoPilot, following Redgate's official FastTrack methodology for database DevOps.

## 🚀 Quick Start

1. **Prerequisites**: Ensure you have Flyway Desktop Enterprise installed with a 28-day trial
2. **Open Project**: Launch Flyway Desktop and open this repository by selecting `flyway.toml`
3. **Set up Databases**: Run `Scripts/CreateAutopilotDatabases.sql` on your SQL Server instance
4. **Start Training**: Follow the labs in `training/flyway-autopilot/labs/`

## 📁 Repository Structure

```
├── flyway.toml                    # Main Flyway configuration
├── migrations/                    # Database migration scripts
│   ├── B001__baseline.sql
│   ├── V002__Welcome.sql
│   └── U002__UNDO-Welcome.sql
├── Scripts/                       # Database setup scripts
│   └── CreateAutopilotDatabases.sql
├── schema-model/                  # Schema model files
│   ├── Tables/
│   ├── Views/
│   └── Stored Procedures/
├── Reports/                       # Migration reports
├── .github/workflows/             # GitHub Actions CI/CD
├── AzureDevOps/                   # Azure DevOps pipelines
└── training/                      # Training materials and labs
```

## 🗄️ Database Environments

This project is configured with 2 simplified environments for focused training:

| Environment | Purpose                  | Database Name        |
| ----------- | ------------------------ | -------------------- |
| development | Primary development work | db-autopilot-dev-001 |
| uat         | User Acceptance Testing  | db-autopilot-uat-001 |

## 📚 Training Labs

1. **Lab 1**: [Getting Started](training/flyway-autopilot/labs/lab1-getting-started.md) - Prerequisites and setup
2. **Lab 2**: [Repository Setup](training/flyway-autopilot/labs/lab2-pipelines-and-automation.md) - Configure repository for AutoPilot
3. **Lab 3**: [Deployments](training/flyway-autopilot/labs/lab3-deployments.md) - Database provisioning and deployments
4. **Lab 4**: [Version Control](training/flyway-autopilot/labs/lab4-version-control.md) - Advanced version control scenarios
5. **Lab 5**: [Monitoring & Rollback](training/flyway-autopilot/labs/lab5-monitoring-and-rollback.md) - Monitoring and rollback strategies
6. **Lab 6**: [Best Practices](training/flyway-autopilot/labs/lab6-best-practices.md) - Production-ready best practices

## 🔧 Configuration

The `flyway.toml` file is configured for:

- **SQL Server** database platform
- **Windows Integrated Authentication**
- **Two environments**: Development and UAT for streamlined learning
- **Error handling** and validation rules
- **Simplified structure** perfect for training

## 🚀 CI/CD Pipelines

Pre-configured pipelines are available for:

- **GitHub Actions**: `.github/workflows/flyway-autopilot-cicd.yml`
- **Azure DevOps**: `AzureDevOps/azure-pipelines.yml`

Both pipelines include:

- Migration validation
- Automated testing
- Environment-specific deployments
- Report generation

## 📖 Additional Resources

- [Flyway AutoPilot Documentation](https://documentation.red-gate.com/flyway/getting-started-with-flyway/first-steps-flyway-autopilot-a-beginners-guide/flyway-autopilot-fasttrack)
- [SQL Server FastTrack Repository](https://github.com/red-gate/Flyway-AutoPilot-FastTrack)
- [Flyway Desktop](https://www.red-gate.com/products/flyway/desktop/)

## 🤝 Support

This is a training repository. For production support, please refer to the official Redgate documentation and support channels.

---

**Ready to start?** Open this repository in Flyway Desktop and begin with [Lab 1](training/flyway-autopilot/labs/lab1-getting-started.md)!
