# Authentication

MenuQR POS Open API uses shared-key authentication configured per restaurant POS connection.

## API Key

The recommended credential is:

```json
{
  "openApiKey": "a-long-random-secret"
}
```

Accepted request headers:

```http
Authorization: Bearer <openApiKey>
x-menuqr-pos-api-key: <openApiKey>
x-menuqr-api-key: <openApiKey>
x-api-key: <openApiKey>
```

The OpenAPI YAML formally models the recommended `x-menuqr-pos-api-key`
header and bearer authentication. The other two API-key headers are accepted
for compatibility by the backend.

For compatibility, MenuQR can also accept `developerApiKey`, `apiKey`, or `webhookSecret` if those are stored on the POS connection.

## Optional HMAC Signature

For write and webhook requests, sign the raw request body with HMAC-SHA256:

```text
x-menuqr-signature: sha256=<hex_digest>
```

Digest calculation:

```js
import { createHmac } from "crypto";

const signature = createHmac("sha256", signingSecret)
  .update(rawBody)
  .digest("hex");
```

Secret priority:

1. `openApiSigningSecret`
2. `webhookSecret`
3. `openApiKey`
4. `apiKey`

If `x-menuqr-signature` is omitted, MenuQR authenticates with API key only. If it is present and invalid, the request is rejected.

## Security Recommendations

- Generate at least 32 random bytes for `openApiKey`.
- Use HTTPS only.
- Rotate keys after developer handoff, compromised logs, or vendor changes.
- Do not reuse a payment provider key or Telegram token as the POS Open API key.
- Prefer HMAC signatures for webhooks and settlement calls.
