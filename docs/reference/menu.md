# Menu

Pulls a POS-ready menu payload and existing mappings.

```http
GET /api/open/pos/{provider}/{restaurantId}/menu
```

## Request

```bash
curl https://api.example.com/api/open/pos/custom/rest_123/menu \
  -H "x-menuqr-pos-api-key: $MENUQR_POS_API_KEY"
```

## Response

```json
{
  "provider": "custom",
  "restaurantId": "rest_123",
  "signatureValid": null,
  "payload": {
    "schemaVersion": 1,
    "generatedAt": "2026-05-11T12:00:00.000Z",
    "restaurant": {},
    "categories": [],
    "items": []
  },
  "mappings": [
    {
      "entityType": "menu_item",
      "localEntityId": "item_123",
      "externalEntityId": "pos_product_987",
      "externalParentId": "pos_category_456",
      "metadata": {}
    }
  ]
}
```

## Integration Rules

- Treat MenüQR IDs as the source of truth for catalog objects.
- Store all created POS IDs through `POST /mappings`.
- Repeated menu pulls are safe; use mappings to upsert instead of creating duplicates.
- Prices are decimal strings.
