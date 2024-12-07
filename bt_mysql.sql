



CREATE DATABASE AppFood;


CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

INSERT INTO user (full_name, email, password)
VALUES 
('Nguyen Van A', 'a@gmail.com', '123456'),
('Tran Thi B', 'b@gmail.com', '654321');



CREATE TABLE restaurant (
    res_id INT AUTO_INCREMENT PRIMARY KEY,
    res_name VARCHAR(255) NOT NULL,
    image VARCHAR(255),
    `desc` VARCHAR(255)
);

INSERT INTO restaurant (res_name, image, `desc`)
VALUES 
('Pizza Hut', 'pizzahut.jpg', 'Famous for pizzas'),
('KFC', 'kfc.jpg', 'Fried chicken specialist');





CREATE TABLE food_type (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(255) NOT NULL
);

INSERT INTO food_type (type_name)
VALUES 
('Pizza'),
('Chicken'),
('Drinks'),
('egg'),
('cake')




CREATE TABLE food (
    food_id INT AUTO_INCREMENT PRIMARY KEY,
    food_name VARCHAR(255) NOT NULL,
    image VARCHAR(255),
    price FLOAT NOT NULL,
    `desc` VARCHAR(255),
    type_id INT NOT NULL,
    FOREIGN KEY (type_id) REFERENCES food_type(type_id) ON DELETE CASCADE
);

INSERT INTO food (food_name, image, price, `desc`, type_id)
VALUES 
('Pepperoni Pizza', 'pepperoni.jpg', 120.5, 'Delicious pepperoni pizza', 1),
('Fried Chicken', 'fried_chicken.jpg', 50.0, 'Crispy fried chicken', 2)
('omelet', 'omelet.jpg', 10.0, 'delicious', 3)




CREATE TABLE sub_food (
    sub_id INT AUTO_INCREMENT PRIMARY KEY,
    sub_name VARCHAR(255) NOT NULL,
    sub_price FLOAT NOT NULL,
    food_id INT NOT NULL,
    FOREIGN KEY (food_id) REFERENCES food(food_id) ON DELETE CASCADE
);

INSERT INTO sub_food (sub_name, sub_price, food_id)
VALUES 
('Extra Cheese', 15.0, 1),
('Spicy Sauce', 5.0, 2);




CREATE TABLE `order` (
    user_id INT NOT NULL,
    food_id INT NOT NULL,
    amount INT NOT NULL,
    code VARCHAR(255),
    arr_sub_id VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE,
    FOREIGN KEY (food_id) REFERENCES food(food_id) ON DELETE CASCADE
);

INSERT INTO `order` (user_id, food_id, amount, code, arr_sub_id)
VALUES 
(1, 1, 2, 'ORDER2222', '4,3'),
(2, 2, 1, 'ORDER7865', '2');





CREATE TABLE rate_res (
    user_id INT NOT NULL,
    res_id INT NOT NULL,
    amount INT NOT NULL,
    date_rate DATETIME NOT NULL,
    PRIMARY KEY (user_id, res_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE,
    FOREIGN KEY (res_id) REFERENCES restaurant(res_id) ON DELETE CASCADE
);

INSERT INTO rate_res (user_id, res_id, amount, date_rate)
VALUES 
(1, 1, 5, '2024-12-01 10:00:00'),
(2, 2, 4, '2024-12-02 15:00:00');




CREATE TABLE like_res (
    user_id INT NOT NULL,
    res_id INT NOT NULL,
    date_like DATETIME NOT NULL,
    PRIMARY KEY (user_id, res_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE,
    FOREIGN KEY (res_id) REFERENCES restaurant(res_id) ON DELETE CASCADE
);

INSERT INTO like_res (user_id, res_id, date_like)
VALUES 
(1, 1, '2024-12-01 11:00:00'),
(2, 2, '2024-12-02 16:00:00');

-- tìm người đã like nhiều nhất
SELECT user_id, COUNT(res_id) AS like_count
FROM like_res
GROUP BY user_id
ORDER BY like_count DESC
LIMIT 5;

--tìm 2 nhà hàng có like nhiều nhất
SELECT res_id, COUNT(user_id) AS like_count
FROM like_res
GROUP BY res_id
ORDER BY like_count DESC
LIMIT 2;


-- tìm người đặt hàng nhiều nhất
SELECT user_id, COUNT(food_id) AS order_count
FROM `order`
GROUP BY user_id
ORDER BY order_count DESC
LIMIT 1;

-- tìm người dùng không hoạt động
SELECT u.user_id, u.full_name
FROM user u
LEFT JOIN `order` o ON u.user_id = o.user_id
LEFT JOIN like_res lr ON u.user_id = lr.user_id
LEFT JOIN rate_res rr ON u.user_id = rr.user_id
WHERE o.user_id IS NULL 
  AND lr.user_id IS NULL 
  AND rr.user_id IS NULL;




