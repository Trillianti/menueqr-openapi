# MenuQR POS Open API

Developer documentation for connecting external POS systems, middleware, and integration platforms to MenuQR.

Use this repository as a GitBook-style documentation source. Start with `SUMMARY.md`, then follow the quickstart and endpoint reference.

## What This API Covers

- Pull restaurant menu catalog data.
- Pull and acknowledge table orders.
- Pull and settle table bills.
- Store local-to-external entity mappings.
- Receive inbound POS webhooks through MenuQR.
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
