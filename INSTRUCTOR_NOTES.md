# Instructor Notes: Database DevOps Autopilot Training

This document provides guidance for instructors and workshop facilitators delivering the Database DevOps Autopilot training course.

## Course Overview

**Duration**: 3-4 hours total (can be delivered as 6 separate 45-minute sessions)  
**Format**: Hands-on workshop with practical exercises  
**Target Audience**: Database professionals, DevOps engineers, development teams  
**Class Size**: Optimal 8-12 participants, maximum 16

## Pre-Workshop Preparation

### Instructor Setup (1 week before)

- [ ] Test all lab exercises in target database environments
- [ ] Prepare demo databases (development, test, production simulation)
- [ ] Verify Flyway CLI installation on instructor machine
- [ ] Set up CI/CD demonstration environment (GitHub Actions or Azure DevOps)
- [ ] Review latest Flyway documentation for any updates
- [ ] Prepare backup migration scripts for common failure scenarios

### Participant Preparation (3 days before)

- [ ] Send prerequisites checklist to participants
- [ ] Provide database connection details (if using shared instances)
- [ ] Share GitHub repository access (if using shared repo)
- [ ] Confirm software installations (Flyway CLI, Git, database tools)

## Lab-by-Lab Guidance

### Lab 1: Setup and First Steps (30 minutes)

**Key Learning**: Environment setup and Flyway basics

**Instructor Focus**:

- Emphasize project structure conventions
- Demonstrate flyway.conf configuration options
- Show flyway info command early for status checking

**Common Issues**:

- Database connectivity problems (firewall, credentials)
- Java PATH issues with Flyway CLI
- Confusion between Flyway Community vs Enterprise features

**Timing**:

- Setup verification: 10 minutes
- Project structure walkthrough: 10 minutes
- First migration execution: 10 minutes

**Success Criteria**: All participants can run `flyway info` successfully

### Lab 2: Pipelines & Automation (40 minutes)

**Key Learning**: CI/CD integration and automated deployments

**Instructor Focus**:

- Explain migration naming conventions thoroughly
- Demonstrate flyway_schema_history table inspection
- Show how checksums detect changes

**Common Issues**:

- GitHub Actions secrets configuration
- Database connection strings in CI/CD
- Understanding of versioned vs repeatable migrations

**Timing**:

- Migration concepts: 15 minutes
- CI/CD setup: 20 minutes
- Pipeline execution: 5 minutes

**Success Criteria**: Automated pipeline successfully deploys database changes

### Lab 3: Advanced Deployments (45 minutes)

**Key Learning**: Complex schema changes and validation

**Instructor Focus**:

- Emphasize dry-run capabilities
- Show data migration strategies
- Demonstrate rollback scenarios

**Common Issues**:

- Data loss during schema changes
- Complex dependency management
- Environment-specific configuration

**Timing**:

- Schema change planning: 15 minutes
- Migration execution: 20 minutes
- Validation and testing: 10 minutes

**Success Criteria**: Participants handle complex schema changes safely

### Lab 4: Version Control & Rollbacks (40 minutes)

**Key Learning**: Branching strategies and recovery procedures

**Instructor Focus**:

- Git workflow for database changes
- Baseline creation for existing databases
- Conflict resolution strategies

**Common Issues**:

- Merge conflicts in migration files
- Baseline checksum mismatches
- Understanding when to use repair vs clean

**Timing**:

- Git workflow demo: 15 minutes
- Conflict resolution: 15 minutes
- Rollback procedures: 10 minutes

**Success Criteria**: Participants can safely rollback failed deployments

### Lab 5: Monitoring & Troubleshooting (35 minutes)

**Key Learning**: Debugging and performance optimization

**Instructor Focus**:

- Flyway logging configuration
- Performance considerations for large datasets
- Error diagnosis techniques

**Common Issues**:

- Log level configuration
- Transaction handling in migrations
- Performance on large tables

**Timing**:

- Monitoring setup: 15 minutes
- Troubleshooting scenarios: 15 minutes
- Performance optimization: 5 minutes

**Success Criteria**: Participants can diagnose and resolve common issues

### Lab 6: Production Strategies (50 minutes)

**Key Learning**: Enterprise deployment patterns

**Instructor Focus**:

- Zero-downtime deployment techniques
- Security and access controls
- Disaster recovery procedures

**Common Issues**:

- Production database permissions
- Backup and recovery planning
- Coordinating with application deployments

**Timing**:

- Production planning: 20 minutes
- Security implementation: 15 minutes
- Disaster recovery: 15 minutes

**Success Criteria**: Participants design production-ready deployment strategy

## Teaching Tips

### Demonstration Best Practices

- Always show the command-line output clearly
- Use consistent database examples throughout
- Explain the "why" behind each Flyway command
- Show both success and failure scenarios

### Hands-On Management

- Circulate during hands-on time to assist individuals
- Have common solutions prepared for frequent issues
- Use shared screen for group problem-solving
- Encourage peer assistance and collaboration

### Troubleshooting Support

- Keep a "common issues" reference handy
- Have backup migration scripts ready
- Know how to quickly reset database state
- Prepare alternative connection methods

## Assessment and Validation

### Knowledge Checks

- Lab completion verification
- Practical skill demonstration
- Understanding of key concepts

### Success Indicators

- Participants can create and execute migrations independently
- Understanding of CI/CD integration principles
- Ability to troubleshoot common issues
- Confidence in production deployment planning

## Post-Workshop Resources

### Follow-Up Materials

- Link to advanced Flyway documentation
- Community forums and support channels
- Additional practice scenarios
- Integration with specific CI/CD platforms

### Certification Path

- Suggest next steps for advanced training
- Recommend hands-on practice projects
- Connect to database DevOps community resources

## Troubleshooting Quick Reference

### Database Connectivity

```bash
# Test database connection
flyway info -url=jdbc:postgresql://localhost:5432/mydb -user=username -password=password

# Check Java version
java -version

# Verify Flyway installation
flyway -version
```

### Common Migration Issues

```bash
# Reset to clean state (development only!)
flyway clean -url=... -user=... -password=...

# Repair metadata table
flyway repair -url=... -user=... -password=...

# Baseline existing database
flyway baseline -baselineVersion=1.0 -url=... -user=... -password=...
```

### CI/CD Debugging

- Check secret/variable configuration
- Verify network connectivity from CI/CD environment
- Validate database permissions for service accounts
- Review pipeline logs for specific error messages

## Feedback Collection

### During Workshop

- Check understanding after each lab
- Ask for pace feedback (too fast/slow)
- Monitor engagement and participation levels
- Note areas of confusion for future improvement

### Post Workshop

- Collect written feedback on content and delivery
- Ask for specific improvement suggestions
- Request difficulty level assessment
- Gather follow-up questions and support needs

---

**Version**: 1.0  
**Last Updated**: November 2025  
**Next Review**: March 2026
