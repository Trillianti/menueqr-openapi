# Idempotency and Mappings

Idempotency is the difference between a POS integration that survives retries and one that creates duplicate checks.

## Catalog

For each MenüQR category, item, and variation:

1. Look up an existing mapping.
2. If present, update the POS entity.
3. If missing, create the POS entity.
4. Upsert the mapping back to MenüQR.

## Orders

Use `externalOrderId` in `POST /orders/{orderId}/ack`.

If the bridge retries after a timeout, read mappings first. If the mapping exists, do not create a second POS ticket.

## Bills

Use a stable `externalPaymentId` in `POST /bills/{billId}/settle`.

MenüQR stores it as:

```text
{provider}:{restaurantId}:payment:{externalPaymentId}
```

Retries update the existing payment instead of creating another payment.

## Webhooks

Always send one of:

```http
x-pos-event-id
x-event-id
x-request-id
```

If no ID is present, MenüQR hashes the raw body. This is safe for exact duplicate requests, but less useful if the same logical event is serialized differently.
