---
layout: splash
title: "Lab 3: Database Provisioning"
description: "E-commerce platform baseline deployment and database provisioning"
toc: true
toc_label: "Lab Steps"
toc_icon: "tasks"
prev_lab:
  title: "Lab 2: Repository Configuration"
  url: "/database-devops-autopilot/training/flyway-autopilot/labs/lab2-repository-configuration"
next_lab:
  title: "Lab 4: Schema Change Capture"
  url: "/database-devops-autopilot/training/flyway-autopilot/labs/lab4-schema-change-capture"
---

## Overview

In this lab, you'll provision the actual SQL Server databases that your Flyway AutoPilot project will manage. We'll use SQL Server Management Studio (SSMS) to create the databases and then connect them to your Flyway Desktop project.

## Learning Objectives

- Use SQL Server Management Studio or preferred IDE to provision databases
- Execute the database setup script
- Connect provisioned databases to Flyway Desktop
- Verify your AutoPilot environment is ready

## Prerequisites

- Completed Lab 2 (Repository connected to Flyway Desktop)
- Access to Azure SQL Database (e.g., `sqlbits.database.windows.net`)
- Choose one: VS Code with SQL Server extension OR SQL Server Management Studio (SSMS)

## Step 1: Choose Your Database Connection Tool

You can use either of these tools to connect to your Azure SQL Database:

### Option A: VS Code with SQL Server Extension (Recommended for Codespaces)

**Perfect for**: GitHub Codespaces users or developers who prefer VS Code

1. **Install the Extension**:

   - Open VS Code
   - Go to Extensions (Ctrl+Shift+X)
   - Search for "SQL Server (mssql)"
   - Install the official Microsoft extension

   ![Extension](../../../assets/images/labs/lab3-extension.png)

2. **Benefits**:
   - Works perfectly in Codespaces
   - Integrated with your development environment
   - No additional software needed

### Option B: SQL Server Management Studio (SSMS)

**Perfect for**: Windows users who prefer a full-featured database tool

1. **Download SSMS: Recommended(Only Windows)**:

   - Go to [Download SSMS](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)
   - Download and install

2. **Benefits**:
   - Full SQL Server functionality
   - Rich database management features
   - Traditional SQL Server experience

## Step 2: Connect to Azure SQL Database

Choose your preferred database management tool for this training.

### VS Code with SQL Server Extension

- **Best for**: Developers already using VS Code
- **Extension**: Install "SQL Server (mssql)" extension

## Step 3: Connect to Your SQL Server

### 1. Connect to Your Azure SQL Database

#### Using VS Code with SQL Server Extension:

1. **Create a New Connection**:

   - Open Command Palette (Ctrl+Shift+P / Cmd+Shift+P)
   - Type: "MS SQL: Connect"
   - Select "Create Connection Profile"

2. **Enter Connection Details**:

   - **Server name**: Your Azure server (e.g., `sqlbits.database.windows.net`)
   - **Database name**: (leave empty for now, or type `master`)
   - **Authentication Type**: SQL Login
   - **User name**: Your SQL Server username
   - **Password**: Your SQL Server password
   - **Profile Name**: Give it a name like "Azure SQL - Training"

3. **Test Connection**: The extension will test and save your connection

#### Using SSMS:

1. Open **SQL Server Management Studio**
2. In the **Connect to Server** dialog:
   - **Server type**: Database Engine
   - **Server name**: Your Azure server (e.g., `sqlbits.database.windows.net`)
   - **Authentication**: SQL Server Authentication
   - **Login**: Your SQL Server username
   - **Password**: Your SQL Server password
3. Click **Connect**

## Step 4: Connect Databases to Flyway Desktop

### 1. Update Your Configuration

Since Hamish has provided you with your database credentials and database names, make sure your `1.flyway-desktop.toml` file is updated with your assigned values:

```toml
[environments.development]
url = "jdbc:sqlserver://your-assigned-server.database.windows.net:1433;databaseName=your-assigned-dev-db;encrypt=true;trustServerCertificate=false"
user = "your-assigned-username"
password = "your-assigned-password"
displayName = "Development Database"
```

### 2. Return to Flyway Desktop

1. Switch back to **Flyway Desktop**
2. You should still have your project open from Lab 2
3. If not, open the project again:
   - **Open project...** → **Open from disk**
   - Select your `1.flyway-desktop.toml` file

- **It should pop-up for Reload and everything should show up!**

### 3. Check Database Connections

- In Flyway Desktop, you should see **your assigned environments** by clicking on the Environments tab:
  - **Development** (your assigned dev database)
  - **Shadow** (your assigned shadow database)
  - **UAT** (your assigned UAT database)
  - **Production** (your assigned production database)

### 4. Verify Schema Discovery

1. With a connected environment selected, explore the **Schema model** tab
2. **At this point, the databases will be empty** - you'll only see the default `dbo` schema
3. **After running the baseline migration**, you'll see the **four schemas**:

   - Customers (default schema for the application)
   - Logistics
   - Operation
   - Sales

#### Understanding the Schema Model View

When you open the **Schema model** tab in Flyway Desktop, you'll see a comparison view that shows:

- **Object name**: Database objects (tables, views, procedures, schemas)
- **Change type**: What would happen to each object:
  - 🔴 **Drop** - Objects that exist in the schema model but not in the target database
  - 🟢 **Create** - Objects that would be created in the target database
  - 🟡 **Alter** - Objects that would be modified
- **Object type**: Table, View, Procedure, Schema, etc.
- **Schema**: Which business schema the object belongs to (Sales, Operation, etc.)

> **Why do you see "Drop" everywhere initially?**
> The schema model represents the expected final state of your database after all migrations. Since your database is currently empty (before running migrations), Flyway Desktop shows "Drop" for all the objects that should exist but don't yet. This is normal and expected!
>
> After running the baseline migration, these "Drop" indicators will disappear as the actual database matches the expected schema model.

![Desktop Environment View](../../../assets/images/labs/lab3-Desktop-looklike.png)

## Step 5: Execute Baseline Migrations

### 1. Deploy the E-Commerce Platform

Now that databases are connected, deploy the baseline e-commerce platform:

1. In Flyway Desktop, select the **Migration Scripts** panel on the left
2. Review the available migration scripts:
   ![Migration Scripts Panel](../../../assets/images/labs/lab3-Migration-script.png)

   - `B001__baseline.sql` - **E-Commerce Platform Foundation** (schemas, customers, products, orders, sample data)
   - `V002__Welcome.sql` - **Welcome Message** (introduces the platform)
   - `V003__Add_Customer_Loyalty.sql` - **Customer Loyalty Program** (points and levels)
   - `V004__Enhanced_Product_Catalog.sql` - **Product Reviews System** (ratings and inventory tracking)

   ℹ️ **Note**: The baseline migration `B001__baseline.sql` creates all required schemas (Customers, Logistics, Operation, Sales).

3. Select **Development Database** as your target environment
4. **Execute the migrations**:

   - Click **Run Migrate** button in Flyway Desktop
   - Monitor the migration execution progress

   ![Success](../../../assets/images/labs/lab3-success-migration.png)

### 2. Migration Results

After successful migration execution with the mssage **Flyway command completed**, your database contains:

**E-Commerce Platform Components:**

- **Sales.Customers** - International customer base from Germany, Mexico, UK, and Sweden
- **Operation.Products** - Product catalog including iPhone 15 Pro, PlayStation 5, MacBook Air, Nintendo Switch OLED
- **Operation.Categories** - Five product categories: Electronics, Gaming, Books, Sports, Home & Garden
- **Sales.Orders** - Sample orders with shipping costs and delivery dates
- **Sales.CustomerLoyalty** - Multi-tier loyalty system with Bronze/Silver/Gold/Platinum levels
- **Operation.ProductReviews** - Customer review system with five-star ratings

**Business Intelligence Components:**

- Customer order summaries with VIP status indicators
- Product rating summaries with star displays
- Inventory status tracking and alerts

**Stored Procedures:**

- Customer feedback recording with emoji responses
- Inventory management procedures
- Loyalty point calculation workflows

### 3. Verify Platform Deployment

1. **In Flyway Desktop:** Confirm migration history shows all versions completed successfully
2. **In your SQL management tool (SSMS/VS Code):**
   - Refresh your `db-autopilot-dev-001` database and check the `flyway_schema_history`
   - Explore the tables and review the sample data
   - Try this query to see your international customers:

```sql
SELECT CustomerID, CompanyName, City, Country
FROM Sales.Customers
ORDER BY Country, City
```

3. **Check out the product catalog:**

```sql
SELECT p.ProductName, c.CategoryName, p.UnitPrice, p.UnitsInStock
FROM Operation.Products p
JOIN Operation.Categories c ON p.CategoryID = c.CategoryID
ORDER BY c.CategoryName, p.ProductName
```

4. **See the customer loyalty levels:**

```sql
SELECT c.CompanyName, l.TotalPoints, l.LoyaltyLevel
FROM Sales.Customers c
JOIN Sales.CustomerLoyalty l ON c.CustomerID = l.CustomerID
ORDER BY l.TotalPoints DESC
```

## Verification Checklist

Complete the following verification steps to confirm successful setup:

### Database Infrastructure Verification

- [ ] Can connect to your Azure SQL Database server
- [ ] All four databases exist:
  - `db-autopilot-dev-001` (Development)
  - `db-autopilot-shadow-001` (Shadow)
  - `db-autopilot-uat-001` (UAT)
  - `db-autopilot-prod-001` (Production)
- [ ] All four schemas exist in all databases (Customers, Logistics, Operation, Sales)
- [ ] Updated flyway.toml with correct connection strings for your environment

### E-Commerce Platform Verification

- [ ] **Sales.Customers** table contains international customers (ALFKI, ANATR, ANTON, etc.)
- [ ] **Operation.Products** table includes products (iPhone 15 Pro, PlayStation 5, etc.)
- [ ] **Operation.Categories** table contains 5 categories (Electronics, Gaming, Books, Sports, Home & Garden)
- [ ] **Sales.Orders** table contains sample orders with shipping costs
- [ ] **Sales.CustomerLoyalty** table shows loyalty points and levels (Bronze/Silver/Gold/Platinum)
- [ ] **Operation.ProductReviews** table contains customer reviews with ratings

### Flyway Desktop Verification

- [ ] Flyway Desktop shows green connection status for all four environments
- [ ] Can see all 4 environments in the Environments tab:
  - Development (db-autopilot-dev-001)
  - Shadow (db-autopilot-shadow-001)
  - UAT (db-autopilot-uat-001)
  - Production (db-autopilot-prod-001)
- [ ] Migration history shows all 4 migrations completed successfully:
  - B001 (Baseline E-Commerce Platform) ✓
  - V002 (Welcome Message) ✓
  - V003 (Customer Loyalty Program) ✓
  - V004 (Product Reviews System) ✓
- [ ] Schema model is automatically discovered and populated
- [ ] Can see all schemas populated with business tables:
  - Customers schema (created by baseline migration)
  - Logistics schema (created by baseline migration)
  - Operation schema (created by baseline migration)
  - Sales schema (with core tables like Customers, Orders, etc.)

### Sample Data Verification

Execute these queries in your SQL management tool to verify the platform data:

**International Customer Base:**

```sql
SELECT CustomerID, CompanyName, City, Country
FROM Sales.Customers
ORDER BY Country
-- Should show customers from Germany, Mexico, UK, Sweden
```

**Product Catalog:**

```sql
SELECT p.ProductName, c.CategoryName, p.UnitPrice
FROM Operation.Products p
JOIN Operation.Categories c ON p.CategoryID = c.CategoryID
ORDER BY c.CategoryName
-- Should show iPhone, PlayStation, MacBook, Nintendo Switch, etc.
```

**Customer Loyalty Status:**

```sql
SELECT c.CompanyName, l.TotalPoints, l.LoyaltyLevel
FROM Sales.Customers c
JOIN Sales.CustomerLoyalty l ON c.CustomerID = l.CustomerID
ORDER BY l.TotalPoints DESC
-- Should show Bronze/Silver/Gold/Platinum levels
```

**Next Steps:**
In Lab 4, you will learn to:

- Explore the deployed e-commerce platform schema using Flyway Desktop
- Understand the four-environment migration deployment pipeline
- Create schema changes and generate new versioned migrations
- Deploy changes from development to UAT environment using AutoPilot

This training provides a comprehensive foundation in database DevOps practices using real-world, engaging scenarios that students can understand and extend.

## Additional Resources

- [Official Provisioning Guide](https://documentation.red-gate.com/flyway/getting-started-with-flyway/first-steps-flyway-autopilot-a-beginners-guide/flyway-autopilot-fasttrack/3-provisioning-your-databases)
- [SQL Server LocalDB Documentation](https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/sql-server-express-localdb)
- [SSMS Documentation](https://docs.microsoft.com/en-us/sql/ssms/sql-server-management-studio-ssms)

---

## 🔗 Navigation

**⬅️ [Previous: Lab 2 - Repository Configuration](/database-devops-autopilot/training/flyway-autopilot/labs/lab2-repository-configuration)** | **🏠 [Workshop Overview](/database-devops-autopilot/training/flyway-autopilot/labs/)** | **➡️ [Next: Lab 4 - Schema Change Capture](/database-devops-autopilot/training/flyway-autopilot/labs/lab4-schema-change-capture)**

---
