# Quickstart

This guide shows the shortest path from a configured MenuQR POS connection to a working integration.

## 1. Configure a POS Connection

In MenuQR, create or update a POS connection for the restaurant. For generic integrations use provider `custom`; for sandbox testing use `mock`.

Store an `openApiKey` credential on the POS connection. This key is used by external developers and middleware to call the open API.

## 2. Verify Discovery

```bash
curl https://api.example.com/api/open/pos/custom/rest_123 \
  -H "Authorization: Bearer $MENUQR_POS_API_KEY"
```

Successful response:

```json
{
  "ok": true,
  "provider": "custom",
  "restaurantId": "rest_123",
  "status": "connected",
  "capabilities": {
    "canReceiveWebhooks": true,
    "canPushMenu": true,
    "canPushOrders": true,
    "canPushBills": true
  }
}
```

The JSON above is the inner `data` payload. The actual HTTP response is
wrapped in the standard success envelope described in [HTTP Response Envelope](response-envelope.md).

## 3. Pull Menu Data

```bash
curl https://api.example.com/api/open/pos/custom/rest_123/menu \
  -H "x-menuqr-pos-api-key: $MENUQR_POS_API_KEY"
```

The response contains a POS-ready `payload` with restaurant, categories, menu items, variations, and any existing external mappings.

## 4. Pull New Orders

```bash
curl "https://api.example.com/api/open/pos/custom/rest_123/orders?status=pending&limit=50" \
  -H "x-menuqr-pos-api-key: $MENUQR_POS_API_KEY"
```

## 5. Acknowledge an Order

After the POS accepts an order, store the POS transaction ID in MenuQR:

```bash
curl -X POST https://api.example.com/api/open/pos/custom/rest_123/orders/order_123/ack \
  -H "Content-Type: application/json" \
  -H "x-menuqr-pos-api-key: $MENUQR_POS_API_KEY" \
  -d '{
    "status": "completed",
    "externalOrderId": "pos_order_987"
  }'
```

## 6. Settle a Bill

When the POS closes or pays a table bill:

```bash
curl -X POST https://api.example.com/api/open/pos/custom/rest_123/bills/bill_123/settle \
  -H "Content-Type: application/json" \
  -H "x-menuqr-pos-api-key: $MENUQR_POS_API_KEY" \
  -d '{
    "externalPaymentId": "payment_987",
    "externalBillId": "pos_bill_456",
    "method": "card",
    "grossAmount": "42.80",
    "tipAmount": "3.00",
    "paidAt": "2026-05-11T12:30:00.000Z"
  }'
```

## 7. Send Webhooks

```bash
curl -X POST https://api.example.com/api/open/pos/custom/rest_123/webhooks/order.updated \
  -H "Content-Type: application/json" \
  -H "x-menuqr-pos-api-key: $MENUQR_POS_API_KEY" \
  -d '{
    "id": "event_123",
    "externalOrderId": "pos_order_987",
    "status": "closed"
  }'
```
