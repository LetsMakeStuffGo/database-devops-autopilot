# Database Setup and Migration Guide

## Issue Resolution

The migration error you encountered was caused by trying to create foreign key constraints that reference tables that don't exist yet. This typically happens when:

1. **Baseline migration hasn't been applied** - The `B001__baseline.sql` needs to run first to create core tables like `Sales.Customers`
2. **Database environment isn't properly set up** - The schemas and database structure need to be established

## Fixed Migration Scripts

I've updated `V003__Add_Customer_Loyalty.sql` and `V004__Enhanced_Product_Catalog.sql` to be more defensive:

- ✅ **Defensive Foreign Key Creation**: Scripts now check if referenced tables exist before creating foreign keys
- ✅ **Conditional Data Population**: Sample data is only inserted if the required tables are present
- ✅ **Clear Warning Messages**: Scripts provide helpful feedback about missing dependencies

## Recommended Setup Sequence

To properly set up your database environment, follow this sequence:

### 1. Database Connection Setup

First, ensure your local flyway configuration is correct:

```bash
# Test connection using local config
cd /path/to/database-devops-autopilot
flyway -configFiles=1.flyway-local.toml info
```

If connection fails, update the credentials in `1.flyway-local.toml`:

- Update server name: `sqlbits.database.windows.net`
- Update username: `sqladmin`
- Update password: (use current valid password)

### 2. Database and Schema Creation

If using Azure SQL Database, run these scripts **in order**:

1. **Connect to MASTER database** and run `Scripts/CreateAutopilotDatabases.sql`
2. **Connect to each individual database** and run `Scripts/SetupSchemas.sql`

### 3. Baseline Migration

Once database and schemas are set up, apply the baseline:

```bash
flyway -configFiles=1.flyway-local.toml baseline -baselineVersion=1
flyway -configFiles=1.flyway-local.toml migrate
```

### 4. Verify Setup

Check migration status:

```bash
flyway -configFiles=1.flyway-local.toml info
```

Expected output should show:

- `B001__baseline` - Success
- `V002__Welcome` - Success
- `V003__Add_Customer_Loyalty` - Success
- `V004__Enhanced_Product_Catalog` - Success

## Troubleshooting

### Connection Issues

- Verify Azure SQL Database credentials are current
- Check firewall rules allow your IP address
- Test connection with SQL Server Management Studio or Azure Data Studio

### Missing Tables

- Ensure baseline migration `B001__baseline.sql` has been applied
- Verify schemas exist: `Customers`, `Sales`, `Logistics`, `Operation`
- Check that core tables exist: `Sales.Customers`, `Operation.Products`, `Sales.Orders`

### Foreign Key Errors (Resolved)

The updated migration scripts now handle missing table dependencies gracefully and provide clear feedback.

## Training Environment Architecture

Your setup now supports the 4-environment architecture from FastTrack:

1. **Development** (`db-autopilot-dev-001`) - Active development
2. **Shadow** (`db-autopilot-shadow-001`) - Clean validation with `provisioner="clean"`
3. **UAT** (`db-autopilot-uat-001`) - User acceptance testing
4. **Production** (`db-autopilot-prod-001`) - Live production environment

Each environment can be migrated independently using the appropriate environment flag:

```bash
# Development environment (default)
flyway -configFiles=1.flyway-local.toml migrate

# Shadow environment
flyway -configFiles=1.flyway-local.toml -environment=shadow migrate

# UAT environment
flyway -configFiles=1.flyway-local.toml -environment=uat migrate

# Production environment
flyway -configFiles=1.flyway-local.toml -environment=production migrate
```

---

**Next Steps**: Test the migration with your updated scripts. The defensive checks should now prevent the foreign key constraint errors and provide helpful guidance about any missing dependencies.
