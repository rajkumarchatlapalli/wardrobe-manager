# Wardrobe Manager: Requirements

## 1. Problem
Most people own clothes they almost never wear. Without a record, it is hard to know which clothes are unused or which outfits are your favorites.

## 2. Goal
Build a small MySQL database that stores clothes and outfits, records when each outfit is worn, and shows which clothes are never worn.

## 3. What the system must do
| No. | Requirement | Table used |
|---|---|---|
| 1 | Store every clothing item with category, color, price and purchase date | `items` |
| 2 | Save outfits made of one top, one bottom and one pair of shoes | `outfits` |
| 3 | Record each day an outfit was worn, with a rating from 1 to 5 | `wear_log` |
| 4 | Find clothes that were never worn | queries on all 3 tables |
| 5 | Show the most worn outfit and the average rating of each outfit | `outfits`, `wear_log` |
| 6 | Show total money spent, overall and by category | `items` |

## 4. Users
The wardrobe owner, who adds clothes, creates outfits, logs what was worn and reads the results.

## 5. Workflow
1. Run the setup script to create the database and sample data.
2. Add items to `items`.
3. Create outfits in `outfits` by choosing a top, a bottom and shoes.
4. Add a row to `wear_log` each time an outfit is worn.
5. Run the queries in `03_queries.sql` to see unused clothes, favorite outfits and spending.

## 6. Technology
MySQL 8.0 or newer. Any client works: MySQL Workbench, DBeaver or the `mysql` command line.

## 7. Limits of this simple version
- An outfit has exactly three slots: top, bottom and shoes (no jackets, belts or accessories).
- There is a single user and no login.
- Changing an outfit changes how its past wears count for each item.
