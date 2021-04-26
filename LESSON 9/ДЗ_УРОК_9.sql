/* ТРАНЗАКЦИИ, ПРЕДСТАВЛЕНИЯ

ЗАДАНИЕ 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.*/

CREATE DATABASE shop; -- создаем БД shop
CREATE DATABASE sample; -- создаем БД sample

USE shop; -- в БД shop создаем таблицу users
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

USE sample; -- в БД sample создаем таблицу users
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

-- Заполняем таблицу users (БД shop) тестовыми данными

USE shop;
INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
  
-- Код транзакции:

  START TRANSACTION; -- начало транзакции
  INSERT INTO sample.users SELECT * FROM shop.users WHERE id=1; -- запись в таблицу sample.users данных о пользователе с id=1
  DELETE FROM shop.users WHERE id=1; -- удаление данных о пользователе с id=1 из таблицы shop.users 
  COMMIT; -- завершение транзакции
  

/* ЗАДАНИЕ 2. Создайте представление, которое выводит название name товарной позиции из таблицы products 
и соответствующее название каталога name из таблицы catalogs.*/

USE shop; -- для выполнения задачи используем одну из созданных ранее БД

-- Создаем 2 таблицы (products, catalogs) и заполняем их тестовыми данными 

DROP TABLE IF EXISTS catalogs; -- Таблица каталогов
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

DROP TABLE IF EXISTS products; -- Таблица продуктов
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  desсription TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO products
  (name, desсription, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

-- Создание VIEW
CREATE VIEW catalog_product 
AS 
SELECT p.name as product_name, c.name as catalog_name
FROM products p
INNER JOIN catalogs c on p.catalog_id = c.id 


/* ЗАДАНИЕ 3.(по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи за август 2018 года 
'2018-08-01', '2018-08-04', '2018-08-16' и 2018-08-17. 
Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.*/

-- Cоздаем и заполняем таблицу указанными в задании датами августа

USE shop; -- используем ранее созданную БД shop

DROP TABLE if EXISTS august_dates;
CREATE TABLE august_dates
(id SERIAL PRIMARY KEY,
created_at date
) COMMENT 'Даты августа';

INSERT INTO august_dates (created_at) values ('2018-08-01'), ('2018-08-04'), ('2018-08-16'), ('2018-08-17');
COMMIT;

/* Создаем таблицу days для хранения всех дат за август. Для заполнения таблицы данными решила создать хранимую процедуру.
В качестве входных параметров нужна дата (с которой начинать отсчет дней) и количество дней.
*/

DROP TABLE IF EXISTS days;
CREATE TABLE days -- !!!эту таблицу будем использовать и в задании 3, и в задании 4!!!
(id SERIAL PRIMARY KEY,
created_at date
) COMMENT 'ВСЕ Даты августа';


DELIMITER //
CREATE PROCEDURE days (IN dat date, IN a INT)
BEGIN
  declare i INT default a;
  WHILE i >= 0 DO
	INSERT INTO days (created_at) 
    SELECT ADDDATE(dat, INTERVAL i DAY);
	SET i = i - 1;
  END WHILE;
END // 

call days ('2018-08-01', 30); -- вызываем процедуру с входными значениями: 01/01/2018 и 30 дней 

SELECT * FROM days; -- проверяем, что данные в таблицу days записались

CREATE TEMPORARY TABLE AUG -- создаем временную таблицу и записываем в нее информацию из таблиц days и august_dates. Используем LEFT JOIN, поскольку нам нужны ВСЕ даты августа.
AS 
SELECT d.created_at, au.created_at as august_created_at, '0' as sign -- изначально ставим метку 0 для всех строк
FROM days d
LEFT JOIN august_dates au on d.created_at = au.created_at

UPDATE AUG set sign=1 where august_created_at is not NULL; -- ставим метку 1 для тех строк, в которых поле august_created_at НЕ пустое.

-- Проверяем данные в таблице после обновления:

SELECT * FROM AUG
ORDER BY created_at;



/* ЗАДАНИЕ 4.(по желанию) Пусть имеется любая таблица с календарным полем created_at. 
Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.*/

-- Для выполнения задачи можно использовать ранее созданную таблицу days:

SELECT * FROM days; -- в таблице находятся все дни августа

CREATE TEMPORARY TABLE 5_days -- создаем временную таблицу и вносим в нее 5 самых "свежих" записей
AS
SELECT * FROM days
ORDER BY created_at desc
LIMIT 5;

SELECT * FROM 5_days; -- проверяем, что данные во временной таблице имеются (5 записей)

DELETE FROM days d -- удаляем из таблицы days все данные, которых НЕТ во временной таблице 5_days
WHERE NOT EXISTS (SELECT * FROM 5_days dd where d.id = dd.id);
COMMIT;

/* АДМИНИСТРИРОВАНИЕ SQL

ЗАДАНИЕ 1. Создайте двух пользователей которые имеют доступ к базе данных shop. 
Первому пользователю shop_read должны быть доступны только запросы на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.*/


-- создаем 2 пользователей: 

CREATE USER test;
CREATE USER test_1;

-- Можно в командной строке проверить, что пользователи создались 
--(для этого в командной строке можно написать команду  "mysql -u test" и "mysql -u test_1" и подключиться к mysql)

-- Также можно посмотреть, что пользователи создались через запрос: 

select * from mysql.user; -- в моем случае в поле host для обоих пользователей стоит %

GRANT SELECT ON shop.* TO 'test'@'%'; --  для пользователя test дан доступ на ЧТЕНИЕ БД shop

GRANT ALL ON shop.* TO 'test_1'@'%'; -- для пользователя test_1 дан полный доступ к БД shop



/*ЗАДАНИЕ 2.(по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ, имя пользователя и его пароль. 
Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name. 
Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления username.*/

-- Создаем и вносим данные в таблицу accounts

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  NAME VARCHAR (100),
  PASSWORD VARCHAR (100),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO accounts (NAME, PASSWORD)
VALUES ('Pavel','12345'), ('Andrey','abcdef'), ('Polina','pc99pc'), ('Vera','1234er');

-- Создаем view:

CREATE VIEW v_accounts
AS
SELECT id, name from accounts;

-- Создаем пользователя и даем ему права только на view
CREATE USER user_read;
GRANT SELECT ON shop.v_accounts TO 'user_read'@'%';



/* ХРАНИМЫЕ ПРОЦЕДУРЫ. ФУНКЦИИ. ТРИГЕРЫ

ЗАДАНИЕ 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
с 18:00 до 00:00 — "Добрый вечер", 
с 00:00 до 6:00 — "Доброй ночи".*/

  DROP FUNCTION IF EXISTS hello;
  
  DELIMITER //
  CREATE FUNCTION hello ()
  RETURNS TEXT DETERMINISTIC
  BEGIN   
    IF (HOUR(now()) >= 6 and HOUR(now()) <12) THEN
          SET @A = 'Доброе утро';
          Return @A;
    ELSEIF (HOUR(now()) >= 12 and HOUR(now()) <18) THEN
         SET @A = 'Добрый день';
		 Return @A;
	ELSEIF (HOUR(now()) >= 18 and HOUR(now()) <=23) THEN
		SET @A = 'Добрый вечер';
		Return @A;
	ELSE
		SET @A = 'Доброй ночи';
		Return @A;
 end IF;        
 END //
 
 SELECT hello(); -- вызываем функцию
 
 /* Задание 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
 Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
 Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
 При попытке присвоить полям NULL-значение необходимо отменить операцию. */

-- !!!! Таблица products создана ранее, для выполнения Задания 2 в блоке Транзакции.Представления

DROP TRIGGER IF EXISTS name_description_insert_validate;

DELIMITER //
CREATE TRIGGER name_description_insert_validate BEFORE INSERT ON products
FOR EACH ROW BEGIN
	IF (NEW.name IS NULL AND NEW.desсription IS NULL) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Name and description are NULL. Please insert information!';
	END IF;
END //

INSERT INTO products (name, desсription, price,catalog_id) VALUES (NULL, NULL, NULL, NULL); -- при попытке выполнить такой скрипт выдается ошибка: Name and description are NULL. Please insert information!


/* Задание 3.(по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
Вызов функции FIBONACCI(10) должен возвращать число 55 */

 DROP FUNCTION IF EXISTS fibonacchi;
 
  DELIMITER //
  CREATE FUNCTION fibonacchi (a INT)
  RETURNS INT DETERMINISTIC
  BEGIN
	SET @a=0; 
    SET @b=1; 
    SET @c=0;
    SET @i=1;
    while @i<a DO
       SET @c=@a+@b;
       SET @a=@b;
       SET @b=@c;
       SET @i=@i+1;
       end while;
    RETURN @c;
    end//

SELECT fibonacchi(10); -- выдается 55