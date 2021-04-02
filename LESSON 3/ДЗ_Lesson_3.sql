/ ЗАДАНИЕ 1. Проанализировать структуру БД vk, которую мы создали на занятии, 
и внести предложения по усовершенствованию (если такие идеи есть). 
Напишите пожалуйста, всё-ли понятно по структуре.*/

/* ПРЕДЛОЖЕНИЯ ПО УСОВЕРШЕНСТВОВАНИЮ
1.1  Поля [first_name] и [last_name] перенести из таблицы users в таблицу profiles.
1.2 Добавить поле [password] в таблицу users. */

CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
  password VARCHAR(100) NOT NULL COMMENT "Пароль",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Пользователи";

CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на пользователя",
  first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",  
  gender CHAR(1) NOT NULL COMMENT "Пол",
  birthday DATE COMMENT "Дата рождения",
  city VARCHAR(130) COMMENT "Город проживания",
  country VARCHAR(130) COMMENT "Страна проживания",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Профили"; 

/* 1.3 Сообщение может быть доставлено пользователю не сразу. Поэтому может получится такая ситуация, когда 
в таблице messages будут строки, у которых отличается только поле [is_delivered]. Нарушается правило 2NF. 
Необходимо создать 2 новые таблицы: 
	1) первая таблица - это справочник возможных статусов сообщений (создано/отправлено/доставлено)
	2) вторая таблица - это связь сообщений со статусами */
	
CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  from_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на отправителя сообщения",
  to_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя сообщения",
  body TEXT NOT NULL COMMENT "Текст сообщения",
  is_important BOOLEAN COMMENT "Признак важности",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки"
) COMMENT "Сообщения";

CREATE TABLE message_statuses (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
name VARCHAR(50) NOT NULL COMMENT "Название статуса",
description VARCHAR(100) COMMENT "Описание статуса (может быть NULL)",
created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки"
COMMENT "Справочник возможных статусов доставки сообщений";

CREATE TABLE message_delivers (
message_id INT UNSIGNED NOT NULL COMMENT "Идентификатор строки",
message_status_id INT UNSIGNED NOT NULL COMMENT "Признак доставки",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
PRIMARY KEY (message_id, message_status_id) COMMENT "Составной первичный ключ"
) COMMENT "Связь сообщений со статусами";



/* ЗАДАНИЕ 2 Добавить необходимую таблицу/таблицы для того,
чтобы можно было использовать лайки для медиафайлов, постов и пользователей.*/

/*2.1 Создание таблицы лайков для медиафайлов*/

CREATE TABLE media_likes (
  media_id INT UNSIGNED NOT NULL COMMENT "Ссылка на медиа",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который поставил лайк",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  ) COMMENT "Лайки на медиафайлы";

/*2.2 Создание таблицы лайков для постов. Предварительно создана отдельная таблица постов пользователя*/

CREATE TABLE user_posts (
 id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
 user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который создал пост", 
 body TEXT NOT NULL COMMENT "Текст поста",
 created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
 updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
 ) COMMENT "Посты пользователя";
 
 CREATE TABLE posts_likes (
  post_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пост",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который поставил лайк",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  ) COMMENT "Лайки на посты";
  

/ЗАДАНИЕ 3. Используя сервис http://filldb.info или другой по вашему желанию, сгенерировать тестовые данные для всех таблиц,
учитывая логику связей. Для всех таблиц, где это имеет смысл, создать не менее 100 строк. Создать локально БД vk и 
загрузить в неё тестовые данные.*/

/*В аттаче представлен дамп БД vk с тестовыми данными*/

use vk;
show tables;

select count(*)  from communities;
select count(*)  from communities_users;
select count(*)  from friendship;
select count(*)  from  friendship_statuses;
select count(*)  from media;
select count(*)  from media_likes;
select count(*)  from media_types;
select count(*)  from messages;
select count(*)  from posts_likes;
select count(*)  from profiles;
select count(*)  from user_posts;
select count(*)  from users;

