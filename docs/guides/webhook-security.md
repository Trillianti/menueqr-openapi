# Webhook Security

## Recommended Headers

```http
x-menuqr-pos-api-key: <openApiKey>
x-menuqr-signature: sha256=<digest>
x-pos-event-id: <stable-event-id>
```

## Signature Example

```js
import { createHmac } from "crypto";

const rawBody = JSON.stringify(payload);
const signature = createHmac("sha256", process.env.MENUQR_SIGNING_SECRET)
  .update(rawBody)
  .digest("hex");

await fetch(webhookUrl, {
  method: "POST",
  headers: {
    "Content-Type": "application/json",
    "x-menuqr-pos-api-key": process.env.MENUQR_POS_API_KEY,
    "x-menuqr-signature": `sha256=${signature}`,
    "x-pos-event-id": payload.id
  },
  body: rawBody
});
```

## Replay Protection

MenuQR deduplicates webhook deliveries by event ID or raw-body hash. A duplicate returns `accepted: true` and `duplicate: true`.

For stronger replay controls, external middleware should include stable event IDs and avoid reusing IDs for different payloads.
