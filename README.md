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
  - Download/Install the Cloud Foundry CLI https://docs.cloudfoundry.org/cf-cli/install-go-cli.html
  - Create Trial account for Cloud Foundry on SAP Cloud Platform https://developers.sap.com/tutorials/hcp-create-trial-account.html
  - Build application using mvn clean install
  - logon to SAP Cloud Platform using cf login https://api.cf.eu10.hana.ondemand.com
  - create services on SAP Cloud Platform:
    - cf create-service xsuaa application conn-xsuaa -c xs-security.json
    - cf create-service destination lite destination-rfcServices
    - cf create-service application-logs lite applog-rfcServices
    - cf create-service connectivity lite connectivity-rfcServices
  - replace \<<PUT IN YOUR SAP CP USER ID\>> in vars.yml with your SAP Cloud Platform user ID
  - push application to SAP Cloud Platform using cf push --vars-file vars.yml
  - Logon to SAP Cloud Platform trial account in web browser
