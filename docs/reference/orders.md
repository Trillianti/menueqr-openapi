# Orders

Use order endpoints to pull MenuQR table orders and acknowledge POS acceptance.

## List Orders

```http
GET /api/open/pos/{provider}/{restaurantId}/orders
```

Query parameters:

| Name | Type | Description |
| --- | --- | --- |
| `status` | `pending`, `completed`, `canceled` | Optional status filter. |
| `since` | ISO datetime | Only orders updated after this timestamp. |
| `limit` | integer, 1-100 | Defaults to 50. |

Example:

```bash
curl "https://api.example.com/api/open/pos/custom/rest_123/orders?status=pending&limit=50" \
  -H "x-menuqr-pos-api-key: $MENUQR_POS_API_KEY"
```

Response:

```json
{
  "items": [
    {
      "id": "order_123",
      "restaurantId": "rest_123",
      "tableNumber": 7,
      "status": "pending",
      "totalAmount": "12.00",
      "currency": "EUR",
      "items": []
    }
  ]
}
```

## Get Order

```http
GET /api/open/pos/{provider}/{restaurantId}/orders/{orderId}
```

## Acknowledge Order

```http
POST /api/open/pos/{provider}/{restaurantId}/orders/{orderId}/ack
```

Body:

```json
{
  "status": "completed",
  "externalOrderId": "pos_order_987",
  "externalParentId": "pos_table_7",
  "metadata": {
    "terminal": "front-register"
  }
}
```

Fields:

| Name | Required | Description |
| --- | --- | --- |
| `status` | No | Updates the MenuQR order status. |
| `externalOrderId` | No | POS order, transaction, or ticket ID. |
| `externalParentId` | No | Optional parent entity in the POS. |
| `metadata` | No | Extra integration metadata stored with the mapping. |

Recommended statuses:

- Send `completed` after the POS accepted and closed the order.
- Send `canceled` if the POS rejected or canceled it.
- Omit `status` if you only want to store `externalOrderId`.
