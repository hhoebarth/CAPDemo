# CAPDemo
This project shows how to implement a microservice with the SAP Cloud Application Programming Model and the SAP Cloud SDK. It includes a microservice with an app router.

Steps to setup scenario:
  - Download/Install Apache Maven http://maven.apache.org/download.cgi
  - Download/Install the Cloud Foundry CLI https://docs.cloudfoundry.org/cf-cli/install-go-cli.html
  - Create Trial account for Cloud Foundry on SAP Cloud Platform https://developers.sap.com/tutorials/hcp-create-trial-account.html
  - Download/Clone repository
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
