# Mappings

Mappings connect MenüQR local entity IDs to POS external entity IDs.

## List Mappings

```http
GET /api/open/pos/{provider}/{restaurantId}/mappings
```

Query parameters:

| Name | Type | Description |
| --- | --- | --- |
| `entityType` | enum | Optional filter. |
| `limit` | integer, 1-100 | Defaults to 50. |

Example:

```bash
curl "https://api.example.com/api/open/pos/custom/rest_123/mappings?entityType=menu_item" \
  -H "x-menuqr-pos-api-key: $MENUQR_POS_API_KEY"
```

## Upsert Mappings

```http
POST /api/open/pos/{provider}/{restaurantId}/mappings
```

Body:

```json
{
  "mappings": [
    {
      "entityType": "menu_item",
      "localEntityId": "item_123",
      "externalEntityId": "pos_product_987",
      "externalParentId": "pos_category_456",
      "metadata": {
        "syncedBy": "custom-bridge"
      }
    }
  ]
}
```

Response:

```json
{
  "accepted": true,
  "count": 1
}
```

## Entity Types

```text
category
menu_item
menu_item_variation
table_order
table_bill
```

## Limits

One request can upsert up to 500 mappings. Listing mappings currently returns
at most 100 records per request.
