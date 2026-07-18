# MenüQR POS Open API

Developer documentation for connecting external POS systems, middleware, and integration platforms to MenüQR.

Use this repository as a GitBook-style documentation source. Start with `SUMMARY.md`, then follow the quickstart and endpoint reference.

## What This API Covers

- Pull restaurant menu catalog data.
- Pull and acknowledge table orders.
- Pull and settle table bills.
- Store local-to-external entity mappings.
- Receive inbound POS webhooks through MenüQR.
- Use API-key authentication with optional HMAC body signatures.

## Base Path

```text
/api/open/pos/{provider}/{restaurantId}
```

Example:

```text
https://api.example.com/api/open/pos/custom/restaurant_123/menu
```

## Authentication

Pass the restaurant POS connection's `openApiKey` in one of these headers:

```http
Authorization: Bearer <openApiKey>
x-menuqr-pos-api-key: <openApiKey>
x-menuqr-api-key: <openApiKey>
x-api-key: <openApiKey>
```

For webhook and write requests, you may also include:

```http
x-menuqr-signature: sha256=<hmac_sha256_raw_body>
```

See [Authentication](docs/authentication.md) for details.

## HTTP Response Envelope

The backend wraps every JSON response under `/api` in a standard envelope:

```json
{
  "success": true,
  "data": {},
  "requestId": "req_...",
  "timestamp": "2026-07-18T12:00:00.000Z",
  "path": "/api/open/pos/custom/rest_123/menu",
  "method": "GET"
}
```

Endpoint examples show the inner `data` payload. See [HTTP Response Envelope](docs/response-envelope.md).

## Provider Availability

The `custom`, `mock`, and `poster` providers are implemented in the current
backend. `square`, `toast`, `clover`, and `lightspeed` are scaffolded provider
slots: discovery is available, but live sync and provider-specific webhook
processing are not implemented yet. Check `implementationStatus` and the
capabilities returned by discovery before enabling a provider in production.
