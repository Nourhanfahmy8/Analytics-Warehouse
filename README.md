# Analytics Warehouse — Bike Store Data Warehouse

A data warehouse project built on the **Bike Store** dataset (Kaggle), using **SSIS** for ETL, a **star/dimensional model** (dimension + fact tables) in **SQL Server**, and an interactive **Power BI** dashboard for reporting.

## Overview

This project implements a full data warehousing pipeline: extracting raw sales data from Kaggle, cleaning and transforming it with SSIS, loading it into a dimensional model, and visualizing key business metrics in Power BI.

**Pipeline:** `Kaggle (raw data) → SSIS (Extract, Clean, Transform) → SQL Server (Staging → DWH) → Power BI (Dashboard)`

## Dataset

- **Source:** [Bike Store dataset — Kaggle](https://www.kaggle.com/)
- **Domain:** Retail / e-commerce sales for a bike store (orders, products, customers, staff, shipping)

## Tools & Technologies

| Layer | Tool |
|---|---|
| ETL | SQL Server Integration Services (SSIS) |
| Database / DWH | Microsoft SQL Server |
| Data Cleaning | SSIS Data Flow transformations |
| Visualization | Power BI |

## Data Warehouse Design

The warehouse follows a **star schema**, with one central fact table (or several, if constellation) surrounded by conformed dimension tables.

**Dimension Tables**
- `Dim_Customer`
- `Dim_Date`
- `Dim_Geography`
- `Dim_Order_Status`
- `Dim_Product`
- `Dim_Staff`

**Fact Tables**
- `Fact_Orders`
- `Fact_Sales`
- `Fact_Shipping`

## ETL Process (SSIS)

1. **Extract** — raw CSV data from Kaggle is imported into a staging area.
2. **Transform / Clean** — handled via SSIS Data Flow tasks:
   - Removing duplicates and null/invalid records
   - Standardizing data types and formats
   - Deriving surrogate keys for dimension tables
   - Handling slowly changing dimensions (if applicable)
3. **Load** — cleaned data is loaded into the dimension and fact tables in the data warehouse schema.

## Power BI Dashboard

The Power BI dashboard connects to the data warehouse and visualizes:
- Sales performance over time (using `Dim_Date`)
- Sales by product / category (`Dim_Product`)
- Sales by geography / region (`Dim_Geography`)
- Order status breakdown (`Dim_Order_Status`)
- Staff performance (`Dim_Staff`)

> Add a screenshot of the dashboard here once finalized:
> `![Dashboard Preview](path/to/screenshot.png)`

## Project Structure

```
Analytics-Warehouse/
├── BikeStoreDataset/          # Raw source data
├── WorkProgress/              # Deliverables / documentation
├── Analytics-Warehouse.dtproj # SSIS project file
├── Analytics-Warehouse.dtsx   # SSIS package
├── Analytics-Warehouse.database
├── Bike_Store_STG.dtsx        # Staging package
├── Dim_*.dtsx                 # Dimension load packages
├── Fact_*.dtsx                # Fact load packages
└── Project.params
```

## How to Run

1. Open `Analytics-Warehouse.dtproj` in **Visual Studio (SSDT)**.
2. Configure the connection managers to point to your local SQL Server instance.
3. Execute the SSIS packages in order: staging → dimensions → facts.
4. Open the Power BI file and refresh the data source to point to your warehouse.

## License

Specify a license if applicable (e.g., MIT).
