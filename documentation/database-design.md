# Wardrobe Manager: Database Design

**Database name:** `wardrobe_manager_db` (MySQL 8.0+)

Only three tables are used.

| Table | Purpose |
|---|---|
| `items` | Every item you own (clothes and shoes) |
| `outfits` | Saved combinations of a top, a bottom and shoes |
| `wear_log` | One row each time an outfit is worn |

## items
| Column | Type | Rules | Meaning |
|---|---|---|---|
| item_id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique item number |
| item_name | VARCHAR(50) | NOT NULL | Name of the item |
| category | VARCHAR(20) | NOT NULL, must be Tops, Bottoms or Footwear | Kind of clothing |
| color | VARCHAR(20) | NOT NULL | Main color |
| price | DECIMAL(8,2) | NOT NULL, must be 0 or more | Price paid |
| bought_on | DATE | NOT NULL | Purchase date |

## outfits
| Column | Type | Rules | Meaning |
|---|---|---|---|
| outfit_id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique outfit number |
| outfit_name | VARCHAR(50) | NOT NULL, UNIQUE | Name such as "Weekend Classic" |
| occasion | VARCHAR(20) | NOT NULL | Casual, Office, Party, Home ... |
| top_id | INT | NOT NULL, FOREIGN KEY to items | The top in the outfit |
| bottom_id | INT | NOT NULL, FOREIGN KEY to items | The bottom in the outfit |
| shoes_id | INT | NOT NULL, FOREIGN KEY to items | The shoes in the outfit |

## wear_log
| Column | Type | Rules | Meaning |
|---|---|---|---|
| wear_id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique log entry |
| outfit_id | INT | NOT NULL, FOREIGN KEY to outfits | Outfit that was worn |
| worn_on | DATE | NOT NULL | Date it was worn |
| rating | INT | 1 to 5, may be empty | How much you liked it |

## Relationships
- **One outfit to many wear records.** One outfit can be worn many times. Each row in `wear_log` points to one outfit through `outfit_id`.
- **One item to many outfits.** The same shirt can be used in several outfits. Each outfit stores the item numbers of its top, bottom and shoes (`top_id`, `bottom_id`, `shoes_id`), all pointing to `clothes.item_id`.

## Why only three tables
A fourth table for categories is not needed, because the category is just one fixed value per item, so it is a column on `items`. A junction table for outfit items is not needed either, because every outfit has exactly three pieces, so they are stored as three columns on `outfits`.

## Normalization (simple view)
- Every column holds a single value, and every table has a primary key.
- Nothing is repeated: item details live only in `items`, and outfits refer to items by number.
- The trade-off is that an outfit can hold only a top, a bottom and shoes.
