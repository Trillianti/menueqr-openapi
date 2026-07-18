# Bills

Use bill endpoints to pull table bills and mark them paid from an external POS.

## List Bills

```http
GET /api/open/pos/{provider}/{restaurantId}/bills
```

Query parameters:

| Name | Type | Description |
| --- | --- | --- |
| `status` | `open`, `paid`, `canceled` | Optional status filter. |
| `since` | ISO datetime | Only bills updated after this timestamp. |
| `limit` | integer, 1-100 | Defaults to 50. |

Example:

```bash
curl "https://api.example.com/api/open/pos/custom/rest_123/bills?status=open" \
  -H "x-menuqr-pos-api-key: $MENUQR_POS_API_KEY"
```

## Get Bill

```http
GET /api/open/pos/{provider}/{restaurantId}/bills/{billId}
```

## Settle Bill

```http
POST /api/open/pos/{provider}/{restaurantId}/bills/{billId}/settle
```

Body:

```json
{
  "externalPaymentId": "payment_987",
  "externalBillId": "pos_bill_456",
  "method": "card",
  "billSubtotalAmount": "39.80",
  "tipAmount": "3.00",
  "grossAmount": "42.80",
  "paidAt": "2026-05-11T12:30:00.000Z",
  "metadata": {
    "terminalId": "terminal_1"
  }
}
```

Required fields:

| Name | Description |
| --- | --- |
| `externalPaymentId` | Idempotency key for the POS payment. |

Optional fields:

| Name | Description |
| --- | --- |
| `externalBillId` | POS bill/check/table ID stored as a mapping. |
| `method` | Payment method label, for example `card`, `cash`, `terminal`. |
| `billSubtotalAmount` | Bill subtotal. Defaults to MenüQR bill subtotal. |
| `tipAmount` | Tip amount. Defaults to `0.00`. |
| `grossAmount` | Total paid. Defaults to subtotal plus tip. |
| `paidAt` | Payment timestamp. Defaults to request time. |
| `metadata` | Extra provider metadata. |

## Idempotency

`externalPaymentId` is stored as:

```text
{provider}:{restaurantId}:payment:{externalPaymentId}
```

Resending the same settlement updates the existing POS payment record instead of creating a duplicate.
