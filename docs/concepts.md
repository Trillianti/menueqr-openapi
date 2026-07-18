# Concepts

## Provider

The provider path segment identifies the POS connector:

```text
custom | mock | poster | square | toast | clover | lightspeed
```

`custom` is the recommended provider for third-party developers building middleware. `mock` is used for sandbox testing. Provider-specific adapters may support additional behavior.

## Restaurant ID

Every endpoint is scoped to one restaurant:

```text
/api/open/pos/{provider}/{restaurantId}
```

The API key must belong to the POS connection for the same restaurant and provider.

## Local Entity IDs

MenüQR IDs are stable UUID-like strings. External POS systems should store mappings from MenüQR local IDs to POS IDs.

Common entity types:

```text
category
menu_item
menu_item_variation
table_order
table_bill
```

## Mappings

Mappings are the synchronization memory between MenüQR and a POS system:

```json
{
  "entityType": "menu_item",
  "localEntityId": "item_123",
  "externalEntityId": "pos_product_987",
  "externalParentId": "pos_category_456",
  "metadata": {
    "syncedBy": "custom-bridge"
  }
}
```

MenüQR uses mappings to avoid duplicate products, orders, bills, and payments during repeated syncs.

## Webhooks

Inbound POS webhooks are stored, deduplicated, and optionally reconciled by provider adapters. The request is deduplicated by:

1. `x-pos-event-id`
2. `x-event-id`
3. `x-request-id`
4. payload identifiers such as `id`, `eventId`, `reference`, `uuid`
5. SHA-256 hash of the raw body
