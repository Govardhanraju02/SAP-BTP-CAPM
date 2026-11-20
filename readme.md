# EPM – Purchase Order Management (SAP BTP CAP)

A purchase order management application built with the SAP Cloud Application Programming Model (CAP) on SAP BTP. It uses Node.js and CDS, with SAP HANA Cloud as the production database and SQLite for local development.

> Training project. [One line on what the app lets a user do, e.g. "create and track purchase orders with items and business partners".]

## Features
- [CDS data model with X entities: e.g. PurchaseOrders, Items, BusinessPartners, Products]
- [OData service exposing the entities, with custom handlers for validation / calculations]
- [Role-based access using XSUAA: e.g. Admin can create/edit, Viewer is read-only]
- [Deployed to SAP Cloud Foundry as an MTA, with HANA Cloud]
- [Optional: Fiori Elements UI / annotations / sample CSV data]

## Tech Stack
SAP BTP, SAP CAP, Node.js, CDS, OData, SAP HANA Cloud, SQLite, XSUAA, MTA, Cloud Foundry, CTMS, Git/GitHub

## Project Structure
| Path | Purpose |
|------|---------|
| `app/` | UI content [describe if used] |
| `db/` | CDS domain model [and CSV data] |
| `srv/` | Service definitions and handlers |
| `mta.yaml` | MTA deployment descriptor |
| `xs-security.json` | XSUAA scopes and roles |
| `package.json` | Dependencies and CAP configuration |

## Data Model
[List the main entities and how they relate, e.g. "PurchaseOrders has many Items (composition); each Item refers to a Product (association)". A small diagram or table is fine.]

## Run Locally
```bash
git clone https://github.com/Govardhanraju02/SAP-BTP-CAPM.git
cd SAP-BTP-CAPM
npm install
cds watch
```
Open http://localhost:4004 to see the service endpoints. Local runs use SQLite.

## Deploy to SAP BTP (Cloud Foundry)
```bash
npm install
mbt build
cf login
cf deploy mta_archives/<your-archive>.mtar
```
Requires a BTP subaccount with Cloud Foundry, HANA Cloud, and XSUAA. [Adjust the commands to what you actually used.]

## Security
Roles are defined in `xs-security.json`: [list your roles and what each can do].

## Screenshots
![Service endpoints](docs/service-endpoints.png)
![Sample OData response](docs/odata-response.png)

## Author
Vengalaraju Govardhana Raju
[LinkedIn URL] | rajugovardhan02@gmail.com
