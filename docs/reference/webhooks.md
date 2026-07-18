# Webhooks

Open webhook endpoints accept POS events through the same API-key auth as the rest of the open API.

```http
POST /api/open/pos/{provider}/{restaurantId}/webhooks
POST /api/open/pos/{provider}/{restaurantId}/webhooks/{eventType}
```

## Request

```bash
curl -X POST https://api.example.com/api/open/pos/custom/rest_123/webhooks/order.updated \
  -H "Content-Type: application/json" \
  -H "x-menuqr-pos-api-key: $MENUQR_POS_API_KEY" \
  -H "x-pos-event-id: event_123" \
  -d '{
    "externalOrderId": "pos_order_987",
    "status": "closed"
  }'
```

When `{eventType}` is present and the body is JSON, MenüQR injects `eventType` into the webhook payload before provider handling.

For the `custom` provider, the webhook is authenticated, stored, deduplicated,
and any mappings in the payload are persisted. It does not automatically update
an order or bill from arbitrary `externalOrderId` or `externalBillId` fields.
Provider-specific reconciliation is implemented by ready provider adapters
where supported. Scaffolded providers store the event as ignored.

## Response

```json
{
  "accepted": true,
  "duplicate": false,
  "dedupeKey": "event_123",
  "status": "processed",
  "code": "CUSTOM_POS_WEBHOOK_ACCEPTED",
  "message": "Custom POS webhook payload stored successfully.",
  "eventType": "order.updated",
  "signatureValid": null,
  "summary": {
    "payloadKeys": ["eventType", "externalOrderId", "status"]
  }
}
```

## Duplicate Response

```json
{
  "accepted": true,
  "duplicate": true,
  "dedupeKey": "event_123"
}
```

## Legacy Endpoint

Provider-specific webhook endpoints still exist:

```http
POST /api/pos/webhooks/{provider}/{restaurantId}
```

Use the open endpoint for new third-party developer integrations because it shares the same authentication model as read/write API calls.

The response body shown above is the inner `data` payload inside the standard
HTTP success envelope.
