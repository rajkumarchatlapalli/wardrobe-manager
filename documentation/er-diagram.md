# Wardrobe Manager: ER Diagram (text format)

Legend: `PK` primary key, `FK` foreign key, `UK` unique key, `1` one, `M` many.

```
+-----------------------+            +-----------------------+            +-----------------------+
| items                 |            | outfits               |            | wear_log              |
+-----------------------+            +-----------------------+            +-----------------------+
| PK item_id            |1         M | PK outfit_id          |1         M | PK wear_id            |
|    item_name          |------------| UK outfit_name        |------------| FK outfit_id          |
|    category           |            |    occasion           |            |    worn_on            |
|    color              |            | FK top_id             |            |    rating             |
|    price              |            | FK bottom_id          |            +-----------------------+
|    bought_on          |            | FK shoes_id           |
+-----------------------+            +-----------------------+
```

`top_id`, `bottom_id` and `shoes_id` each point to `items.item_id`.

## Relationship summary
| Relationship | Type | Implemented by |
|---|---|---|
| items to outfits   | One-to-Many | `outfits.top_id`, `outfits.bottom_id`, `outfits.shoes_id` reference `items.item_id` |
| outfits to wear_log | One-to-Many | `wear_log.outfit_id` references `outfits.outfit_id` |
