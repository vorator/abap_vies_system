# SAP ABAP RAP: Vendor & Invoice Management with External API Integration

An enterprise-grade transactional application built on SAP S/4HANA using the ABAP RESTful Application Programming Model (RAP). This project demonstrates a robust OData V4 implementation with Draft capabilities, strict Clean Core adherence, and external REST API consumption.

## 🎯 Business Use Case
In modern Accounts Payable (AP) and Vendor Data Management, compliance and financial standardization are critical. This solution provides a seamless Fiori-based workspace to manage vendors and track their invoices with built-in consistency checks.

**Key business capabilities:
* **Real-Time VIES Compliance:** Automatically connects to the European Commission's VIES REST API to validate Vendor VAT numbers. Invalid vendors are flagged, and non-compliant invoices are blocked from being saved.
* **Automated Currency Standardization:** Dynamically calculates and converts foreign invoice amounts (e.g., USD, GBP) into a unified base currency (EUR) at the point of entry, ensuring consistent financial reporting.
* **Auditability:** Automatically tracks administrative data (Created By, Modified At) silently in the background using framework semantics.

## 🏗️ Technical Architecture (Clean Core)
This solution strictly adheres to SAP's Clean Core principles, leveraging a Managed RAP architecture with highly decoupled business logic:
* **Data Model & Projections:** Core Data Services (CDS) base and projection views defining the data model, associations, and rich UI annotations to drive the Fiori Elements interface.
* **Behavior Definition (BDEF):** Managed implementation supporting full Draft capabilities (with draft), modern OData V4 exposure, and automated administrative field handling via @Semantics.
* **Business Object Logic (BIL):** ABAP classes handling transactional logic via Entity Manipulation Language (EML). Includes DETERMINE ON MODIFY for real-time state updates and VALIDATE ON SAVE for cross-entity consistency.
* **Integration Layer:** A decoupled, reusable global utility class acting as an HTTP client. It handles SSL/network boundaries, HTTP headers, and JSON-to-ABAP parsing using the XCO framework.

## 📸 Showcase
#1. Fiori Elements UI (OData V4 & Draft State)
<img width="1916" height="614" alt="image" src="https://github.com/user-attachments/assets/bcaefd0e-7051-43ce-956d-b0292e322a6c" />

<img width="1919" height="561" alt="image" src="https://github.com/user-attachments/assets/8466921d-23fc-45de-98e9-709e7f18f154" />

###2. Business Logic Implementation (Eclipse ADT)
<img width="3839" height="1053" alt="image" src="https://github.com/user-attachments/assets/d0860846-d142-4de0-b4db-69c4f3a562ad" />

##🛠️ Key Features Implemented
- [x] **OData V4 & Draft Handling:** Full stateless transactional support enabling auto-save, edit states, and modern Fiori Elements integration.
- [x] **External REST API Integration:** Consumption of external public APIs (VIES) over HTTPS, including request header management and native JSON parsing via the SAP XCO library.
- [x] **Advanced EML (Entity Manipulation Language):** Implementation of Cross-BO (Business Object) reads to validate Invoice data against Vendor master data states.
- [x] **Architectural Purity (Clean Core):** Proper separation of validations (ON SAVE) and determinations (ON MODIFY), avoiding endless transactional loops and leveraging SAP's standard message frameworks.

## 👨‍💻 About the Developer
I am an IT Engineer and Software Developer specializing in SAP ABAP, S/4HANA architecture, and Java.
With a robust background integrating cross-border financial systems and ERPs (SAP, Navision, SAGE), I build resilient technical solutions grounded in deep business process understanding.
[🔗 Connect with me on LinkedIn](https://linkedin.com/in/luispinto82/) | 💻 **GitHub:** [@vorator](https://github.com/vorator)
