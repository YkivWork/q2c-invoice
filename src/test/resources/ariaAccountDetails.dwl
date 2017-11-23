%dw 1.0
%output application/java
---
{
  "errorMsg": "OK",
  "errorCode": "0",
  "accountNumber": "1289302",
  "planInstanceNumber": "1733462",
  "sfdcProjectId": "a27S0000000t9hmIAA",
  "sfdcProjectName": "MS Test New 8",
  "projectCreationDate": "2017-04-11",
  "operatingUnitName": "21-US_OU-MERRILL CORPORATION",
  "businessUnit": "Datasite",
  "revenueSite": "STP",
  "primaryServiceSite": "STP",
  "salesRepSplitAmountString": "Test1|100000054|TRUE|75;Test2|100000055|FALSE|25",
  "salesRepSplitAmount": [
    {
      "salesRepName": "Test1",
      "employeeId": "100000054",
      "primary": "Y",
      "splitPercentage": "75"
    },
    {
      "salesRepName": "Test2",
      "employeeId": "100000055",
      "primary": "N",
      "splitPercentage": "25"
    }
  ],
  "splitBillingAccounts": null,
  "productType": "Datasite-Audit",
  "currencyCode": "usd",
  "countryOfIssuer": "US",
  "contractTerm": "6.0",
  "serviceNumber": "11017362"
}