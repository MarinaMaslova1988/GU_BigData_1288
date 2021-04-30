
/* ЗАДАНИЕ 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.*/

-- Для начала создадим таблицу users и таблицу orders, а также заполним таблицы данными

create database lesson_7; -- создаем БД

use lesson_7; -- переключаемся на созданную БД

CREATE TABLE users ( 
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29'),
  ('Алексей', '1984-05-20'),
  ('Петр', '1988-01-14'),
  ('Игорь', '1978-01-11'),
  ('Марина', '1988-08-29');
  
 -- В таблице users пользователям присвоился id от 1 до 10 включительно.   
  
 CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

INSERT INTO orders (user_id) values (1), (1), (2), (3), (4), (6), (8), (9), (9), (10), (10), (10); -- в таблице orders НЕТ заказов для пользователей с id = 5 и id = 7 !!!

SELECT * FROM users u -- поиск пользователей, которые сделали хотя бы 1 заказ в магазине
WHERE EXISTS (SELECT 1 FROM orders o where u.id = o.user_id);



/* ЗАДАНИЕ 2. Выведите список товаров products и разделов catalogs, который соответствует товару.*/

-- Создаем таблицу products и таблицу catalogs. Заполняем таблицы данными

CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');
  
 
  CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);


-- Выводим список товаров и соответствующих им наименований каталогов (АКТУАЛЬНО, ЕСЛИ МЫ УВЕРЕНЫ, ЧТО В ТАБЛИЦЕ products поле catalog_id заполнено для всех товаров!)
 SELECT p.name
  , p.description
  , p.price
  , p.catalog_id
  , c.name
  FROM products p
  INNER JOIN catalogs c on p.catalog_id = c.id

-- Если НЕТ уверенности, что поле catalog_id заполнено для всех наименований товаров, то лучше использовать LEFT или RIGHT JOIN (зависит от расположения таблицы products в запросе)

  SELECT p.name
  , p.description
  , p.price
  , p.catalog_id
  , c.name
  FROM products p
  LEFT JOIN catalogs c on p.catalog_id = c.id
  
  
  
  /* ЗАДАНИЕ 3.(по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
  Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов. */
  
 CREATE TABLE flights (
id SERIAL PRIMARY KEY,
from_ VARCHAR(100) NOT NULL,
to_ VARCHAR(100) NOT NULL)
COMMENT = 'Рейсы';

INSERT INTO flights (from_, to_) values
('moscow','omsk'),
('novgorod','kazan'),
('irkutsk','moscow'),
('omsk','irkutsk'),
('moscow','kazan');

CREATE TABLE cities (
id SERIAL PRIMARY KEY,
label VARCHAR(100) NOT NULL,
name VARCHAR(100) NOT NULL
) COMMENT = 'Города';

INSERT INTO cities (label, name) values
('moscow','Москва'),
('novgorod','Новгород'),
('irkutsk','Иркутск'),
('omsk','Омск'),
('kazan','Казань');

-- Выводим рейсы, используя русские наименования городов

SELECT C.name AS `From`, C1.name as `To`
FROM flights f
INNER JOIN cities C ON c.label = f.from_
INNER JOIN cities C1 ON c1.label = f.to_
ORDER BY f.id