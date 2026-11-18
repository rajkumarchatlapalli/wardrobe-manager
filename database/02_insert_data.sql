-- Wardrobe Manager (simple version) - Step 2: sample data

USE wardrobe_manager_db;

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
