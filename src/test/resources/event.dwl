%dw 1.0
%output application/java
---


{
  "eventId": "901",
  "eventLabel": "Invoice Created",
  "request": {
    "version": "1",
    "sender": "A",
    "transactionId": "18235484",
    "action": "M",
    "class": "T"
  },
  "account": {
    "clientNumber": "6000228",
    "accountNumber": "1289302",
    "userId": null,
    "planInstanceNumber": "1733462",
    "clientPlanInstanceId": "1733462",
    "respLevelCd": "1"
  },
  "financialTransaction": {
    "transId": "-1",
    "financialTransGranularId": "6095156",
    "financialTransTypeNo": "0",
    "financialTransTypeLabel": "Invoice Created",
    "financialTransDate": "2017-04-20"
  }
}