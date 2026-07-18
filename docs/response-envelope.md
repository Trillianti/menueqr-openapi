# HTTP Response Envelope

All `/api/...` JSON responses are wrapped by the MenüQR backend.

The payload shown in endpoint examples is the value of `data`. A successful
HTTP response has this shape:

```json
{
  "success": true,
  "data": {
    "items": []
  },
  "requestId": "req_...",
  "timestamp": "2026-07-18T12:00:00.000Z",
  "path": "/api/open/pos/custom/rest_123/orders",
  "method": "GET"
}
```

The endpoint-specific examples in this repository intentionally show only the
inner `data` payload to keep the resource shapes readable.

Errors use the same top-level metadata and return:

```json
{
  "success": false,
  "error": {
    "code": "POS_OPEN_API_KEY_INVALID",
    "message": "Open POS API key is invalid."
  },
  "requestId": "req_...",
  "timestamp": "2026-07-18T12:00:00.000Z",
  "path": "/api/open/pos/custom/rest_123/menu",
  "method": "GET"
}
```
