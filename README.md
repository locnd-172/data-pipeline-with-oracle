# Data Pipeline & Data Warehouse with Oracle

## Problems Statement
- Model data to handle transaction data when a customer makes an order with a coupon applied and calculates the delivery fee (Sales Data).
- Build an ETL pipeline to import Sales data from flat files (`.csv/.txt`) to a data warehouse in Oracle database.
- Perform basic analysis by building a dashboard of Sales Data.

## Data
Access dataset at [Sales Data](https://drive.google.com/file/d/1Y-Vt-Ev5rRuKDQKx9szugNZf5dpxeROh) 

## Tech-stack
- **Oracle Database 12c**
- **SQLdeveloper**: Data modelling, SQL scripts
- **Oracle Data Integrator 12c**: ETL pipeline
- **Oracle Analytics Desktop**: Analyze data

## Project Diagram
![diagram](./img/image21.png)

## Data modelling
### Physical schema
![logical schema](./img/image1.png)
Scripts to create tables are stored in [DDL.sql](./DDL.sql) file

### Dimensional model
**Fact**: Trans, Order, Delivery
**Dim**: Customer, Store, Product, Category, Shipper, Channel, Coupon


## ODI setup for loading file to table
Follow the steps:
```
1. Prepare the Source Flat file
1.1 - Defining Source Topology Physical Architecture
1.2 - Defining Source Topology Logical Architecture
1.3 - Defining Source Designer Model

2. Prepare the Target Table
2.1 - Defining Target Topology Physical Architecture
2.2 - Defining Target Topology Logical Architecture
2.3 - Defining Target Designer Model

3. Prepare the Mapping
3.1 - Creating the Designer Project
3.2 - Importing the Knowledge Modules
3.3 - Creating the Mapping

4. Execute the Mapping
```
![ODI](./img/image2.png)

### Load file into ODI
![load file](./img/image3.png)

### Mapping 
![define mapping](./img/image4.png)

### Mapping execution & Debugging
![execute mapping](./img/image5.png)

### Incremental Load
![incremental](./img/image15.png)

Scripts for testing the mapping and creation of data mart tables are stored in [DML.sql](./DML.sql) file

## Manage security
![security](./img/image6.png)
\
**Object** is a representation of a design-time or run-time artifact.
**Method** is an action that can be performed on an object. 
![object & method](./img/image7.png)

**User** is an ODI user, corresponds to username used to connect to a repo
![user](./img/image8.png)

**Profile** contains a set of privileges. One or more profiles can be assigned to a user
![profile](./img/image9.png)

### Example
**DEV** user has READ permission only of Data schema and User profile
![dev user](./img/image10.png)

![authorize dev](./img/image11.png)

## Scheduling
Can plan a execution schedule for a mapping, scenario, package
**Agents** are Java components
- execute jobs on demand 
- start the execution of scenarios according to a schedule defined in ODI

Start an agent command (windows): `./agent.cmd -NAME=OracleDIAgent1`

![setup agent](./img/image12.png)

![schedule](./img/image13.png)

Running result:
![schedule result](./img/image14.png)

## Building data mart
![data mart](./img/image16.png)

## Oracle Analytics Desktop

### Overview
![overview dashboard](./img/image17.png)

### Latest Year
![latest year dashboard](./img/image18.png)

### Volume & Revenue
![volume & revenue](./img/image19.png)

### Product
![product dashboard](./img/image20.png)

## Author
Loc Nguyen Dang 
2023