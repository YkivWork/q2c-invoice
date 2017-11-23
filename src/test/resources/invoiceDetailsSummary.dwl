%dw 1.0
%output application/java
---
{
  "invoiceSellTotal": 2000,
  "invoiceLineCount": 1,
  "lines": [
    {
      "sourceLineId": "1",
      "serviceNumber": "11023545",
      "serviceName": "PgMinimumFee",
      "lineNumber": "1",
      "quantity": "1",
      "unitRate": "2000",
      "sellAmount": "2000",
      "itemDescription": "Monthly Minimum Fee"
    }
  ]
}