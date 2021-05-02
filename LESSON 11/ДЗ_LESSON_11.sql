/* ОПТИМИЗАЦИЯ ЗАПРОСОВ */


/* ЗАДАНИЕ 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products 
в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.*/

-- Создаем БД для выполнения ДЗ к уроку 11:
CREATE DATABASE lesson_11; 
USE lesson_11;


-- Создаем таблицы users, catalogs и products. Вносим в таблицы тестовые данные.
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина' ENGINE=InnoDB;

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');



DROP TABLE IF EXISTS users;
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
  ('Мария', '1992-08-29');



DROP TABLE IF EXISTS products;
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
  
-- Создаем таблицу logs типа ARCHIVE
DROP TABLE IF EXISTS logs; 
CREATE TABLE logs (
	id SERIAL,
	table_name VARCHAR(255),
	row_id int,
	row_name varchar (255),
	created_at DATETIME
) ENGINE = ARCHIVE; 

-- Создаем триггеры:

-- 1) Триггер на таблицу users

DELIMITER //
CREATE TRIGGER insert_users_to_logs AFTER INSERT ON users
FOR EACH ROW BEGIN
  INSERT INTO logs (table_name, row_id,row_name,created_at) values ('users', NEW.id, NEW.name, now());
END //

-- Тестирование: вставляем новые данные в таблицу users и в таблице logs должны записаться данные о вставке.
INSERT INTO users (name, birthday_at) VALUES
  ('Вероника', '1994-02-05'),
  ('Ольга', '1983-12-12'),
  ('Александра', '1990-05-20');

SELECT * FROM logs;

-- 2) Триггер на таблицу products

DELIMITER //
CREATE TRIGGER insert_products_to_logs AFTER INSERT ON products
FOR EACH ROW BEGIN
  INSERT INTO logs (table_name, row_id,row_name,created_at) values ('products', NEW.id, NEW.name, now());
END //

-- Тестирование: вставляем новые данные в таблицу products и в таблице logs должны записаться данные о вставке.

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8105', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 10000.00, 1),
  ('Intel Core i5-7405', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 15000.00, 1);
  
SELECT * FROM logs;

-- 3) Триггер на таблицу catalogs

DELIMITER //
CREATE TRIGGER insert_catalogs_to_logs AFTER INSERT ON catalogs
FOR EACH ROW BEGIN
  INSERT INTO logs (table_name, row_id,row_name,created_at) values ('catalogs', NEW.id, NEW.name, now());
END //

-- Тестирование: вставляем новые данные в таблицу catalogs и в таблице logs должны записаться данные о вставке.

INSERT INTO catalogs VALUES
  (NULL, 'Мониторы'),
  (NULL, 'Видеокамеры'); 

SELECT * FROM logs;


/* ЗАДАНИЕ 2.(по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.*/

-- Поскольку 1000000 записей - довольно большое число, то лучше создать таблицу типа ARCHIVE
-- Из теории известно: Archive не поддерживает транзакции. Она оптимизирована лишь для высокоскоростной вставки и хранения данных в сжатом виде.

DROP TABLE IF EXISTS users; 
CREATE TABLE users (
	id SERIAL,
	name VARCHAR(255) ,
	created_at DATETIME
) ENGINE = ARCHIVE; 

-- Создаем процедуру, которая будет вставлять данные в таблицу users. В качестве входного параметра нужно ввести количество необходимых записей
DROP PROCEDURE IF EXISTS insert_into_users;

DELIMITER //
CREATE PROCEDURE insert_into_users (IN i int)
BEGIN
	DECLARE j INT DEFAULT 0;
	WHILE i > 0 DO
		INSERT INTO users(name, created_at) VALUES (CONCAT('user_', i), NOW());
		SET i = i - 1;
	END WHILE;
END //

-- Вызов процедуры. Тестирование 

CALL insert_into_users(10000); -- вставка за 6.625 sec
CALL insert_into_users(100000); -- вставка за 73.000 sec
CALL insert_into_users(500000); -- вставка за 351.313 sec
CALL insert_into_users(1000000); -- вставка за 656.391 sec


/* NoSQL*/

/* ЗАДАНИЕ 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов. */

-- Для выполнения задачи создаем хэш и вносим в нее данные

HMSET addresses 127.0.0.1 1 127.0.0.2 3 127.0.0.3 4

-- Можно получить все содержимое хэша

HGETALL addresses
1) "127.0.0.1"
2) "1"
3) "127.0.0.2"
4) "3"
5) "127.0.0.3"
6) "4"

-- Можно получить содержимое только определенного ключа (для примера 127.0.0.1)
HGET addresses 127.0.0.1
"1"


/* ЗАДАНИЕ 2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени. */

--2.1 Поиск электронного адреса пользователя по его имени

-- Создаем хэш emails
HMSET emails Olga 'OlgaIvanova@inbox.ru' Vladimir 'vladimir1999@gmail.com' Egor 'EgorTrifimov@inbox.ru'

-- Смотрим все ключи хэша 
HKEYS emails
1) "Olga"
2) "Vladimir"
3) "Egor"

--Можно запросить элект.почту для Ольги (по ключу "Olga")
HGET emails Olga
1) "OlgaIvanova@inbox.ru"

--Можно запросить элект.почту для Владимира (по ключу "Vladimir")
HGET emails Vladimir
1) "vladimir1999@gmail.com"

-- Можно запросить элект.почту для Егора (по ключу "Egor")
HGET emails Egor
1) "EgorTrifimov@inbox.ru"

--2.2 Поиск имени пользователя по электронному адресу

-- Создаем хэш users
HMSET users 'OlgaIvanova@inbox.ru' 'Olga' 'vladimir1999@gmail.com' 'Vladimir' 'EgorTrifimov@inbox.ru' 'Egor'

-- Смотрим все ключи хэша
HKEYS users
1) "OlgaIvanova@inbox.ru"
2) "vladimir1999@gmail.com"
3) "EgorTrifimov@inbox.ru"

--Можно запросить имя пользователя для почты - OlgaIvanova@inbox.ru
HGET users 'OlgaIvanova@inbox.ru'
1) "Olga"

--Можно запросить имя пользователя для почты - vladimir1999@gmail.com
HGET users 'vladimir1999@gmail.com'
1) "Vladimir"

--Можно запросить имя пользователя для почты - EgorTrifimov@inbox.ru
HGET users 'EgorTrifimov@inbox.ru'
1) "Egor"


/* ЗАДАНИЕ 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.*/

-- Создадим 2 коллекции: коллекция товаров и коллекция товарных категорий в БД shop

> use shop -- Создаем БД shop
switched to db shop

-- Вставляем данные (коллекция - Каталоги)

> db.catalogs.insert ({"name":"Процессоры"})
WriteResult({ "nInserted" : 1 })
> db.catalogs.insert ({"name":"Материнские платы"})
WriteResult({ "nInserted" : 1 })
> db.catalogs.insert ({"name":"Видеокарты"})
WriteResult({ "nInserted" : 1 })
> db.catalogs.insert ({"name":"Жесткие диски"})
WriteResult({ "nInserted" : 1 })
> db.catalogs.insert ({"name":"Оперативная память"})
WriteResult({ "nInserted" : 1 })

-- Смотрим вставленные документы вместе с добавленным идентификатором объекта:
> db.catalogs.find()
{ "_id" : ObjectId("608f0b904729952eb6fdfd30"), "name" : "Процессоры" }
{ "_id" : ObjectId("608f0b904729952eb6fdfd31"), "name" : "Материнские платы" }
{ "_id" : ObjectId("608f0b904729952eb6fdfd32"), "name" : "Видеокарты" }
{ "_id" : ObjectId("608f0b904729952eb6fdfd33"), "name" : "Жесткие диски" }
{ "_id" : ObjectId("608f0b924729952eb6fdfd34"), "name" : "Оперативная память" }


-- Вставляем данные (коллекция - Товарные позиции):
> db.products.insert ({"name": "Intel Core i3-8100", "description": "Процессор для настольных персональных компьютеров, основанных на платформе Intel", "price":"7890.00", "catalog": "Процессоры", "created_at": new Date(), "updated_at": new Date ()})
WriteResult({ "nInserted" : 1 })
> db.products.insert ({"name": "Intel Core i5-7400", "description": "Процессор для настольных персональных компьютеров, основанных на платформе Intel", "price":"12700.00","catalog": "Процессоры", "created_at": new Date(), "updated_at": new Date ()})
WriteResult({ "nInserted" : 1 })
> db.products.insert ({"name": "AMD FX-8320E", "description": "Процессор для настольных персональных компьютеров, основанных на платформе AMD", "price":"4780.00","catalog": "Процессоры", "created_at": new Date(), "updated_at": new Date ()})
WriteResult({ "nInserted" : 1 })
> db.products.insert ({"name": "AMD FX-8320", "description": "Процессор для настольных персональных компьютеров, основанных на платформе AMD", "price":"7120.00","catalog": "Процессоры", "created_at": new Date(), "updated_at": new Date ()})
WriteResult({ "nInserted" : 1 })
>  
> db.products.insert ({"name": "ASUS ROG MAXIMUS X HERO", "description": "Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX", "price":"19310.00","catalog": "Материнские платы", "created_at": new Date(), "updated_at": new Date ()})
WriteResult({ "nInserted" : 1 })
>  
> db.products.insert ({"name": "Gigabyte H310M S2H", "description": "Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX", "price":"4790.00","catalog": "Материнские платы", "created_at": new Date(), "updated_at": new Date ()})
WriteResult({ "nInserted" : 1 })
>  
> db.products.insert ({"name": "MSI B250M GAMING PRO", "description": "Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX", "price":"5060.00","catalog": "Материнские платы", "created_at": new Date(), "updated_at": new Date ()})
WriteResult({ "nInserted" : 1 })

-- Смотрим вставленные документы вместе с добавленным идентификатором объекта:
> db.products.find()
{ "_id" : ObjectId("608f06634729952eb6fdfd26"), "name" : "Intel Core i3-8100", "description" : "Процессор для настольных персональных компьютеров, основанных на платформе Intel", "price" : "7890.00", "catalog" : "Процессоры", "created_at" : ISODate("2021-05-02T20:06:59.107Z"), "updated_at" : ISODate("2021-05-02T20:06:59.107Z") }
{ "_id" : ObjectId("608f06794729952eb6fdfd27"), "name" : "Intel Core i5-7400", "description" : "Процессор для настольных персональных компьютеров, основанных на платформе Intel", "price" : "12700.00", "catalog" : "Процессоры", "created_at" : ISODate("2021-05-02T20:07:21.647Z"), "updated_at" : ISODate("2021-05-02T20:07:21.647Z") }
{ "_id" : ObjectId("608f06824729952eb6fdfd28"), "name" : "AMD FX-8320E", "description" : "Процессор для настольных персональных компьютеров, основанных на платформе AMD", "price" : "4780.00", "catalog" : "Процессоры", "created_at" : ISODate("2021-05-02T20:07:30.205Z"), "updated_at" : ISODate("2021-05-02T20:07:30.205Z") }
{ "_id" : ObjectId("608f06994729952eb6fdfd29"), "name" : "AMD FX-8320", "description" : "Процессор для настольных персональных компьютеров, основанных на платформе AMD", "price" : "7120.00", "catalog" : "Процессоры", "created_at" : ISODate("2021-05-02T20:07:53.996Z"), "updated_at" : ISODate("2021-05-02T20:07:53.996Z") }
{ "_id" : ObjectId("608f069a4729952eb6fdfd2a"), "name" : "ASUS ROG MAXIMUS X HERO", "description" : "Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX", "price" : "19310.00", "catalog" : "Материнские платы", "created_at" : ISODate("2021-05-02T20:07:54.022Z"), "updated_at" : ISODate("2021-05-02T20:07:54.022Z") }
{ "_id" : ObjectId("608f069a4729952eb6fdfd2b"), "name" : "Gigabyte H310M S2H", "description" : "Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX", "price" : "4790.00", "catalog" : "Материнские платы", "created_at" : ISODate("2021-05-02T20:07:54.048Z"), "updated_at" : ISODate("2021-05-02T20:07:54.048Z") }
{ "_id" : ObjectId("608f069c4729952eb6fdfd2c"), "name" : "MSI B250M GAMING PRO", "description" : "Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX", "price" : "5060.00", "catalog" : "Материнские платы", "created_at" : ISODate("2021-05-02T20:07:56.340Z"), "updated_at" : ISODate("2021-05-02T20:07:56.340Z") }



