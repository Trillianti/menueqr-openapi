# Data Model

## Money

Money values are decimal strings with two fraction digits:

```json
"12.50"
```

Do not send floating point numbers from JavaScript clients when exact totals matter.

## Menu Payload

```json
{
  "schemaVersion": 1,
  "generatedAt": "2026-05-11T12:00:00.000Z",
  "restaurant": {
    "id": "rest_123",
    "name": "Cafe MenuQR",
    "slug": "cafe-menuqr",
    "currency": "EUR",
    "defaultLanguage": "de",
    "languages": ["de", "en"]
  },
  "categories": [],
  "items": []
}
```

## Category

```json
{
  "id": "cat_123",
  "name": { "de": "Kaffee", "en": "Coffee" },
  "description": {},
  "subCategories": [],
  "sortOrder": 0,
  "isActive": true
}
```

## Menu Item

```json
{
  "id": "item_123",
  "categoryId": "cat_123",
  "subCategory": null,
  "name": { "de": "Espresso" },
  "description": {},
  "price": "2.50",
  "imageUrl": "https://cdn.example.com/espresso.webp",
  "allergens": [],
  "dietaryTags": [],
  "isAvailable": true,
  "isFeatured": false,
  "sortOrder": 0,
  "variations": [
    {
      "id": "var_123",
      "name": { "de": "Doppelt" },
      "price": "3.50",
      "sortOrder": 0
    }
  ]
}
```

## Order

```json
{
  "id": "order_123",
  "restaurantId": "rest_123",
  "tableNumber": 7,
  "status": "pending",
  "totalAmount": "12.00",
  "currency": "EUR",
  "notes": "No onions",
  "createdAt": "2026-05-11T12:00:00.000Z",
  "updatedAt": "2026-05-11T12:00:00.000Z",
  "items": []
}
```

Order status:

```text
pending | completed | canceled
```

## Bill

```json
{
  "id": "bill_123",
  "restaurantId": "rest_123",
  "tableNumber": 7,
  "status": "open",
  "currency": "EUR",
  "subtotal": "42.80",
  "paidAt": null,
  "items": [],
  "payments": []
}
```

Bill status:

```text
open | paid | canceled
```
