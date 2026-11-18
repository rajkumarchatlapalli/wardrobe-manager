-- Wardrobe Manager (simple version) - Step 1: create the database and 3 tables
-- Run with MySQL 8.0 or newer.

CREATE DATABASE IF NOT EXISTS wardrobe_manager_db;
USE wardrobe_manager_db;

-- Delete old tables first (child tables before parent tables)
DROP TABLE IF EXISTS wear_log;
DROP TABLE IF EXISTS outfits;
DROP TABLE IF EXISTS items;

-- Table 1: items - every item you own
CREATE TABLE items (
    item_id        INT AUTO_INCREMENT PRIMARY KEY,
    item_name      VARCHAR(50)  NOT NULL,
    category       VARCHAR(20)  NOT NULL CHECK (category IN ('Tops', 'Bottoms', 'Footwear')),
    color          VARCHAR(20)  NOT NULL,
    price          DECIMAL(8,2) NOT NULL CHECK (price >= 0),
    bought_on      DATE         NOT NULL
);

-- Table 2: outfits - a saved combination of one top, one bottom and one pair of shoes
CREATE TABLE outfits (
    outfit_id      INT AUTO_INCREMENT PRIMARY KEY,
    outfit_name    VARCHAR(50)  NOT NULL UNIQUE,
    occasion       VARCHAR(20)  NOT NULL,
    top_id         INT NOT NULL,
    bottom_id      INT NOT NULL,
    shoes_id       INT NOT NULL,
    FOREIGN KEY (top_id)    REFERENCES items (item_id),
    FOREIGN KEY (bottom_id) REFERENCES items (item_id),
    FOREIGN KEY (shoes_id)  REFERENCES items (item_id)
);

-- Table 3: wear_log - one row each time an outfit is worn
CREATE TABLE wear_log (
    wear_id        INT AUTO_INCREMENT PRIMARY KEY,
    outfit_id      INT NOT NULL,
    worn_on        DATE NOT NULL,
    rating         INT CHECK (rating BETWEEN 1 AND 5),
    FOREIGN KEY (outfit_id) REFERENCES outfits (outfit_id)
);

INSERT INTO items (item_id, item_name, category, color, price, bought_on) VALUES
(1,  'White T-Shirt',       'Tops',     'White', 799.00,  '2024-03-10'),
(2,  'Navy Shirt',          'Tops',     'Navy',  1999.00, '2024-01-15'),
(3,  'Grey Sweater',        'Tops',     'Grey',  2499.00, '2023-11-02'),
(4,  'Red Hoodie',          'Tops',     'Red',   1599.00, '2025-01-12'),
(5,  'Blue Jeans',          'Bottoms',  'Blue',  3299.00, '2023-11-20'),
(6,  'Beige Chinos',        'Bottoms',  'Beige', 1799.00, '2024-02-18'),
(7,  'Black Trousers',      'Bottoms',  'Black', 2999.00, '2024-01-28'),
(8,  'White Sneakers',      'Footwear', 'White', 4999.00, '2024-04-01'),
(9,  'Brown Loafers',       'Footwear', 'Brown', 5499.00, '2023-08-14'),
(10, 'Black Running Shoes', 'Footwear', 'Black', 6499.00, '2024-07-22');

INSERT INTO outfits (outfit_id, outfit_name, occasion, top_id, bottom_id, shoes_id) VALUES
(1, 'Weekend Classic', 'Casual', 1, 5, 8),
(2, 'Office Friday',   'Office', 2, 6, 9),
(3, 'Winter Casual',   'Casual', 3, 5, 8),
(4, 'Lazy Day',        'Home',   1, 6, 8),
(5, 'Party Night',     'Party',  2, 5, 9);

INSERT INTO wear_log (outfit_id, worn_on, rating) VALUES
(1, '2025-01-05', 5),
(1, '2025-01-12', 4),
(1, '2025-02-02', 5),
(2, '2025-01-10', 4),
(2, '2025-01-17', 3),
(1, '2025-02-07', 4),
(3, '2025-01-20', 5),
(3, '2025-02-10', 4),
(4, '2025-01-26', 3),
(4, '2025-02-16', 4);
