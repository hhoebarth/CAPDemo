# CAPDemo
This project shows how to implement a microservice with the SAP Cloud Application Programming Model and the SAP Cloud SDK. It includes a microservice with an app router.

Steps to setup scenario:
  - Install a JavaVM (at least Java 8)
  - Install Eclipse (tested with version 2019-09)
  - Optional: Install "Spring Tools 4" from Eclipse Marketplace
  - Install SAP Cloud Business Application Tools for Ecslipe (update site https://tools.hana.ondemand.com/2019-09/)
  - Download/Install Apache Maven http://maven.apache.org/download.cgi
  - Download/Install Node.js https://nodejs.org (use latest LTS release)
  - Set npm registry for @sap packages: npm set @sap:registry=https://npm.sap.com
  - Install cds development kit globally: npm i -g @sap/cds-dk
  - Download/Clone repository
  - Install SQLite from http://sqlite.org/download.html
  - NPM Install (root folder): npm install
  - create database and fill it with example data (in project root folder): npm run deploy
  - Build application using mvn clean install
  - Run application using mvn spring-boot:run
