
/* ЗАДАНИЕ 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
Заполните их текущими датой и временем.*/

--1.1 Создаем таблицу users

CREATE TABLE users(
id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
first_name varchar(100),
last_name varchar (100),
phone varchar (50) NOT NULL,
email varchar (50) NOT NULL,
birtday datetime NOT NULL,
created_at varchar (50) NULL, -- поле created_at СПЕЦИАЛЬНО ДЕЛАЕМ varchar(50) для выполнения задания 2
updated_at varchar (50) NULL -- поле updated_at СПЕЦИАЛЬНО ДЕЛАЕМ varchar(50) для выполнения задания 2
);

--1.2 С помощью сервиса http://filldb.info заполняем таблицу users, но с незаполненными полями created_at и updated_at
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (1, 'Ignacio', 'Bradtke', '03797622748', 'giles.lynch@example.net', '2003-09-14 22:03:10', NULL, NULL);
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (2, 'Wilford', 'McCullough', '603.677.4737', 'karen53@example.com', '1976-09-06 06:22:32', NULL, NULL);
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (3, 'Danny', 'Thompson', '(665)740-3744x8353', 'grady.burdette@example.net', '2016-11-28 13:43:57', NULL, NULL);
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (4, 'Jaylon', 'Little', '1-627-205-3846x75282', 'janick73@example.org', '1984-12-09 02:42:27', NULL, NULL);
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (5, 'Candida', 'Nicolas', '1-771-268-7087x1009', 'hal.spinka@example.net', '1972-05-03 20:17:03', NULL, NULL);
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (6, 'Abbigail', 'Doyle', '656.277.8614', 'ledner.sallie@example.org', '2005-05-31 05:27:43', NULL, NULL);
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (7, 'Carrie', 'Jaskolski', '209-669-4781', 'danial.walsh@example.com', '2018-08-15 15:17:17', NULL, NULL);
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (8, 'Clementina', 'Oberbrunner', '(576)440-6291x1022', 'reichel.austen@example.org', '2017-02-28 10:23:45', NULL, NULL);
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (9, 'Fernando', 'Blick', '(381)181-0692x62796', 'ukutch@example.net', '1975-04-18 05:49:19', NULL, NULL);
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (10, 'Isidro', 'Prohaska', '(710)379-8165x677', 'kshlerin.zachery@example.net', '1977-05-05 03:30:45', NULL, NULL);
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (11, 'Darian', 'Hirthe', '03606402334', 'joana.brakus@example.org', '2000-06-04 10:04:39', NULL, NULL);
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (12, 'Berneice', 'Keefe', '125.178.5273x12512', 'celia08@example.net', '2003-02-02 22:05:17', NULL, NULL);
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (13, 'Joel', 'Donnelly', '05075697281', 'odare@example.net', '1991-12-16 00:14:44', NULL, NULL);
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (14, 'Malinda', 'Beier', '497.675.4292', 'jammie.hilll@example.net', '2014-07-08 13:45:53', NULL, NULL);
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (15, 'Demond', 'Runolfsdottir', '(982)259-9819x9958', 'maurice51@example.com', '1982-01-08 10:19:49', NULL, NULL);
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (16, 'Clara', 'Hahn', '1-436-276-5914x2556', 'zboncak.shaina@example.org', '2020-11-30 09:34:14', NULL, NULL);
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (17, 'Macy', 'Johns', '1-304-365-8318x81748', 'mdickinson@example.org', '2009-05-11 05:38:39', NULL, NULL);
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (18, 'Bertrand', 'Grady', '974.346.2275x69689', 'stacy51@example.org', '2002-06-29 07:58:52', NULL, NULL);
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (19, 'Hipolito', 'Hoppe', '04737713285', 'gdicki@example.com', '1970-03-15 07:16:05', NULL, NULL);
INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `birtday`, `created_at`, `updated_at`) VALUES (20, 'Moriah', 'Funk', '754.171.8716', 'kris01@example.com', '2000-12-27 20:02:20', NULL, NULL);


--1.3 Заполняем поля created_at и updated_at текущей датой и временем

UPDATE users SET updated_at = now()
WHERE id >0;
COMMIT;


UPDATE users SET created_at = now()
WHERE id >0;
COMMIT;

SELECT * FROM users;



/* Задание 2. Таблица users была неудачно спроектирована. 
Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. 
Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.*/

ALTER TABLE users MODIFY created_at DATETIME;
ALTER TABLE users MODIFY updated_at DATETIME;

DESCRIBE users;




/* Задание 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, 
если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
чтобы они выводились в порядке увеличения значения value. 
Однако нулевые запасы должны выводиться в конце, после всех записей.*/

--Для начала создаем таблицу storehouses_products и заносим в нее значения (value), указанные в задании.

CREATE TABLE storehouses_products 
(id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
product VARCHAR (100) NOT NULL,
value INT NOT NULL);

INSERT INTO storehouses_products (product, value) VALUES ('a',0);
INSERT INTO  storehouses_products (product, value) VALUES ('b',2500);
INSERT INTO  storehouses_products (product, value) VALUES ('c',0);
INSERT INTO  storehouses_products (product, value) VALUES ('d',30);
INSERT INTO  storehouses_products (product, value) VALUES ('e',500);
INSERT INTO  storehouses_products (product, value) VALUES ('f',1);
COMMIT;

-- Вывод данных с нужной нам сортировкой (нули в конце):

SELECT * FROM storehouses_products
ORDER BY CASE WHEN value ='0' THEN 1 ELSE 0 END, value




/* Задание 4.(по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
Месяцы заданы в виде списка английских названий (may, august)*/

--В уже созданную таблицу users (таблицу создавали для выполнения Задания 1 и 2) добавляем новое поле month_of_birth
--и вносим в нее данные.

ALTER TABLE users ADD month_of_birth VARCHAR(50) NULL;
COMMIT;

DESCRIBE users;

UPDATE users SET month_of_birth = 'september' WHERE id >0 AND id <=10;
UPDATE users SET month_of_birth = 'october' WHERE id >10 AND id <=20;
UPDATE users SET month_of_birth = 'november' WHERE id >20 AND id <=30;
UPDATE users SET month_of_birth = 'december' WHERE id >30 AND id <=40;
UPDATE users SET month_of_birth = 'august' WHERE id >40 AND id <=50;
UPDATE users SET month_of_birth = 'february' WHERE id >50 AND id <=60;
UPDATE users SET month_of_birth = 'june' WHERE id >60 AND id <=70;
UPDATE users SET month_of_birth = 'march' WHERE id >70 AND id <=80;
UPDATE users SET month_of_birth = 'april' WHERE id >80 AND id <=90;
UPDATE users SET month_of_birth = 'may' WHERE id >90 AND id <=100;

--Осуществляем поиск users, у которых месяц рождения в мае или в августе

SELECT * FROM users
WHERE month_of_birth LIKE '%may%' OR  
month_of_birth LIKE '%august%'



/* ЗАДАНИЕ 5. Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
Отсортируйте записи в порядке, заданном в списке IN.*/

-- Для начала создаем и заполняем таблицу данными:

CREATE TABLE catalog
(id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR (50) NOT NULL,
description VARCHAR (100) NULL,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Каталог";

INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (1, 'corporis', 'Odit voluptatem cumque qui sint dolorem. Nisi consequuntur eos perferendis saepe.', '1986-02-12 03:19:29', '1982-04-26 09:15:25');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (2, 'non', 'Explicabo occaecati dicta consequatur aut soluta sit. Saepe laboriosam esse dolorem voluptates quasi', '1993-09-27 00:52:35', '1970-05-07 09:00:15');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (3, 'delectus', 'Ducimus facere aliquam neque similique omnis debitis. Est rerum ex quod eligendi perferendis. Doloru', '1993-10-02 07:48:35', '2013-04-29 22:14:58');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (4, 'voluptatem', 'Quisquam reiciendis blanditiis voluptas eos vel. Tempore velit illum ullam libero et similique adipi', '2020-08-21 02:30:31', '2018-08-16 03:20:51');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (5, 'labore', 'Eos maiores nihil qui ab sunt consectetur. Nisi id pariatur sapiente.', '1972-10-13 07:26:23', '1978-06-09 22:14:37');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (6, 'et', 'Velit repudiandae natus voluptas architecto. Voluptatem nisi facilis omnis qui. Dolor et minima debi', '1971-04-10 08:56:55', '2004-02-04 04:49:57');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (7, 'iure', 'Enim voluptas vitae ipsa fugiat qui praesentium quaerat. Ut quibusdam eum asperiores non. Et volupta', '1996-03-15 03:07:00', '2000-05-10 00:03:36');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (8, 'aut', 'Molestiae et voluptatem cupiditate rerum. Dolores quod officia et sed harum vel. Pariatur nesciunt q', '1977-07-08 06:25:28', '1974-12-04 03:39:04');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (9, 'magnam', 'Reprehenderit similique quae voluptas nobis. Ipsa delectus ut quam dolorum architecto. Aperiam volup', '2008-07-08 04:42:39', '1981-06-24 06:22:17');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (10, 'totam', 'Rerum quod officiis magni dicta dolores maxime et. Debitis pariatur illo pariatur est. Temporibus qu', '1973-01-30 21:06:09', '1971-10-17 14:57:20');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (11, 'molestias', 'Non ut excepturi laboriosam soluta. Amet quae non qui vitae reiciendis cumque. Velit corporis sunt c', '2018-07-02 12:42:06', '2007-05-23 03:32:34');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (12, 'iste', 'Nam qui pariatur id molestiae sed modi consequatur. Ducimus ea quos iure alias mollitia voluptate. I', '1981-12-03 04:20:11', '1974-04-16 15:47:20');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (13, 'veritatis', 'Totam hic quasi nisi beatae. Dolorem ut sed magni sed temporibus consequuntur. Sed laboriosam offici', '2018-01-03 22:53:48', '2007-10-13 14:12:25');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (14, 'aut', 'Incidunt nisi et voluptatem ut reprehenderit aut quas. Molestiae facilis aspernatur nemo sit quos eu', '1998-10-07 15:38:10', '1998-05-13 17:23:47');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (15, 'et', 'Qui sint sunt dignissimos. Facere impedit eos voluptatem ut eius in eaque. Aut qui cumque perspiciat', '2011-03-10 18:19:38', '1970-10-12 20:31:56');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (16, 'doloribus', 'Consequuntur dolorum exercitationem consequuntur quasi exercitationem. Beatae veniam dolores eos. Su', '1983-02-02 09:52:24', '2006-05-08 16:57:19');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (17, 'maxime', 'Et sequi facilis a cupiditate nihil nesciunt omnis qui. Quos est omnis magnam ducimus. Sed officiis ', '1988-09-24 02:37:21', '1998-12-19 10:51:13');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (18, 'quasi', 'Ut sit velit explicabo. Harum amet deserunt et in. In similique tempore eveniet pariatur. Officia qu', '1985-01-25 01:17:23', '1980-10-06 00:44:51');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (19, 'enim', 'Autem deserunt non qui veniam. Id nihil veritatis reprehenderit hic quas sit. Qui dicta quis consect', '1989-05-26 18:57:44', '2005-05-02 06:46:19');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (20, 'quia', 'Voluptatem accusamus et dolor fuga tempore. Modi ab et dolore deleniti ipsam. In maiores aliquid non', '1976-07-25 03:16:06', '2017-10-15 12:45:03');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (21, 'optio', 'Ut quia voluptate est. Deserunt aut veritatis hic incidunt est. Quia voluptas reiciendis in eveniet.', '1986-01-13 06:13:35', '1975-12-13 02:56:40');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (22, 'rerum', 'Atque sit est at velit aut. Neque eum eius inventore reiciendis id aliquam repellat. Sunt veniam qui', '2012-01-31 02:02:03', '1977-06-09 05:10:33');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (23, 'esse', 'Delectus minima at voluptatem repudiandae aperiam sed quia. Et asperiores et accusantium aut et maxi', '1985-04-19 22:57:06', '1973-04-14 04:31:57');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (24, 'ut', 'Non est delectus tempora explicabo provident quibusdam. Vero ut veritatis sequi qui incidunt laborum', '2015-03-24 16:28:32', '1996-09-21 01:14:52');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (25, 'et', 'Sed aliquid voluptas expedita explicabo. Omnis corrupti qui voluptatem rem earum sed suscipit. Est a', '1973-06-15 01:40:40', '2006-11-07 06:13:00');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (26, 'quod', 'Culpa error magni veritatis magnam sed voluptatum porro. Aliquam quis deserunt magni est et. Repella', '1978-05-19 14:42:49', '1991-02-02 04:15:49');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (27, 'quod', 'Nam ex corporis non voluptas facere eum. Aliquam molestiae cumque illo occaecati vitae. Quae quis vo', '1996-11-20 20:29:47', '1994-11-20 02:25:14');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (28, 'nam', 'Assumenda ipsam ut ea dolor eaque autem autem nemo. Sit ad officiis aliquam sed aut. Itaque alias fa', '1982-07-27 08:00:31', '2012-12-30 22:02:14');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (29, 'saepe', 'Rerum blanditiis doloremque temporibus aliquam aliquam quam quia consectetur. Dolore nostrum volupta', '1985-05-24 16:19:56', '1971-06-09 05:59:12');
INSERT INTO `catalog` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (30, 'hic', 'Sit iusto iusto cum est dolores quia libero. Tempora sint dignissimos odit vel cum dolorem modi. Nih', '1989-07-21 21:43:32', '1973-05-17 15:36:37');


-- Выполнение задачи:

SELECT * FROM  catalog
WHERE id IN (5, 1, 2)
ORDER BY FIELD(id, 5, 1, 2);




/* ЗАДАНИЕ 6. Подсчитайте средний возраст пользователей в таблице users. */

-- Для выполнения задания использовалась таблица users, созданная ранее для выполнения Задания 1 и 2.

SELECT round(AVG(t.age),1) FROM (
SELECT id,
truncate (TIMESTAMPDIFF(month,birtday,CURDATE())/12,0) AS age 
FROM users
) AS t




/* ЗАДАНИЕ 7. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
Следует учесть, что необходимы дни недели текущего года, а не года рождения.*/

/* Для выполнения данного задания нужно использовать функцию DAYOFWEEK (). В описании данной функции дается следующая информация:

The DAYOFWEEK() function returns the weekday index for a given date (a number from 1 to 7).

!!!!!!!!Note: 1=Sunday, 2=Monday, 3=Tuesday, 4=Wednesday, 5=Thursday, 6=Friday, 7=Saturday.!!!!!!!!*/

SELECT aa.date, count(aa.id) FROM
(SELECT id, 
 DAYOFWEEK(CONCAT(YEAR(NOW()),'-',MONTH(birtday),'-',DAYOFMONTH(birtday))) as date 
 FROM users) AS aa
 GROUP BY aa.date
 ORDER BY aa.date;
 
 
 
 

/* ЗАДАНИЕ 8. (по желанию) Подсчитайте произведение чисел в столбце таблицы.*/

-- В mysql нет функции, которая подсчитывает  произведение чисел. Но есть функция, которая суммирует числа. 
-- Поэтому для выполнения данной задачи можно использовать натуральные логарифмы (чтобы от произведения перейти к сумме).

-- Для начала создадим таблицу и внесем в него необходимые значения:

CREATE TABLE VALUE (
id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
value int not null);
 
INSERT INTO VALUE (value) values (1);
INSERT INTO VALUE (value) values (2);
INSERT INTO VALUE (value) values (3);
INSERT INTO VALUE (value) values (4);
INSERT INTO VALUE (value) values (5);

-- Вычисляем произведение через сумму натуральных логарифмов. Итоговое значение округляем до целых чисел.
 SELECT ROUND(EXP(sum(ln(value))),0) FROM value;