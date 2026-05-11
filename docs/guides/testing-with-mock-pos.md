# Testing with Mock POS

Provider `mock` is designed for local and staging tests without a real POS vendor.

## Configure

Create a POS connection with:

```json
{
  "provider": "mock",
  "credentials": {
    "openApiKey": "dev-key"
  },
  "settings": {
    "outletName": "Sandbox register",
    "echoPayload": true
  }
}
```

## Test Discovery

```bash
curl http://localhost:3000/api/open/pos/mock/rest_123 \
  -H "x-menuqr-pos-api-key: dev-key"
```

## Test Webhook

```bash
curl -X POST http://localhost:3000/api/open/pos/mock/rest_123/webhooks/mock.order \
  -H "Content-Type: application/json" \
  -H "x-menuqr-pos-api-key: dev-key" \
  -H "x-pos-event-id: mock-event-1" \
  -d '{
    "mappings": [
      {
        "entityType": "table_order",
        "localEntityId": "order_123",
        "externalEntityId": "mock_order_123"
      }
    ]
  }'
```

The mock provider accepts mappings in the webhook payload and stores them through the POS mapping layer.
