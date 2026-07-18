# Errors

MenuQR returns the global API error envelope:

```json
{
  "success": false,
  "error": {
    "code": "POS_OPEN_API_KEY_INVALID",
    "message": "Open POS API key is invalid."
  },
  "requestId": "req_...",
  "timestamp": "2026-05-11T12:00:00.000Z",
  "path": "/api/open/pos/custom/rest_123/menu",
  "method": "GET"
}
```

Successful `/api` responses are also wrapped. See [HTTP Response Envelope](response-envelope.md).

## Common Status Codes

| Status | Meaning |
| --- | --- |
| `400` | Invalid request body, unsupported state transition, or invalid money amount. |
| `401` | Missing or invalid API key/signature. |
| `403` | Open API access or signature secret is not configured. |
| `404` | Restaurant, POS connection, order, or bill was not found. |
| `409` | Duplicate unique resource conflict. |
| `429` | Too many requests. |
| `500` | Internal server error. |

## Open API Error Codes

| Code | Meaning |
| --- | --- |
| `POS_OPEN_API_KEY_REQUIRED` | No accepted API-key header was provided. |
| `POS_OPEN_API_KEY_INVALID` | The provided key does not match the stored POS connection credentials. |
| `POS_OPEN_API_NOT_CONFIGURED` | The connection has no usable Open API credential. |
| `POS_OPEN_API_SIGNATURE_NOT_CONFIGURED` | A signature was sent, but no signing secret is configured. |
| `POS_OPEN_API_SIGNATURE_INVALID` | The HMAC signature does not match the raw body. |

## Idempotent Responses

Webhook duplicates return:

```json
{
  "accepted": true,
  "duplicate": true,
  "dedupeKey": "event_123"
}
```
