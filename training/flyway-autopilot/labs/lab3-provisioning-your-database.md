---
layout: single
title: "Lab 3: Provisioning Your Databases"
description: "Set up and provision your AutoPilot databases using SQL Server Management Studio and connect them to your Flyway Desktop project"
toc: true
toc_label: "Lab Steps"
toc_icon: "tasks"
prev_lab:
  title: "Lab 2: Getting Your Repository Ready"
  url: "/database-devops-autopilot/training/flyway-autopilot/labs/lab2-pipelines-and-automation"
next_lab:
  title: "Lab 4: Schema Capture and First Migration"
  url: "/database-devops-autopilot/training/flyway-autopilot/labs/lab4-schema-capture"
---

## Overview

In this lab, you'll provision the actual SQL Server databases that your Flyway AutoPilot project will manage. We'll use SQL Server Management Studio (SSMS) to create the databases and then connect them to your Flyway Desktop project.

## Learning Objectives

- Use SQL Server Management Studio or preferßred IDE to provision databases
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

1. **Download SSMS**:

   - Go to [Download SSMS](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)
   - Download and install

2. **Benefits**:
   - Full SQL Server functionality
   - Rich database management features
   - Traditional SQL Server experience

## Step 2: Connect to Azure SQL Database

Use SSMS or Preferred IDE

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

## Step 4: Provision Your AutoPilot Databases

### 1. Execute the Database Setup Script

Now we'll use the database setup script that's already in our repository:

#### Using VS Code:

1. Open the file: `Scripts/CreateAutopilotDatabases.sql` from your repository
2. **Execute the script**:
   - Right-click in the editor → "Execute Query"
   - Or use Command Palette → "MS SQL: Execute Query"
   - Or press **Ctrl+Shift+E**

#### Using SSMS:

1. **File** → **Open** → **File...**
2. Navigate to: `Scripts/CreateAutopilotDatabases.sql`
3. **Execute the script**:

   - Press **F5** or click **Execute**

4. **Review the script** - it will:

   - Check if databases exist
   - Create `db-autopilot-dev-001` database
   - Create `db-autopilot-uat-001` database
   - Set up all required schemas in both databases:
     - **Customers** (default schema)
     - **Logistics**
     - **Operation**
     - **Sales**

5. **Execute the script**:

   - **SSMS**: Press **F5** or click **Execute**
   - **Azure Data Studio**: Click **Run** or press **F5**
   - **VS Code**: Use Command Palette → **MS SQL: Execute Query** by chosing the `db-autopilot-dev-001` before run the command as it could not use the 'USE' query and do the same with `db-autopilot-uat-001`
   - Watch for success messages in the output

   ![Success!](../../../assets/images/labs/lab3-query-success.png)

### 2. Update Flyway Configuration for Your Azure SQL Database

You need to update the `flyway.toml` file with your actual Azure SQL Database connection details:

1. **Open `flyway.toml`** in your repository
2. **Replace the placeholder values** with your actual connection details:

```toml
[environments.development]
url = "jdbc:sqlserver://YOUR_SERVER.database.windows.net:1433;databaseName=db-autopilot-dev-001;encrypt=true;trustServerCertificate=false"
user = "your_username"
password = "your_password"
displayName = "Development database"

[environments.uat]
url = "jdbc:sqlserver://YOUR_SERVER.database.windows.net:1433;databaseName=db-autopilot-uat-001;encrypt=true;trustServerCertificate=false"
user = "your_username"
password = "your_password"
displayName = "UAT (User Acceptance Testing) database"
```

**Replace these values:**

- `YOUR_SERVER` → Your Azure SQL Server name (e.g., `sqlbits`)
- `your_username` → Your SQL Server login
- `your_password` → Your SQL Server password

**Example with actual values:**

```toml
[environments.development]
url = "jdbc:sqlserver://sqlbits.database.windows.net:1433;databaseName=db-autopilot-dev-001;encrypt=true;trustServerCertificate=false"
user = "sqluser"
password = "MySecurePassword123!"
displayName = "Development database"
```

**Important Security Note:**  
⚠️ For training purposes, we're putting credentials directly in the file. In production environments, you should use environment variables or Azure Key Vault for credential management.

### 3. Verify Database CreationAfter executing the script, you should see:

```
db-autopilot-dev-001 Database Created
db-autopilot-uat-001 Database Created
Database setup completed successfully - 2 databases ready for AutoPilot training
```

**Verify in Object Explorer/Database List**:

1. Refresh the database list in your SQL tool
2. You should see:

   - `db-autopilot-dev-001`
   - `db-autopilot-uat-001`

3. Expand each database → **Security** → **Schemas** (or equivalent)
4. Verify all schemas exist:
   - `Customers`
   - `Logistics`
   - `Operation`
   - `Sales`

## Step 5: Connect Databases to Flyway Desktop

### 1. Return to Flyway Desktop

1. Switch back to **Flyway Desktop**
2. You should still have your project open from Lab 2
3. If not, open the project again:
   - **Open project...** → **Open from disk**
   - Select your `flyway.toml` file

- **It should pop-up for Reload and everything should show up!**

### 2. Check Database Connections

- In Flyway Desktop, you should see **two environments** by clicking on the Environments tab

### 3. Verify Schema Discovery

1. With a connected environment selected, explore the **schema view**
2. You should see the **four schemas** we created:

   - Customers (default)
   - Logistics
   - Operation
   - Sales

3. Each schema should be empty (no tables yet) - this is expected!

![Desktop Now](../../../assets/images/labs/lab3-Desktop-looklike.png)

## Step 6: Run Your Exciting Migrations! 🚀

### 1. Execute Baseline Migration (Create the E-Commerce Platform!)

Now that databases are connected, let's build our amazing e-commerce platform:

1. In Flyway Desktop, select the **Migration Scripts** on the left panel
2. You should see our exciting migrations:
   ![Look like this!](../../../assets/images/labs/lab3-Migration-script.png)

   - `B001__baseline.sql` 🎯 **E-Commerce Platform Foundation** (customers, products, orders, sample data!)
   - `V002__Welcome.sql` 🎉 **Welcome Message** (introduces the platform)
   - `V003__Add_Customer_Loyalty.sql` 🌟 **Customer Loyalty Program** (points and levels!)
   - `V004__Enhanced_Product_Catalog.sql` 🛒 **Product Reviews System** (ratings and inventory tracking)

3. Click on **Manage target Database** to select `db-autopilot-dev-001`
4. **Run the migrations**:
   - Click **Run Migrate** button in Flyway Desktop
   - Watch the magic happen as your e-commerce platform is built!

### 2. What Just Happened?

After running the migrations, your database now contains:

🛍️ **Complete E-Commerce Platform:**

- **Sales.Customers** - International customers from Germany, Mexico, UK, Sweden!
- **Operation.Products** - iPhone 15 Pro, PlayStation 5, MacBook Air, Nintendo Switch OLED!
- **Operation.Categories** - Electronics, Gaming, Books, Sports, Home & Garden
- **Sales.Orders** - Real orders with shipping costs and dates
- **Sales.CustomerLoyalty** - Points system with Bronze/Silver/Gold/Platinum levels!
- **Operation.ProductReviews** - 5-star rating system with customer reviews!

📊 **Business Intelligence Views:**

- Customer order summaries with VIP status
- Product rating summaries with star displays
- Inventory status tracking

🔧 **Useful Procedures:**

- Customer feedback recording with emoji responses
- Inventory management
- Loyalty point calculations

### 3. Verify Your Amazing Platform

1. **In Flyway Desktop:** Check migration history shows all versions completed ✅
2. **In your SQL tool (SSMS/VS Code):**
   - Refresh your `db-autopilot-dev-001` database
   - Explore the tables and see the exciting sample data!
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

## Verification Checklist ✅

Confirm your awesome e-commerce platform is ready:

### Database Verification

- [ ] Can connect to your Azure SQL Database server
- [ ] Both databases exist: `db-autopilot-dev-001` and `db-autopilot-uat-001`
- [ ] All four schemas exist in both databases (Customers, Logistics, Operation, Sales)
- [ ] Updated flyway.toml with correct connection strings for your environment

### E-Commerce Platform Verification 🛍️

- [ ] **Sales.Customers** table contains international customers (ALFKI, ANATR, ANTON, etc.)
- [ ] **Operation.Products** table has exciting products (iPhone 15 Pro, PlayStation 5, etc.)
- [ ] **Operation.Categories** table has 5 categories (Electronics, Gaming, Books, Sports, Home & Garden)
- [ ] **Sales.Orders** table contains sample orders with shipping costs
- [ ] **Sales.CustomerLoyalty** table shows loyalty points and levels (Bronze/Silver/Gold/Platinum)
- [ ] **Operation.ProductReviews** table contains 5-star customer reviews

### Flyway Desktop Verification

- [ ] Flyway Desktop shows green connection status for both environments
- [ ] Migration history shows all 4 migrations completed successfully:
  - B001 (Baseline E-Commerce Platform) ✅
  - V002 (Welcome Message) ✅
  - V003 (Customer Loyalty Program) ✅
  - V004 (Product Reviews System) ✅
- [ ] Schema model is automatically discovered and populated
- [ ] Can see all schemas and tables in the Schema Model panel

### Sample Data Verification 🎯

Test these queries in your SQL tool to verify the exciting content:

**International Customers:**

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

## Next Steps 🎉

Excellent! You now have an **amazing e-commerce platform** running in your Azure SQL Database:

✅ **Connected to Azure SQL Database** using VS Code or SSMS  
✅ **Provisioned databases** ready for AutoPilot  
✅ **Updated Flyway configuration** with proper Azure SQL Database connection strings  
✅ **Complete e-commerce platform deployed** with customers, products, orders, and loyalty program!  
✅ **All 4 exciting migrations executed successfully** (B001, V002, V003, V004)  
✅ **Sample data loaded** - international customers, iPhone 15 Pro, PlayStation 5, and more!  
✅ **Business intelligence views** for customer analytics and product ratings  
✅ **Customer loyalty program** with Bronze/Silver/Gold/Platinum levels  
✅ **Product review system** with 5-star ratings

**Your students now have a REAL e-commerce platform to work with!** 🛍️

**In Lab 4**, you'll learn how to:

- Explore your deployed e-commerce platform schema in Flyway Desktop
- Understand how the 4-migration deployment pipeline works
- Make schema changes and create new versioned migrations
- Deploy changes from development to UAT environment
- Use AutoPilot to track and manage database evolution
- Add new features like shopping carts, payment tracking, or inventory alerts

**What makes this training special:**

- Students work with **real, engaging sample data** (not boring empty tables!)
- **Progressive feature development** - each migration adds business value
- **Modern e-commerce scenarios** students can relate to and extend
- **Proper DevOps patterns** with baseline, versioned migrations, and rollback capabilities

## Additional Resources

- [Official Provisioning Guide](https://documentation.red-gate.com/flyway/getting-started-with-flyway/first-steps-flyway-autopilot-a-beginners-guide/flyway-autopilot-fasttrack/3-provisioning-your-databases)
- [SQL Server LocalDB Documentation](https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/sql-server-express-localdb)
- [SSMS Documentation](https://docs.microsoft.com/en-us/sql/ssms/sql-server-management-studio-ssms)
