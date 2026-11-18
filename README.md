# Wardrobe Manager

A simple MySQL database to track clothes, outfits and unused items. It stores your clothes and outfits and shows which clothes you **never wear**.

## Only 3 tables
| Table | What it stores |
|---|---|
| `items` | Every item you own (clothes, shoes): name, category, color, price, date bought |
| `outfits` | A saved outfit: one top, one bottom and one pair of shoes |
| `wear_log` | One row each time an outfit was worn, with a rating from 1 to 5 |

```
items (1) ---< (M) outfits (1) ---< (M) wear_log
```
Each outfit points to three rows in `items` (`top_id`, `bottom_id`, `shoes_id`).

## Files
```
wardrobe_manager/
|-- database/
|   |-- 01_create_tables.sql        creates the database and 3 tables
|   |-- 02_insert_data.sql          adds sample data (10 items, 5 outfits, 10 wear records)
|   |-- 03_queries.sql              13 simple practice queries
|   `-- wardrobe_manager_full_setup.sql files 01 and 02 together
|-- documentation/
|   |-- requirements.md            what the project must do
|   |-- database-design.md         tables, columns and relationships
|   `-- er-diagram.md              text diagram of the 3 tables
`-- README.md
```

## How to run
Install MySQL 8.0 or newer, then open a terminal in the `database` folder.

**Quickest (one command):**
```
mysql -u root -p < wardrobe_manager_full_setup.sql
```

**Step by step:**
```
mysql -u root -p < 01_create_tables.sql
mysql -u root -p < 02_insert_data.sql
```
Then open `03_queries.sql` in MySQL Workbench (or paste the queries into the `mysql` prompt) and run them one by one.

## Main query: items you never wear
```sql
SELECT item_name, category, price
FROM items
WHERE item_id NOT IN (
    SELECT o.top_id    FROM outfits o JOIN wear_log w ON w.outfit_id = o.outfit_id
    UNION
    SELECT o.bottom_id FROM outfits o JOIN wear_log w ON w.outfit_id = o.outfit_id
    UNION
    SELECT o.shoes_id  FROM outfits o JOIN wear_log w ON w.outfit_id = o.outfit_id
);
```
With the sample data this lists the Red Hoodie, Black Trousers and Black Running Shoes.

## SQL topics used
CREATE TABLE, PRIMARY KEY, FOREIGN KEY, CHECK, INSERT, SELECT, WHERE, ORDER BY, GROUP BY, COUNT, SUM, AVG, JOIN, LEFT JOIN, subquery, UNION, LIMIT.
