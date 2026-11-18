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
