# Workflows

## Catalog Sync

1. Call `GET /menu`.
2. Create or update categories and products in the POS.
3. Send created IDs to `POST /mappings`.
4. Repeat safely whenever MenüQR menu data changes.

## Order Push

1. Poll `GET /orders?status=pending`.
2. Create a POS order or transaction.
3. Call `POST /orders/{orderId}/ack` with `externalOrderId`.
4. Store mapping locally as well if your middleware has its own database.

## Bill Settlement

1. Poll `GET /bills?status=open`.
2. Close or settle the table in the POS.
3. Call `POST /bills/{billId}/settle` with `externalPaymentId`.
4. MenüQR marks the bill paid and completes linked pending orders.

## Webhook-Driven Updates

1. POS sends event to `/webhooks/{eventType}`.
2. MenüQR authenticates and deduplicates the event.
3. Provider adapter records the webhook and may reconcile local data.
4. Response includes `accepted`, `duplicate`, `status`, and `dedupeKey`.

## Recommended Polling Intervals

- Menu: on publish/change, or every 5-15 minutes.
- Orders: every 5-15 seconds for live service.
- Bills: every 15-30 seconds if the POS is the payment source.
- Mappings: pull on startup, then update incrementally.
