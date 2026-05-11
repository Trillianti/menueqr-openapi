# Discovery

Returns connection status, capabilities, endpoint paths, and authentication hints.

```http
GET /api/open/pos/{provider}/{restaurantId}
```

## Request

```bash
curl https://api.example.com/api/open/pos/custom/rest_123 \
  -H "Authorization: Bearer $MENUQR_POS_API_KEY"
```

## Response

```json
{
  "ok": true,
  "provider": "custom",
  "restaurantId": "rest_123",
  "signatureValid": null,
  "implementationStatus": "ready",
  "status": "connected",
  "capabilities": {
    "canTestConnection": true,
    "canReceiveWebhooks": true,
    "canPushMenu": true,
    "canPushOrders": true,
    "canPushBills": true,
    "canPullCatalogPreview": true
  },
  "endpoints": {
    "discovery": "/api/open/pos/custom/rest_123",
    "menu": "/api/open/pos/custom/rest_123/menu",
    "orders": "/api/open/pos/custom/rest_123/orders",
    "bills": "/api/open/pos/custom/rest_123/bills",
    "mappings": "/api/open/pos/custom/rest_123/mappings",
    "webhooks": "/api/open/pos/custom/rest_123/webhooks/{eventType}",
    "legacyWebhook": "/api/pos/webhooks/custom/rest_123"
  }
}
```

## Notes

- Use discovery before enabling a live integration.
- `signatureValid` is `true` only when `x-menuqr-signature` is provided and valid.
- `implementationStatus` can be `ready` or `scaffolded`.
