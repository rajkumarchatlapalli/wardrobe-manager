-- Wardrobe Manager (simple version) - Step 3: practice queries
-- Run these one by one after steps 1 and 2.

USE wardrobe_manager_db;

-- Q1. Show everything in the wardrobe.
SELECT * FROM items;

-- Q2. Only the tops.
SELECT item_name, color FROM items WHERE category = 'Tops';

-- Q3. Items that cost more than 3000, most expensive first.
SELECT item_name, price FROM items WHERE price > 3000 ORDER BY price DESC;

-- Q4. How many items in each category?
SELECT category, COUNT(*) AS total_items
FROM items
GROUP BY category;

-- Q5. Total money spent on items.
SELECT SUM(price) AS total_spent FROM items;

-- Q6. Money spent in each category.
SELECT category, SUM(price) AS spent
FROM items
GROUP BY category;

-- Q7. Each outfit with the real names of its top, bottom and shoes.
SELECT o.outfit_name, o.occasion,
       t.item_name AS top,
       b.item_name AS bottom,
       s.item_name AS shoes
FROM outfits o
JOIN items t ON t.item_id = o.top_id
JOIN items b ON b.item_id = o.bottom_id
JOIN items s ON s.item_id = o.shoes_id;

-- Q8. Every day an outfit was worn, newest first.
SELECT w.worn_on, o.outfit_name, w.rating
FROM wear_log w
JOIN outfits o ON o.outfit_id = w.outfit_id
ORDER BY w.worn_on DESC;

-- Q9. How many times was each outfit worn? (0 = never worn)
SELECT o.outfit_name, COUNT(w.wear_id) AS times_worn
FROM outfits o
LEFT JOIN wear_log w ON w.outfit_id = o.outfit_id
GROUP BY o.outfit_id, o.outfit_name
ORDER BY times_worn DESC;

-- Q10. Average rating of each outfit.
SELECT o.outfit_name, ROUND(AVG(w.rating), 1) AS average_rating
FROM outfits o
JOIN wear_log w ON w.outfit_id = o.outfit_id
GROUP BY o.outfit_id, o.outfit_name
ORDER BY average_rating DESC;

-- Q11. The most worn outfit.
SELECT o.outfit_name, COUNT(*) AS times_worn
FROM wear_log w
JOIN outfits o ON o.outfit_id = w.outfit_id
GROUP BY o.outfit_id, o.outfit_name
ORDER BY times_worn DESC
LIMIT 1;

-- Q12. MAIN GOAL: items you NEVER wear
-- (items that are not part of any outfit that was worn).
SELECT item_name, category, price
FROM items
WHERE item_id NOT IN (
    SELECT o.top_id    FROM outfits o JOIN wear_log w ON w.outfit_id = o.outfit_id
    UNION
    SELECT o.bottom_id FROM outfits o JOIN wear_log w ON w.outfit_id = o.outfit_id
    UNION
    SELECT o.shoes_id  FROM outfits o JOIN wear_log w ON w.outfit_id = o.outfit_id
);

-- Q13. Money wasted on items that are never worn.
SELECT SUM(price) AS money_on_unused_items
FROM items
WHERE item_id NOT IN (
    SELECT o.top_id    FROM outfits o JOIN wear_log w ON w.outfit_id = o.outfit_id
    UNION
    SELECT o.bottom_id FROM outfits o JOIN wear_log w ON w.outfit_id = o.outfit_id
    UNION
    SELECT o.shoes_id  FROM outfits o JOIN wear_log w ON w.outfit_id = o.outfit_id
);

-- Examples of changing data (INSERT, UPDATE, DELETE):
-- INSERT INTO wear_log (outfit_id, worn_on, rating) VALUES (5, '2025-03-01', 5);
-- UPDATE items SET price = 899.00 WHERE item_id = 1;
-- DELETE FROM wear_log WHERE wear_id = 10;
