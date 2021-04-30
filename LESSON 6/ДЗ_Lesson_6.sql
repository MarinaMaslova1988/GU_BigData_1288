/*Подготовка данных: создание БД, таблиц, внешних ключей, заполнение таблиц данными, обновление данных (где это нужно)*/

create database vk_lesson_6;
use vk_lesson_6;

-- Создаём таблицу пользователей
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Пользователи";  

-- Таблица профилей
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на пользователя", 
  gender CHAR(1) NOT NULL COMMENT "Пол",
  birthday DATE COMMENT "Дата рождения",
  city VARCHAR(130) COMMENT "Город проживания",
  country VARCHAR(130) COMMENT "Страна проживания",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Профили"; 

-- Таблица сообщений
CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  from_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на отправителя сообщения",
  to_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя сообщения",
  body TEXT NOT NULL COMMENT "Текст сообщения",
  is_important BOOLEAN COMMENT "Признак важности",
  is_delivered BOOLEAN COMMENT "Признак доставки",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки"
) COMMENT "Сообщения";

-- Таблица дружбы
CREATE TABLE friendship (
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на инициатора дружеских отношений",
  friend_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя приглашения дружить",
  friendship_status_id INT UNSIGNED NOT NULL COMMENT "Ссылка на статус (текущее состояние) отношений",
  requested_at DATETIME DEFAULT NOW() COMMENT "Время отправления приглашения дружить",
  confirmed_at DATETIME COMMENT "Время подтверждения приглашения",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",  
  PRIMARY KEY (user_id, friend_id) COMMENT "Составной первичный ключ"
) COMMENT "Таблица дружбы";

-- Таблица статусов дружеских отношений
CREATE TABLE friendship_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название статуса",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Статусы дружбы";

-- Таблица групп
CREATE TABLE communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор сроки",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название группы",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Группы";

-- Таблица связи пользователей и групп
CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL COMMENT "Ссылка на группу",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (community_id, user_id) COMMENT "Составной первичный ключ"
) COMMENT "Участники групп, связь между пользователями и группами";

-- Таблица медиафайлов
CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который загрузил файл",
  filename VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
  size INT NOT NULL COMMENT "Размер файла",
  metadata JSON COMMENT "Метаданные файла",
  media_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип контента",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Медиафайлы";

-- Таблица типов медиафайлов
CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы медиафайлов";

--Таблица лайков на медиафайлы
 CREATE TABLE media_likes (
   media_id INT UNSIGNED NOT NULL COMMENT "Ссылка на медиа",
   user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который поставил лайк",
   created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки"
   ) COMMENT "Лайки на медиафайлы";	
 
--Таблица постов
CREATE TABLE user_posts (
 id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
 user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который создал пост", 
 body TEXT NOT NULL COMMENT "Текст поста",
 created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
 updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
 ) COMMENT "Посты пользователя";
 
--Таблица лайков на посты
 CREATE TABLE posts_likes (
post_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пост",
user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который поставил лайк",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки"
) COMMENT "Лайки на посты";


-- Создаем внешние ключи
ALTER TABLE profiles ADD CONSTRAINT fk_profiles_users FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE friendship ADD CONSTRAINT fk_friendship_users_1 FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE friendship ADD CONSTRAINT fk_friendship_users_2 FOREIGN KEY (friend_id) REFERENCES users (id);
ALTER TABLE friendship ADD CONSTRAINT fk_friendship_status FOREIGN KEY (friendship_status_id) REFERENCES friendship_statuses (id);
ALTER TABLE messages ADD CONSTRAINT fk_message_users_1 FOREIGN KEY (from_user_id) REFERENCES users (id);
ALTER TABLE messages ADD CONSTRAINT fk_message_users_2 FOREIGN KEY (to_user_id) REFERENCES users (id);
ALTER TABLE communities_users ADD CONSTRAINT fk_communities_user FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE communities_users ADD CONSTRAINT fk_community_id FOREIGN KEY (community_id) REFERENCES communities (id);
ALTER TABLE media ADD CONSTRAINT fk_media_type FOREIGN KEY (media_type_id) REFERENCES media_types (id);
ALTER TABLE user_posts ADD CONSTRAINT fk_user_posts FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE posts_likes ADD CONSTRAINT fk_posts_likes_user FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE posts_likes ADD CONSTRAINT fk_posts_likes_post FOREIGN KEY (post_id) REFERENCES user_posts (id);
ALTER TABLE media_likes ADD CONSTRAINT fk_media_likes_user FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE media_likes ADD CONSTRAINT fk_media_likes_post FOREIGN KEY (media_id) REFERENCES media (id);

-- Заполняем таблицы данными
INSERT INTO friendship_statuses (name) values ('принял');
INSERT INTO friendship_statuses (name) values ('отказал');
INSERT INTO friendship_statuses (name) values ('подписчик');
COMMIT;

INSERT INTO media_types (name) values ('photo');
INSERT INTO media_types (name) values ('audio');
INSERT INTO media_types (name) values ('video');
INSERT INTO media_types (name) values ('gif');
INSERT INTO media_types (name) values ('file');
COMMIT;

INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (1, 'sed', '1977-02-24 00:12:55', '1992-11-30 16:55:35');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (2, 'eveniet', '1989-01-08 07:16:20', '2008-05-26 00:13:19');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (3, 'eum', '1980-07-26 18:23:54', '1990-06-24 23:20:50');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (4, 'aut', '2001-03-29 20:36:39', '2003-04-11 09:52:33');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (5, 'consequuntur', '1976-05-20 07:29:20', '2016-08-19 23:32:24');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (6, 'quaerat', '1982-01-26 16:51:37', '1976-05-21 12:39:14');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (7, 'itaque', '2019-09-19 12:13:54', '1980-04-30 10:12:45');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (8, 'nam', '1986-04-01 13:23:17', '1994-11-30 12:05:29');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (9, 'ab', '2018-08-08 22:36:34', '1984-02-27 12:22:45');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (10, 'consequatur', '2017-02-06 08:43:19', '1978-02-04 19:19:38');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (11, 'velit', '2005-05-02 17:18:13', '2000-02-14 19:45:24');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (12, 'rerum', '1989-09-23 07:43:14', '2005-10-12 21:46:22');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (13, 'odio', '2007-09-07 11:37:40', '1983-11-21 01:39:31');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (14, 'id', '1987-08-20 08:47:07', '1985-01-13 08:42:49');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (15, 'voluptate', '2016-11-26 07:10:57', '2019-03-01 07:52:33');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (16, 'commodi', '2007-03-22 15:54:35', '1973-02-10 11:45:06');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (17, 'nostrum', '2011-10-31 09:49:22', '1995-10-10 10:04:07');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (18, 'architecto', '1995-08-31 01:07:34', '2007-06-23 19:24:02');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (19, 'voluptas', '2019-08-23 13:50:05', '2013-07-17 22:04:37');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (20, 'ad', '2017-04-24 03:54:20', '1990-05-03 22:40:40');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (21, 'consectetur', '1983-04-13 09:57:38', '1984-05-24 07:26:08');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (22, 'in', '1988-01-06 11:48:02', '1999-06-03 16:59:26');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (23, 'amet', '1973-11-28 18:21:06', '1972-10-27 12:54:48');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (24, 'minus', '1982-01-26 20:42:14', '1982-06-06 14:28:31');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (25, 'expedita', '2002-12-03 05:48:15', '1979-12-18 11:39:33');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (26, 'repellendus', '1994-09-14 06:50:34', '1977-05-31 14:33:40');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (27, 'sit', '1978-01-02 02:25:49', '1993-04-23 19:31:39');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (28, 'occaecati', '1995-09-27 10:44:30', '1973-10-02 11:57:52');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (29, 'dignissimos', '1984-08-25 14:13:06', '2005-03-10 18:27:32');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (30, 'doloribus', '1970-07-18 19:53:58', '1971-02-04 02:07:02');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (31, 'qui', '1974-02-20 21:12:51', '2002-07-26 06:36:19');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (32, 'minima', '2004-09-16 02:56:52', '1977-08-03 20:24:31');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (33, 'similique', '2016-03-31 10:47:49', '1982-11-01 05:01:39');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (34, 'ex', '1994-10-03 06:14:14', '1988-12-25 11:39:45');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (35, 'adipisci', '1977-07-19 05:47:33', '2010-07-06 11:12:07');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (36, 'mollitia', '1982-04-16 03:18:51', '1972-05-20 13:11:31');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (37, 'porro', '1992-12-04 10:19:42', '1970-03-26 20:19:56');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (38, 'quae', '1979-01-13 08:47:46', '1998-02-12 21:14:17');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (39, 'vel', '2014-05-28 03:20:38', '1990-05-05 23:36:15');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (40, 'odit', '1980-10-15 01:55:32', '1977-12-20 19:49:30');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (41, 'iste', '2004-09-30 19:07:50', '1996-05-31 15:59:23');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (42, 'voluptatibus', '2004-08-14 12:48:04', '1975-02-05 09:06:29');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (43, 'accusamus', '1990-09-07 16:41:23', '2002-07-31 08:31:58');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (44, 'debitis', '2019-02-13 14:18:44', '1997-04-01 14:10:05');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (45, 'reiciendis', '1995-05-05 02:46:35', '1999-12-09 00:35:09');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (46, 'quia', '2008-05-04 16:47:18', '2003-10-10 16:25:19');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (47, 'suscipit', '2021-04-03 07:22:32', '1991-05-10 03:18:40');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (48, 'provident', '1992-07-09 16:01:55', '1994-08-21 14:35:48');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (49, 'est', '1996-06-11 12:11:29', '1993-04-28 09:54:28');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (50, 'aliquid', '2016-11-15 00:12:23', '2014-04-02 13:10:47');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (51, 'illo', '2013-08-02 19:03:37', '1997-02-12 08:04:30');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (52, 'et', '1992-04-15 14:23:43', '2003-05-12 11:48:18');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (53, 'corrupti', '1985-12-13 07:37:08', '2006-10-13 21:35:43');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (54, 'dicta', '2011-03-16 10:13:28', '2003-05-02 12:01:54');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (55, 'omnis', '2008-05-19 23:14:35', '1970-08-03 04:36:51');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (56, 'optio', '1971-07-11 12:20:52', '1977-07-01 09:17:09');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (57, 'reprehenderit', '2013-10-05 08:26:44', '1970-07-08 17:58:38');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (58, 'voluptates', '1983-07-06 16:57:31', '2005-09-17 10:26:04');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (59, 'a', '2000-06-24 08:24:42', '1972-05-06 04:58:35');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (60, 'rem', '2004-06-17 13:33:14', '1994-11-27 09:08:59');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (61, 'nesciunt', '1976-08-04 04:00:07', '2018-08-08 11:39:31');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (62, 'quos', '1980-07-04 18:55:10', '2013-11-30 15:59:58');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (63, 'quo', '2004-08-03 07:37:21', '1983-09-19 05:46:43');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (64, 'aspernatur', '1984-09-26 04:29:18', '1977-01-30 21:05:49');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (65, 'sunt', '1976-06-29 08:35:16', '2018-11-26 23:31:25');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (66, 'nihil', '1980-11-07 17:42:29', '1998-03-06 11:11:11');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (67, 'libero', '2011-11-14 19:40:01', '1996-12-04 02:52:42');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (68, 'facilis', '2003-06-18 14:52:23', '2012-04-12 18:46:13');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (69, 'nulla', '2020-07-09 15:47:02', '2011-05-09 05:49:46');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (70, 'asperiores', '1977-06-02 08:33:02', '1996-06-21 18:40:44');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (71, 'numquam', '1997-09-27 10:39:56', '2005-01-04 07:51:59');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (72, 'impedit', '2008-05-31 12:00:45', '2001-03-22 19:48:51');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (73, 'quidem', '2013-12-18 01:20:24', '1976-10-24 12:10:52');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (74, 'alias', '2015-09-04 10:22:35', '1985-01-11 06:20:25');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (75, 'esse', '1999-01-07 16:25:18', '2002-06-11 03:09:25');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (76, 'cumque', '2007-12-10 05:12:36', '2016-03-03 17:16:24');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (77, 'ea', '2011-07-29 02:21:23', '2009-09-26 05:08:03');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (78, 'natus', '1984-10-28 17:54:01', '1987-11-09 02:07:12');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (79, 'placeat', '1985-03-21 21:17:22', '2017-11-24 17:36:57');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (80, 'dolorem', '2008-06-27 10:51:15', '2018-10-28 05:50:39');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (81, 'vero', '1970-08-15 15:46:05', '1988-08-18 03:26:47');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (82, 'perferendis', '2008-08-23 18:27:58', '2002-08-28 12:03:16');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (83, 'enim', '2017-10-26 10:30:48', '1996-08-09 08:34:29');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (84, 'ipsam', '1990-07-31 01:26:10', '1984-10-03 23:04:49');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (85, 'dolore', '2007-01-15 09:00:00', '1985-06-18 05:35:46');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (86, 'ut', '2002-08-06 09:24:20', '2009-12-26 08:02:14');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (87, 'modi', '1975-09-21 04:27:29', '1986-09-01 21:00:55');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (88, 'ipsum', '1970-07-02 18:53:45', '1984-10-25 02:18:13');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (89, 'harum', '1977-06-07 07:30:36', '1979-12-22 08:53:13');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (90, 'autem', '1998-04-24 23:24:19', '2006-12-07 14:24:00');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (91, 'dolorum', '2008-09-08 00:21:53', '2004-05-07 01:33:58');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (92, 'excepturi', '2000-01-05 11:11:38', '2010-06-23 18:51:31');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (93, 'blanditiis', '1982-06-22 01:25:53', '1975-09-06 10:27:07');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (94, 'laborum', '1974-06-08 04:57:59', '1970-06-24 11:46:09');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (95, 'temporibus', '1979-03-26 19:30:13', '1993-01-12 07:00:11');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (96, 'dolores', '2009-08-21 06:34:53', '2010-10-20 13:00:42');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (97, 'quis', '2002-04-07 03:46:43', '2007-11-04 07:57:27');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (98, 'eius', '1988-10-05 23:42:29', '1974-10-15 16:03:24');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (99, 'culpa', '1970-03-14 04:32:39', '1994-01-25 19:18:39');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (100, 'explicabo', '2019-04-10 21:47:32', '2008-10-28 17:25:15');
COMMIT;


INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (1, 'Benton', 'Waters', 'vergie.windler@example.net', '+01(7)8607039886', '2012-05-31 05:44:16', '1979-04-29 21:20:11');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (2, 'Amelie', 'Schulist', 'curt.cole@example.net', '(307)779-4028x538', '1972-01-26 23:31:46', '1996-09-17 17:50:20');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (3, 'Sabryna', 'Nader', 'mafalda.lockman@example.com', '(927)289-9444', '1997-03-15 16:07:31', '1970-12-20 21:28:51');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (4, 'Orie', 'Brakus', 'cierra.brakus@example.org', '1-275-377-8847', '1977-11-09 00:07:16', '1999-12-05 19:58:42');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (5, 'Dedrick', 'Harber', 'yparisian@example.com', '1-878-049-6566x80071', '1972-03-05 16:12:59', '1975-11-18 13:22:58');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (6, 'Zena', 'Russel', 'amina41@example.org', '1-782-767-9048x635', '1992-11-10 11:48:14', '1977-12-07 16:27:21');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (7, 'Jaylen', 'Renner', 'bernhard.rosemary@example.com', '450.578.2865', '1992-05-03 18:29:19', '2000-12-09 06:05:27');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (8, 'Joaquin', 'Parker', 'uschulist@example.org', '08239681544', '2001-09-06 11:32:38', '2015-12-15 01:31:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (9, 'Jody', 'Spencer', 'jace97@example.net', '327-506-4620x88012', '1980-09-19 22:38:49', '2006-01-09 21:38:11');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (10, 'Alene', 'Blick', 'towne.ova@example.net', '159.152.0357x3040', '2001-02-21 22:52:15', '1994-03-27 08:28:00');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (11, 'Eladio', 'Shanahan', 'rrobel@example.org', '(846)743-6997x062', '1971-04-19 05:17:20', '2004-01-10 03:05:22');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (12, 'Floy', 'Howell', 'kihn.shania@example.com', '(902)722-5418x77270', '2010-12-25 05:16:21', '2016-02-06 18:45:42');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (13, 'Troy', 'Bode', 'blick.russel@example.net', '1-398-825-2625x393', '1989-11-11 21:27:37', '2020-06-09 01:11:33');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (14, 'Ismael', 'Maggio', 'qbrakus@example.org', '1-240-372-5768', '1999-01-25 06:43:31', '1981-08-19 12:12:55');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (15, 'Marianna', 'Kirlin', 'frederik.wisoky@example.net', '1-609-229-8715x6708', '1988-04-21 22:19:20', '1996-03-23 08:22:24');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (16, 'Colleen', 'Toy', 'wyman.jaclyn@example.net', '384.607.5294x153', '1998-01-02 10:21:37', '1999-08-01 17:02:12');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (17, 'Freeda', 'Kris', 'mwatsica@example.org', '1-049-652-0066x1700', '1974-07-13 16:39:50', '1971-12-08 12:34:28');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (18, 'Noble', 'Carroll', 'brennon.pfannerstill@example.net', '(312)676-6437', '2001-02-04 10:03:30', '1997-04-21 10:08:05');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (19, 'Jaclyn', 'Davis', 'oran.champlin@example.org', '814.600.0276', '1993-10-28 20:21:25', '1971-12-18 20:00:40');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (20, 'Sheldon', 'Wiza', 'murazik.deontae@example.com', '1-834-099-7583', '1972-06-29 20:23:53', '1974-09-20 06:52:47');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (21, 'Edmund', 'Harvey', 'herman.ziemann@example.com', '02951553462', '1982-09-11 05:57:21', '2014-06-04 17:46:26');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (22, 'Citlalli', 'Miller', 'elton.ankunding@example.net', '(710)190-0713x6439', '2012-07-08 16:54:35', '2020-03-14 18:13:01');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (23, 'Isabelle', 'Monahan', 'beryl.batz@example.org', '667-265-5087', '1997-04-21 03:41:49', '1984-08-03 03:24:34');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (24, 'Bessie', 'Ortiz', 'dakota.williamson@example.net', '1-581-586-6940x2338', '2005-08-07 01:48:03', '1991-12-10 18:46:23');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (25, 'Nelson', 'Jerde', 'pconsidine@example.com', '(612)196-0667', '2016-01-06 23:20:45', '2004-10-12 23:46:56');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (26, 'Carmella', 'Gerlach', 'alberta.hand@example.org', '266.999.7391x43146', '1970-01-22 19:22:17', '1982-12-24 21:43:42');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (27, 'Vivian', 'Kautzer', 'mccullough.velma@example.net', '958-173-3257', '1986-09-21 07:23:00', '2003-12-29 20:20:59');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (28, 'Michel', 'Stracke', 'cale.torp@example.com', '1-480-980-9266', '1992-09-17 18:33:26', '1991-06-28 06:20:39');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (29, 'Everett', 'Cronin', 'tmoen@example.org', '(895)201-6487', '1998-07-16 18:22:47', '2001-03-25 09:47:16');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (30, 'Jayson', 'Parisian', 'wilfrid.rau@example.org', '1-329-806-1143x125', '1984-01-28 13:32:40', '1976-12-28 03:01:18');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (31, 'Katherine', 'Kautzer', 'eboehm@example.net', '495-710-2786', '1991-05-02 18:05:08', '1970-03-06 22:00:34');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (32, 'Ignacio', 'Nolan', 'rhodkiewicz@example.org', '950.453.4430x235', '1995-02-26 18:38:52', '1985-10-21 21:52:46');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (33, 'Raymond', 'Hackett', 'margarette54@example.org', '711-293-5811', '1978-12-28 14:51:16', '2013-11-26 02:37:35');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (34, 'River', 'Gibson', 'carter.arvel@example.org', '998-789-8534x25196', '2015-03-14 09:20:06', '1990-04-11 11:03:55');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (35, 'Sigmund', 'Kemmer', 'dcormier@example.com', '1-968-691-9753x995', '2000-08-30 22:27:39', '1990-01-04 21:24:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (36, 'Mollie', 'Kulas', 'alynch@example.org', '(271)583-4757x41675', '2003-05-02 00:37:06', '1996-06-05 10:20:12');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (37, 'Alfreda', 'Zemlak', 'carmel.mosciski@example.org', '837.383.2189x6353', '1977-01-04 20:14:42', '1983-05-05 06:56:10');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (38, 'Noelia', 'Koss', 'lonzo09@example.org', '1-132-242-2728', '1975-10-25 22:11:12', '2011-06-19 06:20:59');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (39, 'Terence', 'Ondricka', 'justen08@example.com', '+40(4)4762033259', '1982-04-16 20:44:26', '1973-06-06 11:10:09');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (40, 'Kristin', 'Schimmel', 'caleb43@example.com', '1-040-289-2322x818', '1973-07-17 08:54:33', '1976-12-28 22:37:07');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (41, 'Elvis', 'Abernathy', 'rhea.gutkowski@example.net', '1-965-988-9705x3382', '2006-03-09 20:28:43', '2012-09-23 19:57:18');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (42, 'Dario', 'Feeney', 'abbie66@example.com', '1-749-170-8040x87399', '1991-03-10 13:46:11', '2018-06-06 18:39:24');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (43, 'Felipa', 'Hodkiewicz', 'wnolan@example.net', '504.524.3959', '1978-04-04 10:46:06', '1977-06-15 00:30:50');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (44, 'Herta', 'DuBuque', 'lrunolfsdottir@example.org', '+58(2)0331704516', '1993-09-08 18:15:48', '1972-10-03 16:19:54');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (45, 'Nannie', 'Marquardt', 'bayer.tressie@example.net', '216.591.8157x2671', '2005-01-18 04:05:01', '1974-01-26 07:10:22');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (46, 'Gertrude', 'Kiehn', 'loyce68@example.com', '729-119-7730', '1989-11-05 23:02:35', '1975-01-27 11:33:15');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (47, 'Adriel', 'Gutkowski', 'mcremin@example.org', '605.751.2688x0776', '2001-03-27 08:32:06', '1973-03-22 03:34:20');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (48, 'Aletha', 'Schinner', 'santino83@example.com', '1-163-763-8875x79450', '2004-11-01 08:28:44', '1985-04-11 01:49:43');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (49, 'Liana', 'McLaughlin', 'mac.kuhlman@example.org', '+89(0)1791930037', '2005-07-27 01:42:45', '1981-06-06 22:03:09');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (50, 'Dorian', 'Reynolds', 'strosin.vesta@example.org', '1-018-007-5794x801', '1996-04-12 08:23:51', '1976-04-28 11:36:43');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (51, 'Dominique', 'Schmidt', 'uwindler@example.com', '02423957094', '1999-02-04 11:42:31', '1993-07-21 06:53:13');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (52, 'Cayla', 'Schneider', 'felicia75@example.com', '+96(7)2858576782', '1995-04-18 08:38:05', '2006-01-23 15:21:39');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (53, 'Baby', 'Stiedemann', 'jeanie64@example.com', '(430)224-3010x333', '1973-04-22 20:59:18', '1987-11-07 15:58:43');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (54, 'Mathilde', 'Thompson', 'cbernier@example.net', '811-549-5836', '2018-09-28 17:43:45', '2008-09-05 01:54:15');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (55, 'Deven', 'Johnson', 'aditya.champlin@example.org', '(710)055-1025x02391', '1991-12-08 23:54:08', '1973-07-05 09:06:20');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (56, 'Elian', 'Goldner', 'qjakubowski@example.net', '699-793-9417x894', '2020-04-27 21:08:04', '1976-07-30 10:35:59');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (57, 'Clotilde', 'Klein', 'rowena45@example.com', '1-358-762-1374', '1996-12-14 20:18:47', '1976-11-10 19:01:18');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (58, 'Wyman', 'Lehner', 'dgrant@example.com', '970.993.9690', '1970-03-26 23:27:01', '1983-01-23 06:31:33');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (59, 'Russel', 'Rodriguez', 'mills.jeanette@example.org', '039-871-0850x159', '1984-03-01 00:57:34', '2016-12-26 00:48:07');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (60, 'Luna', 'Becker', 'christy37@example.org', '048.320.0557x60244', '1980-09-20 19:07:06', '1972-09-14 22:35:39');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (61, 'Rod', 'Kozey', 'rachel24@example.org', '1-588-462-4059x0056', '2018-05-24 16:11:45', '1981-10-15 23:58:10');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (62, 'Caleigh', 'Spencer', 'prunolfsdottir@example.org', '(150)674-6777x03618', '2013-06-12 09:07:23', '2011-04-21 13:21:05');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (63, 'Vallie', 'Padberg', 'xlegros@example.org', '(785)226-1381', '1991-06-30 09:14:11', '1973-10-09 02:46:20');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (64, 'Naomi', 'Smitham', 'rosina20@example.net', '942-320-1075x653', '1980-03-13 20:23:49', '1987-09-25 09:31:11');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (65, 'Marilie', 'Conn', 'gsmitham@example.org', '418.329.3147', '2008-05-27 06:36:50', '1986-04-01 15:14:47');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (66, 'Electa', 'Lubowitz', 'rae.zemlak@example.org', '249-868-1651x83441', '2003-01-08 03:30:32', '1999-02-21 10:35:13');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (67, 'Wiley', 'Emard', 'xondricka@example.com', '1-268-426-6799x674', '1988-12-26 13:34:15', '1986-05-19 11:35:36');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (68, 'Asia', 'Murray', 'candido.wolff@example.net', '1-784-765-9493x4071', '1974-05-28 18:27:49', '1993-05-17 07:48:13');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (69, 'Sigurd', 'Mosciski', 'olin.konopelski@example.com', '1-720-445-8199x800', '1999-09-02 18:38:41', '1990-11-13 01:59:42');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (70, 'Luisa', 'Christiansen', 'victor48@example.com', '+69(6)7494253278', '2009-01-13 04:57:54', '1990-09-01 22:56:54');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (71, 'Lavon', 'Green', 'edavis@example.net', '(104)162-0254x714', '1983-09-04 08:07:08', '1974-12-26 15:22:44');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (72, 'Grace', 'Murazik', 'israel16@example.com', '08877353072', '1988-10-28 19:51:01', '2001-04-26 22:06:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (73, 'Pietro', 'Cormier', 'bcummings@example.org', '1-223-807-8787', '2018-08-26 08:29:39', '2006-08-20 19:22:33');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (74, 'Alia', 'Luettgen', 'karson08@example.net', '388-160-2015x913', '2018-03-08 14:01:07', '2017-06-15 14:46:04');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (75, 'Adella', 'Heller', 'orville60@example.org', '(787)392-1783', '1984-03-16 21:02:57', '2003-07-13 03:32:59');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (76, 'Bryce', 'Koepp', 'karine46@example.net', '553-150-7877', '1984-04-18 18:42:43', '1985-01-02 13:40:57');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (77, 'Ward', 'Osinski', 'libbie.windler@example.org', '1-251-713-3806', '2015-11-16 23:12:12', '1978-01-28 09:27:09');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (78, 'Tommie', 'Braun', 'reuben10@example.net', '1-612-070-8774x84273', '2010-11-21 02:00:33', '1971-07-28 15:38:03');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (79, 'Akeem', 'Tillman', 'beahan.chasity@example.net', '1-467-381-7071x3183', '1974-07-28 20:25:03', '2007-05-31 16:15:00');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (80, 'Sydnie', 'Auer', 'zhowe@example.com', '968.537.7768', '2002-04-18 22:33:02', '2009-02-01 05:56:46');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (81, 'Esmeralda', 'Mohr', 'ella19@example.com', '(245)898-3591', '1994-03-06 20:30:03', '2002-05-31 01:53:33');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (82, 'Isidro', 'Thompson', 'gusikowski.allen@example.com', '169-705-1563', '1971-03-03 18:02:20', '1988-07-26 13:05:57');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (83, 'Ebba', 'Vandervort', 'abreitenberg@example.net', '572-071-7827x47993', '1991-01-22 16:21:56', '1996-08-05 06:39:01');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (84, 'Dawn', 'Gutmann', 'murphy.laisha@example.org', '(200)447-0090', '2005-02-17 22:57:13', '2005-05-21 07:29:47');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (85, 'D\'angelo', 'Nolan', 'jbrakus@example.org', '05848173466', '2006-12-13 03:04:26', '2010-02-25 05:34:11');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (86, 'Linda', 'Bayer', 'lebsack.juanita@example.com', '751.815.7150x250', '1970-05-26 22:11:10', '2019-03-04 16:13:15');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (87, 'Floy', 'Nicolas', 'lloyd.wolff@example.com', '655-283-5587x11666', '1970-01-20 15:40:57', '1996-11-14 04:23:33');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (88, 'Dean', 'Simonis', 'goldner.mandy@example.net', '1-835-412-3796', '1986-07-18 11:35:25', '1980-05-31 13:10:02');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (89, 'Lafayette', 'Graham', 'luettgen.eleazar@example.com', '918-372-1589x406', '1998-01-22 19:36:31', '1975-06-08 07:46:14');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (90, 'Samson', 'Jones', 'cdavis@example.com', '+89(9)4620657866', '2001-05-28 14:15:14', '1977-10-17 03:54:07');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (91, 'Ray', 'Reilly', 'ellie76@example.org', '08735344810', '1986-01-05 13:48:24', '1986-01-26 15:41:53');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (92, 'Geo', 'McDermott', 'durgan.hailey@example.net', '(923)133-0339', '1982-05-19 00:56:44', '2007-06-04 08:25:53');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (93, 'Laurel', 'Bosco', 'davis.jerrell@example.org', '503-765-5880', '1978-06-18 13:40:33', '2013-01-01 23:39:38');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (94, 'Annabelle', 'Corkery', 'bednar.salvador@example.com', '(230)695-3813', '2020-02-10 21:37:09', '2007-02-12 13:35:27');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (95, 'Darien', 'Schmitt', 'mandy.turcotte@example.net', '1-139-985-5100x8576', '2000-08-06 13:07:46', '1978-10-09 15:26:04');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (96, 'Bradley', 'Runolfsson', 'qwindler@example.org', '026-416-7514', '2009-02-11 22:31:57', '2017-10-20 09:07:08');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (97, 'Frieda', 'Klein', 'kennith02@example.net', '04747936134', '1979-04-24 00:31:18', '1999-02-26 10:19:50');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (98, 'Hosea', 'Bradtke', 'ckrajcik@example.com', '778.627.1032x830', '2006-03-11 14:30:10', '1975-04-24 14:41:09');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (99, 'Cale', 'Thompson', 'alexys83@example.net', '+45(1)3904291588', '2013-11-11 04:11:22', '2014-01-23 14:17:19');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (100, 'Lazaro', 'Nicolas', 'stevie84@example.net', '1-347-900-1612x299', '2017-11-02 15:39:01', '2005-12-01 09:13:19');
COMMIT;


INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (1, '', '2001-09-22', 'Streichbury', '40891880', '2013-05-20 08:45:13', '1974-07-30 08:58:59');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (2, '', '2019-12-03', 'South Enola', '9391875', '1983-07-05 19:34:28', '2009-08-21 01:17:59');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (3, '', '2002-04-27', 'Maialand', '8', '1986-09-02 17:54:59', '1999-02-18 16:59:53');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (4, '', '1976-04-06', 'South Garrick', '5497', '2009-02-02 14:05:45', '2018-04-23 11:43:21');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (5, '', '2011-05-21', 'Tyrellview', '9046', '2003-07-26 14:21:33', '1982-11-08 02:51:03');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (6, '', '1985-11-27', 'Ricardomouth', '338144', '1996-05-15 01:25:08', '1973-06-26 10:51:26');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (7, '', '1999-08-05', 'South Dexterbury', '584876024', '2003-04-24 12:30:46', '1972-05-11 14:00:03');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (8, '', '1981-01-17', 'East Rethamouth', '', '2019-05-16 13:27:10', '1986-10-14 14:29:51');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (9, '', '1977-05-15', 'Evertside', '67', '1987-02-17 17:47:19', '1972-10-29 06:44:22');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (10, '', '1975-03-14', 'Augustaburgh', '', '1970-02-02 07:28:49', '2001-04-23 04:02:39');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (11, '', '1981-11-11', 'East Monserrate', '18026', '1975-07-29 18:23:20', '1974-05-19 06:55:42');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (12, '', '1983-04-28', 'Tryciashire', '4297918', '2003-09-05 21:47:04', '2009-03-13 07:39:53');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (13, '', '1976-09-02', 'Michaeltown', '2817', '1978-08-14 12:54:31', '2017-06-11 10:42:46');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (14, '', '1972-02-20', 'Robertsbury', '59420269', '2014-02-06 08:37:34', '2013-05-14 07:44:58');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (15, '', '1977-03-06', 'Kuhlmanberg', '', '2010-09-05 08:37:19', '1993-10-30 11:31:55');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (16, '', '2017-04-01', 'Bartonside', '126316', '1975-02-25 08:55:36', '1980-09-10 08:20:09');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (17, '', '1999-01-27', 'West Zionland', '86178', '1983-11-10 02:49:50', '1979-12-06 07:08:01');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (18, '', '2006-08-07', 'East Tesschester', '38334', '2002-05-27 21:11:27', '1972-10-18 09:42:36');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (19, '', '1980-04-21', 'Ardithhaven', '624316', '2017-07-06 14:05:47', '1978-09-13 16:02:52');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (20, '', '2006-07-27', 'Ettieborough', '337693', '1999-04-23 01:12:57', '1972-02-03 03:17:37');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (21, '', '2016-06-28', 'Kleinchester', '371793894', '2005-08-27 03:27:54', '1984-05-13 16:12:17');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (22, '', '2003-02-17', 'Myraburgh', '61355', '2010-07-04 00:51:23', '2006-04-23 23:45:49');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (23, '', '2019-08-04', 'Ravenport', '', '1988-03-05 17:44:29', '1973-08-16 12:53:12');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (24, '', '1993-06-27', 'Priceside', '64', '1998-06-01 16:14:24', '1980-01-10 12:14:21');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (25, '', '1970-09-04', 'Johnstonshire', '55923711', '1994-01-06 16:36:16', '1974-05-23 15:44:46');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (26, '', '2014-12-11', 'Dantemouth', '25929', '1997-03-01 07:49:53', '2002-04-18 08:29:56');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (27, '', '1970-10-09', 'Deionstad', '', '1995-10-13 10:14:50', '1997-03-03 00:58:07');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (28, '', '1971-06-07', 'South Eunice', '842731289', '1973-06-10 12:23:36', '1994-06-01 22:14:44');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (29, '', '1997-10-15', 'Port Ressie', '', '1981-01-25 12:21:38', '2019-12-02 10:11:37');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (30, '', '2010-08-31', 'Madisynview', '', '1973-06-22 22:32:10', '1985-11-05 13:25:19');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (31, '', '2001-03-03', 'Port Christianfurt', '64', '2001-10-02 18:07:22', '1978-06-02 11:37:47');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (32, '', '2009-02-24', 'Lake Darryl', '9088', '2007-09-05 09:32:01', '2002-10-19 03:35:25');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (33, '', '1987-03-01', 'Destineyfort', '605024134', '1972-06-24 15:31:59', '2003-03-11 06:38:51');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (34, '', '1984-05-12', 'Jonesbury', '3850', '1971-04-14 04:27:40', '2009-10-26 23:12:28');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (35, '', '2001-01-23', 'Blancaside', '6881', '2015-04-06 23:21:10', '2003-09-26 03:48:59');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (36, '', '2007-04-14', 'Ritaland', '639596140', '1994-11-11 20:18:21', '2020-02-11 13:02:43');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (37, '', '1986-05-12', 'Port Kaylihaven', '1878803', '2005-04-14 01:48:11', '2018-11-11 08:25:47');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (38, '', '1988-08-24', 'New Ruthiebury', '6290040', '1973-08-29 04:52:47', '2020-11-07 22:13:14');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (39, '', '2019-10-28', 'Mariammouth', '74817531', '1972-10-21 13:54:24', '2015-12-22 04:20:15');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (40, '', '1977-07-28', 'Gertrudemouth', '1384', '1978-02-12 18:04:10', '2012-02-25 15:20:54');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (41, '', '2010-03-03', 'East Brendachester', '9', '1999-01-13 23:23:31', '1997-11-22 11:20:46');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (42, '', '2011-01-23', 'Gilbertmouth', '433613', '1983-06-21 17:44:53', '1972-07-01 12:28:17');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (43, '', '1983-02-14', 'Efrainton', '748994457', '2015-06-22 05:23:26', '1971-11-07 01:28:51');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (44, '', '2014-10-18', 'Kunzeborough', '92371', '1976-06-20 01:48:33', '1997-12-15 07:53:37');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (45, '', '1979-09-11', 'Giovanihaven', '25622443', '1990-05-28 11:51:22', '1993-02-05 22:49:13');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (46, '', '2006-11-28', 'Port Waltonburgh', '453', '1983-03-07 00:55:31', '2013-02-18 21:06:45');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (47, '', '1971-11-27', 'East Neva', '2', '2010-12-06 15:11:38', '2012-07-14 16:23:50');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (48, '', '2012-03-09', 'Elizaburgh', '22', '2006-01-28 11:54:41', '1990-11-13 05:03:10');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (49, '', '1978-02-02', 'Port Ludie', '109285601', '2017-09-03 18:43:18', '2018-03-01 04:58:55');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (50, '', '1984-06-15', 'Port Ivy', '90', '1973-02-07 19:00:54', '1990-08-15 06:25:31');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (51, '', '2018-06-30', 'Taraview', '5062', '2006-05-23 14:39:47', '1996-10-20 14:35:47');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (52, '', '2014-06-14', 'New Ettieville', '322906', '2015-07-05 16:00:06', '1991-03-23 16:05:52');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (53, '', '1996-09-15', 'South Damien', '822440', '1975-07-06 23:40:21', '1991-12-19 21:36:29');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (54, '', '1991-07-24', 'Lake Gretahaven', '', '1998-07-17 05:07:21', '1994-05-18 20:45:51');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (55, '', '1999-08-16', 'Lake Doyletown', '700', '2004-08-31 04:36:05', '2020-10-11 01:57:37');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (56, '', '2020-08-08', 'Isaacside', '610', '2008-12-30 08:06:12', '1989-10-20 13:56:11');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (57, '', '2000-02-08', 'Port Noraport', '167377758', '1999-11-12 09:58:05', '1996-05-03 17:12:17');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (58, '', '1977-11-06', 'Autumnside', '5067595', '2002-06-04 02:14:35', '1996-01-22 12:41:37');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (59, '', '1972-01-30', 'Clintfort', '130', '1973-01-26 14:58:43', '1989-10-29 20:55:30');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (60, '', '2003-10-08', 'South Chase', '', '1978-07-22 03:15:07', '1991-03-25 01:27:39');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (61, '', '2017-09-25', 'Gulgowskiton', '3', '1994-09-27 00:45:10', '2019-03-11 15:37:44');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (62, '', '2016-06-28', 'New Kaylee', '72258', '1990-04-28 22:11:57', '1973-01-04 18:11:09');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (63, '', '1983-07-26', 'South Daryl', '3040', '2014-07-20 07:23:12', '1998-10-11 15:22:57');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (64, '', '1971-02-02', 'Lake Marian', '231521512', '1982-12-19 17:16:15', '2000-10-18 20:19:27');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (65, '', '2020-11-18', 'Anikaland', '34', '1972-07-21 06:59:38', '1994-01-14 23:36:48');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (66, '', '2019-06-09', 'Port Dejah', '2772', '1982-05-03 05:18:46', '1995-11-27 10:15:14');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (67, '', '1979-03-16', 'Homenickfurt', '4051748', '1986-07-15 03:47:49', '1989-04-23 13:32:08');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (68, '', '1976-07-08', 'Hayesborough', '6759', '1998-03-10 16:12:39', '1983-11-14 21:00:57');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (69, '', '2002-01-20', 'Hoppemouth', '94654', '1976-10-09 11:27:32', '1994-06-08 22:37:52');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (70, '', '1971-06-28', 'East Aaliyahborough', '1981846', '1991-08-14 11:00:52', '2003-12-29 14:05:11');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (71, '', '2017-09-22', 'North Beryl', '81758', '2004-05-11 01:19:51', '1974-08-22 12:00:33');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (72, '', '2019-05-07', 'Pourosport', '3', '1983-08-28 06:26:11', '1982-12-24 18:57:10');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (73, '', '1974-09-22', 'East Elta', '79', '1982-07-21 18:44:13', '1984-11-02 19:25:58');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (74, '', '1970-09-12', 'Wintheiserborough', '344674', '1992-10-10 03:32:07', '2000-08-23 21:44:34');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (75, '', '2017-11-03', 'North Mattieport', '29191760', '2013-02-24 12:51:07', '1986-02-22 04:48:31');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (76, '', '1985-10-08', 'Demetriusside', '5037655', '1992-12-06 11:03:51', '2016-04-11 06:58:58');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (77, '', '1994-09-21', 'Joneston', '', '1999-03-10 11:54:06', '1996-07-05 16:57:46');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (78, '', '1974-07-17', 'Mitchellshire', '70', '1972-12-03 09:43:36', '2017-02-04 06:38:39');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (79, '', '2013-02-21', 'Lake Noel', '339', '2016-07-24 09:22:32', '1982-06-01 13:15:39');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (80, '', '1984-06-15', 'Carliland', '513988', '2007-07-10 16:55:55', '1970-04-04 03:17:44');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (81, '', '1998-08-01', 'Williamsonton', '417819', '1979-03-10 01:45:08', '2004-06-21 20:25:47');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (82, '', '1999-05-04', 'Leschfurt', '48132', '1985-09-18 01:24:47', '2003-05-01 09:18:00');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (83, '', '2021-04-08', 'North Nicklaus', '74825', '2004-05-18 05:01:43', '1984-11-13 01:17:42');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (84, '', '1972-01-13', 'North Budberg', '163', '2006-03-06 23:00:11', '1992-08-09 07:13:10');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (85, '', '2004-08-01', 'North Braxtonview', '987836', '2004-05-10 09:44:43', '2017-07-16 06:30:28');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (86, '', '1979-01-11', 'West Loisburgh', '38', '2001-07-16 01:43:47', '1981-03-10 17:52:10');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (87, '', '1998-07-05', 'East Lenore', '21', '2020-06-29 10:01:57', '1970-11-16 13:47:26');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (88, '', '2001-10-12', 'Mullerfort', '775859652', '2006-07-04 23:07:07', '2017-12-01 14:10:48');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (89, '', '2000-03-03', 'Goyettehaven', '438476567', '2009-10-25 02:03:39', '1973-12-18 07:53:20');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (90, '', '2013-09-17', 'New Raoulfort', '69169', '2006-09-19 17:43:26', '1984-10-19 18:23:12');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (91, '', '1989-11-13', 'East Estevan', '72272', '1986-03-25 17:38:15', '2018-09-01 15:07:24');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (92, '', '2012-09-23', 'Port Melissa', '25291333', '1979-06-11 22:50:37', '1974-04-10 21:56:45');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (93, '', '2014-06-27', 'East Waylon', '', '1991-03-01 15:28:36', '1993-08-30 23:42:54');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (94, '', '1984-08-11', 'Marcelshire', '89011', '1976-07-22 01:36:48', '2014-09-13 19:47:51');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (95, '', '2013-02-01', 'South Markushaven', '23932', '2002-09-19 03:42:36', '1993-12-25 09:49:51');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (96, '', '1976-09-15', 'Eloisaberg', '38440747', '1984-12-07 11:50:24', '1979-11-06 01:23:17');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (97, '', '2001-11-01', 'Tavaresfort', '26265', '1994-08-22 15:25:30', '2009-05-03 00:03:11');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (98, '', '2008-06-27', 'North Selmer', '', '1993-09-01 13:50:40', '2001-08-28 02:46:17');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (99, '', '2000-03-13', 'New Uniquemouth', '126', '1980-05-08 05:45:41', '2013-10-20 11:10:41');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `created_at`, `updated_at`) VALUES (100, '', '2013-06-29', 'Ahmadton', '333', '1997-01-08 09:45:12', '2002-11-18 12:23:09');
COMMIT;


INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (1, 1, 1, 'Qui illo qui eligendi quisquam praesentium aut molestiae. Quis architecto est occaecati delectus. Non molestias et rerum odit esse neque vitae.', 1, 0, '2006-01-30 03:56:02');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (2, 2, 2, 'Fuga aspernatur non harum quod. Quis molestiae molestiae aperiam quod quia corporis facere. Dolorem aut maxime ea commodi aut dolores exercitationem doloremque. Nihil nam ab reprehenderit nulla porro saepe.', 0, 0, '1991-04-30 07:54:48');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (3, 3, 3, 'Est libero temporibus saepe ratione asperiores facilis rerum. Inventore aut illum natus necessitatibus repellendus alias. Quo eligendi praesentium odio perferendis expedita et.', 0, 0, '1995-04-06 01:33:59');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (4, 4, 4, 'Itaque sed et dolorem harum. A aut sint harum non accusamus. Quis dicta ut dolorum velit nihil voluptas ipsum. Vero alias exercitationem maxime aut quia.', 0, 1, '1989-02-24 06:11:03');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (5, 5, 5, 'Illum non impedit voluptatum tempora molestiae. Iusto sint voluptatem quod vel. Ea necessitatibus laboriosam et. Iste rerum laudantium quis sapiente officia.', 1, 1, '2001-04-14 18:25:09');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (6, 6, 6, 'Perspiciatis amet corrupti esse sunt. Aut architecto amet excepturi sit. Qui fugit doloribus vero nesciunt doloremque vero fugit. Fuga sint et enim tenetur minima minima.', 1, 1, '2008-03-01 05:36:12');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (7, 7, 7, 'Et consequuntur suscipit dignissimos beatae nam. Ex culpa deleniti neque.', 1, 1, '1981-08-10 12:21:05');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (8, 8, 8, 'Eaque necessitatibus est ipsum. Quo in deserunt hic in dolor quos.', 0, 0, '2007-09-08 12:44:20');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (9, 9, 9, 'Non hic accusantium et voluptas. Error autem aperiam sit quisquam quisquam omnis iste. Aut quas itaque ea corporis explicabo.', 0, 1, '2015-09-18 04:40:45');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (10, 10, 10, 'Voluptas facilis sed in commodi repellendus animi. Expedita molestias recusandae voluptatem vero non. Aut dicta nihil in quas voluptas autem corporis.', 1, 1, '1979-09-11 09:20:31');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (11, 11, 11, 'Molestiae nam sapiente et voluptates. Ut quos totam est cupiditate quis impedit inventore dolores. A distinctio eos sit tempore fugit quaerat itaque commodi.', 1, 0, '2014-09-02 07:12:37');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (12, 12, 12, 'Officiis dolorum repellat voluptatibus delectus quaerat qui commodi. Ipsam eveniet facilis ipsam aut est minus. Modi similique eveniet aliquam aut aliquam.', 0, 1, '1974-03-11 22:58:08');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (13, 13, 13, 'Non aut qui voluptas. Beatae et cum libero dolor magni non.', 0, 1, '2020-11-30 16:33:05');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (14, 14, 14, 'Nihil dignissimos quia amet libero eos quia ad esse. Aut corporis harum voluptas aut vitae odit dolorem. Est voluptates magni neque doloremque nihil qui. Laborum reprehenderit veritatis aliquid reiciendis. Nobis ut adipisci quidem et rerum enim autem.', 1, 1, '1981-06-12 16:33:12');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (15, 15, 15, 'Quos sapiente magnam dolores ratione quia voluptate. Illum velit ut impedit eos blanditiis sint enim. Earum distinctio quia corrupti sit et ut ut. Corporis impedit magni harum aut dolores rem sit repudiandae.', 0, 1, '1970-07-27 08:55:45');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (16, 16, 16, 'Provident ut nesciunt facilis et quasi aut ex. Reprehenderit quos officia et in excepturi deserunt. Amet voluptas quis id molestiae praesentium. Commodi quo sunt odit hic.', 0, 0, '2016-12-03 09:29:14');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (17, 17, 17, 'Ipsam alias molestiae rerum repellendus eum provident. Sapiente molestiae atque natus ut et maxime aut. Tempora rerum distinctio nam sint praesentium.', 0, 0, '1986-11-26 05:16:17');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (18, 18, 18, 'Aut sunt incidunt nostrum nihil veritatis inventore. Quis ea est dolorum necessitatibus molestias est id. Aut voluptatum tempora doloremque beatae doloremque dolore a.', 1, 0, '2015-12-31 00:15:17');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (19, 19, 19, 'Voluptate recusandae neque saepe neque assumenda quis inventore voluptatem. Quod dolorem voluptas saepe minus asperiores sapiente hic. Et repellendus ullam repellendus optio in.', 1, 1, '2011-06-15 17:26:01');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (20, 20, 20, 'Delectus placeat amet amet. Est ullam magni amet est. Accusantium quia provident rerum totam. Sed ut ut laboriosam necessitatibus laudantium sint.', 0, 1, '2007-08-10 07:14:07');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (21, 21, 21, 'Ratione dignissimos non modi. Molestiae omnis ut aut repudiandae. Natus velit ut quia aut culpa modi.', 1, 0, '1994-04-24 11:23:19');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (22, 22, 22, 'Aspernatur et qui reiciendis rem dolorem optio magnam. Voluptate eos maiores harum praesentium. Modi distinctio laudantium cupiditate ut vel id.', 1, 1, '2017-04-05 00:20:21');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (23, 23, 23, 'Accusamus iusto et perferendis ipsa explicabo cum ex. Et quo id molestiae eum. Neque aperiam molestiae et provident praesentium qui optio. Et quia et velit dolorum nihil esse perspiciatis. Perferendis illum numquam et labore mollitia possimus autem.', 0, 1, '1987-03-02 06:34:41');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (24, 24, 24, 'Sint vel sunt iste qui soluta magni id impedit. Quaerat eum est inventore repellat tenetur id. Aut quam unde mollitia atque eligendi accusamus facilis. Maxime qui consequuntur dolor amet.', 1, 0, '1986-10-18 07:41:32');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (25, 25, 25, 'Et qui rerum sit inventore delectus quia. Cumque ad beatae qui ea maiores harum non. Quibusdam est cumque aut quam.', 1, 0, '2005-10-22 04:21:13');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (26, 26, 26, 'Ratione laborum magnam aut voluptatem et. Molestiae nihil possimus expedita quo necessitatibus. Nobis quod velit molestiae magnam aut occaecati. Quos perferendis sunt sapiente dignissimos maxime id consequatur vel.', 1, 1, '2020-04-02 22:03:26');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (27, 27, 27, 'Quod ut possimus quia velit molestiae aut omnis asperiores. Nemo quia aliquam tenetur accusamus. Incidunt temporibus sit ea adipisci dicta sint. Ullam possimus est praesentium recusandae.', 1, 1, '1996-09-23 21:58:47');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (28, 28, 28, 'Debitis quo temporibus veniam voluptate nemo similique accusantium. Quia aut enim natus unde nihil nisi.', 1, 1, '2002-11-21 13:14:26');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (29, 29, 29, 'Nulla odit dignissimos quae placeat qui quo maiores. Dolores aut est quia reprehenderit dolor. A laboriosam voluptatem libero accusamus beatae dolor consectetur. Excepturi voluptatibus consequatur aut qui rerum dignissimos ex.', 0, 0, '2007-05-11 19:42:43');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (30, 30, 30, 'Nihil perspiciatis dicta et dolor id amet. Doloribus est nulla officiis aperiam harum. Laboriosam quod tenetur eius recusandae molestias praesentium voluptatibus.', 1, 1, '2019-01-12 03:23:06');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (31, 31, 31, 'Qui id et qui facere. Libero sit quis adipisci excepturi perferendis aut nulla. Et exercitationem impedit et magni.', 1, 1, '1997-01-30 11:30:03');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (32, 32, 32, 'Nam perspiciatis natus itaque sunt. Quidem earum exercitationem unde quae. Molestiae praesentium est occaecati soluta doloremque error. Est labore a ullam veniam.', 0, 0, '1985-09-15 05:17:52');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (33, 33, 33, 'Doloribus rerum est mollitia omnis quo voluptatum est. Eos totam est quia sit earum. Corrupti voluptates nisi voluptatibus sit quod reprehenderit non. A sunt ea soluta autem praesentium amet earum veritatis. Sint tempora doloribus sint.', 1, 1, '2016-07-20 05:39:47');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (34, 34, 34, 'Fugit incidunt ducimus dolorum omnis aut. Quis molestiae vitae voluptas vel omnis. Quisquam nam aut iusto animi est rerum sed quam. Consequatur aliquam quisquam quia omnis.', 0, 0, '2006-10-24 16:42:43');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (35, 35, 35, 'Ex cum architecto eligendi provident perspiciatis soluta minus. Sed totam quo voluptatibus modi quae inventore. Aut nostrum ut officia.', 0, 0, '2003-05-05 18:30:52');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (36, 36, 36, 'Vitae consequatur dolore nemo delectus deserunt ea omnis. Id ut ea voluptas molestiae voluptatum sint dolorem. Et exercitationem reprehenderit pariatur aut architecto enim recusandae.', 0, 0, '2012-11-08 03:08:48');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (37, 37, 37, 'Sed sapiente eius dolore et. Dicta sed dolores quae totam ipsam voluptatem aut.', 0, 0, '1981-08-11 05:40:14');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (38, 38, 38, 'Vero quae et et nostrum et dolor eos. Velit odio id porro officia et. Omnis sint aut cum quisquam voluptatem et.', 0, 0, '1980-07-16 04:27:44');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (39, 39, 39, 'Ratione assumenda esse dolor quae. Nihil commodi deserunt possimus. Assumenda vero magni earum sit.', 0, 0, '1988-02-07 04:37:52');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (40, 40, 40, 'Eos est amet et quisquam occaecati. Quis est aliquam necessitatibus corporis est. Dicta illo eaque id in architecto.', 0, 0, '1972-06-14 16:30:50');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (41, 41, 41, 'Culpa ut adipisci molestias quidem vel quis est. Nesciunt cum molestiae doloremque impedit quidem cumque. Atque id fuga adipisci porro id vel. Modi rerum aspernatur veniam voluptatem tempora id.', 0, 1, '1972-08-31 03:09:48');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (42, 42, 42, 'Et eius rerum temporibus alias culpa. Quia autem molestiae quia corrupti et fuga. Tempore quas voluptatem id dolorem temporibus dolorem sed ratione.', 1, 0, '2000-10-03 14:38:14');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (43, 43, 43, 'Reprehenderit occaecati et incidunt qui. Qui nulla alias dignissimos cumque ut repellat. Laudantium ea voluptates nihil deleniti praesentium iusto.', 1, 0, '1974-03-27 13:34:41');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (44, 44, 44, 'Dolorem ea fugit et. Et ut quas quidem et nisi dignissimos tenetur. Temporibus consequatur repellendus dignissimos aut.', 1, 0, '1991-05-19 18:34:04');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (45, 45, 45, 'Omnis quia unde alias sed accusantium. Explicabo libero voluptatem vitae itaque ipsam. Labore accusantium et quis cupiditate voluptatem. Ad dolores quia et ipsam.', 0, 1, '2013-02-26 08:15:40');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (46, 46, 46, 'Consectetur nesciunt aut modi earum iusto. Eligendi dicta qui architecto doloribus. Doloribus ipsam et qui autem.', 1, 0, '1980-04-09 05:55:52');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (47, 47, 47, 'Dolorem corrupti est eos. Fuga distinctio debitis quam nemo est.', 1, 1, '1995-02-05 16:47:54');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (48, 48, 48, 'Et sed dolores rerum assumenda aut aut. Esse harum in deleniti ut nostrum quisquam expedita. Corrupti nostrum quibusdam provident et provident perferendis est.', 0, 1, '2010-04-28 00:00:05');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (49, 49, 49, 'Voluptas qui praesentium fugiat est recusandae cupiditate. Natus aperiam necessitatibus ea. Iure voluptatem maiores cumque doloribus et vel. Quia qui consectetur est repellendus architecto dolor et. Earum omnis iusto delectus enim explicabo.', 0, 1, '2013-07-08 01:38:08');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (50, 50, 50, 'Voluptates consequatur non vel omnis tempore consequatur quasi. Ut voluptates necessitatibus distinctio. Quos dolorem et animi veritatis reiciendis eius.', 1, 0, '1983-10-30 21:19:40');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (51, 51, 51, 'Architecto est quisquam reprehenderit atque. Tenetur corrupti a non aperiam cum sit mollitia reprehenderit. Et eos deleniti iusto. Repudiandae vel similique cupiditate quia cumque labore.', 1, 1, '2018-04-13 03:18:00');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (52, 52, 52, 'Veniam omnis dignissimos vel earum vel error. Ut excepturi qui facilis dolore. Pariatur magni optio vel voluptatibus architecto.', 0, 1, '2000-01-13 05:04:26');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (53, 53, 53, 'Quo autem fugiat ullam qui consequuntur totam et. At molestiae optio suscipit aut. Ipsa tenetur aut vel totam. Et cupiditate nostrum esse.', 1, 1, '1979-07-23 04:10:36');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (54, 54, 54, 'Non nemo a occaecati repudiandae sapiente adipisci. Consectetur tempore praesentium corporis sit amet aut. Corporis est fugit ea placeat qui dicta. Aut adipisci et cupiditate.', 1, 1, '1988-01-02 22:30:26');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (55, 55, 55, 'Culpa rerum aut ut vel consequatur debitis. Voluptatem sint sapiente excepturi assumenda dolorum. Beatae quia nam voluptatibus odio minima aut. Culpa voluptate cupiditate maxime quo eos. Et voluptatem nesciunt laboriosam.', 0, 1, '1975-08-02 13:46:26');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (56, 56, 56, 'Ea eos beatae doloremque ratione velit vel deserunt. Consectetur ea quia fugit eveniet. Voluptatem qui reprehenderit et aut labore sunt. Nobis earum necessitatibus corrupti quaerat nihil iure ut aliquam.', 0, 0, '1981-10-01 03:56:53');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (57, 57, 57, 'Voluptate dolores cum illum eligendi praesentium. Et ut quaerat et est odit aliquam fugit. Possimus minima iste cum amet consequatur. Dignissimos facere voluptatem molestias sed. Unde explicabo omnis quas quod rerum sed.', 0, 0, '1989-05-20 23:25:08');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (58, 58, 58, 'Aperiam delectus non ab repellat quisquam sit voluptatem. Voluptatem consequuntur quo dicta occaecati ab fugiat et. Omnis laudantium a ut debitis fugit. Facilis error soluta voluptas sit ipsa maxime. Odit blanditiis occaecati laborum voluptates modi deleniti.', 1, 1, '1976-12-02 03:37:45');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (59, 59, 59, 'Sed alias sit veritatis quisquam sint dicta placeat. Quas quos sit dolor voluptatem. Numquam iste asperiores ab minima voluptatibus minima quos. Ut sint id quidem nisi aut in impedit delectus.', 0, 0, '1973-07-09 12:11:24');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (60, 60, 60, 'Cupiditate adipisci dolor est voluptas. Quaerat aut suscipit officiis sapiente officiis voluptatibus aut. Qui unde nihil optio ea. Quisquam aliquid consequatur odit nam rem eaque.', 0, 1, '1991-06-06 09:29:33');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (61, 61, 61, 'Ipsa accusamus voluptates odit. Quod consequatur beatae alias nostrum rerum. Optio debitis eum sint aut facere similique doloremque voluptatem.', 1, 1, '1982-01-13 22:33:54');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (62, 62, 62, 'Asperiores non esse incidunt impedit veniam voluptatem quibusdam. Eum rerum nesciunt dolore iste officia labore.', 1, 0, '2009-09-27 23:24:33');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (63, 63, 63, 'Omnis odio distinctio rerum numquam voluptatem rem. Et quia ducimus vel repellendus voluptatem aut ex optio. Numquam soluta sapiente quasi hic architecto magnam.', 0, 0, '2008-04-06 02:42:52');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (64, 64, 64, 'Iusto sint sed facere et dolorum. Quis tempore quo sed commodi. Mollitia velit aut quaerat velit impedit iste deserunt. Quia omnis id voluptatum alias quis ex voluptatibus. Eaque aut accusantium est ipsa labore.', 0, 0, '1993-09-12 21:01:18');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (65, 65, 65, 'Molestiae omnis voluptas est optio quia in. Aliquid beatae dolores sunt neque exercitationem est. Laboriosam accusamus dolorum deserunt eum deleniti in ullam. Qui vitae sed sit eos accusamus ducimus repellat.', 1, 1, '1989-10-21 20:47:54');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (66, 66, 66, 'Totam id repellendus et tenetur magnam eum id. Amet et excepturi cum laborum doloribus et et sequi. Explicabo accusantium minus numquam natus quia dolores labore.', 0, 0, '2019-10-08 14:07:18');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (67, 67, 67, 'Ut pariatur accusantium iste quia eum architecto architecto. Rerum voluptatem ratione impedit exercitationem eum. Cum non eveniet quia provident aut. Sed minus illum dolores aut ab.', 1, 1, '2019-11-12 11:36:32');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (68, 68, 68, 'Sunt omnis et occaecati expedita vel optio quo. Sunt voluptatem nemo harum sed facere. Magnam et magnam qui vitae laboriosam ipsum culpa iste.', 0, 1, '1981-02-01 02:32:28');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (69, 69, 69, 'Animi corporis ex enim et. Laborum eveniet consequuntur ipsum placeat eaque.', 0, 1, '1996-08-11 16:29:24');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (70, 70, 70, 'Unde nobis excepturi ut soluta et. A iste soluta nulla commodi possimus maiores sint. Cum sint dolore reiciendis. Minima beatae incidunt molestias porro dolorem autem ad blanditiis.', 1, 1, '1974-06-01 16:49:43');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (71, 71, 71, 'Rerum itaque velit expedita praesentium ut omnis. Natus repellat libero impedit et. Quia quod expedita totam qui quo qui est vel. Perspiciatis suscipit reiciendis beatae corrupti eveniet.', 1, 1, '1974-01-19 08:06:31');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (72, 72, 72, 'Est vero earum laboriosam ex vel quia. Omnis omnis veritatis qui quia tenetur unde. Aliquam at totam nemo rerum sunt facere optio. Doloribus dolorem eveniet voluptatem rerum quia est animi.', 1, 0, '1997-07-04 00:11:37');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (73, 73, 73, 'Reiciendis doloribus nihil ratione enim laudantium quia impedit. Sapiente est illo dolorum rerum. Dolores ut iure voluptas quos.', 0, 0, '1977-01-08 07:01:53');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (74, 74, 74, 'Reiciendis magnam odit perspiciatis pariatur nostrum cupiditate doloremque. Odit autem est eveniet qui. Velit iure ipsa iste tempore iste nulla.', 0, 0, '2011-02-22 20:53:12');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (75, 75, 75, 'Asperiores in tempora quia est. Rerum impedit ratione nemo aliquid qui quo dolore. Et delectus aut deserunt est amet dolores qui qui.', 0, 0, '2007-08-15 08:34:27');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (76, 76, 76, 'Iste deleniti culpa nihil neque est animi. Iusto sequi molestias est alias necessitatibus. Eveniet rerum facere expedita nam atque voluptatibus. Aut accusamus est nesciunt quisquam quod nemo illum. Quisquam rerum odit delectus ut voluptate rerum sequi.', 0, 0, '1990-02-25 13:11:05');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (77, 77, 77, 'Repudiandae aut in sed voluptates cupiditate perspiciatis. Autem culpa ducimus molestiae mollitia autem dolorem. Est rerum dolorem sequi et ut explicabo.', 0, 1, '1993-12-14 17:35:30');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (78, 78, 78, 'Magnam distinctio consequatur est. Explicabo laudantium rerum culpa quasi sunt officia eos. Recusandae non nobis ut minus in nobis. Veritatis reprehenderit ab rerum quam.', 1, 0, '2013-07-19 04:26:37');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (79, 79, 79, 'Sint accusantium cupiditate quia incidunt necessitatibus molestias necessitatibus. Porro quasi quo tenetur aut iste iusto suscipit. Sed et sunt sit deserunt accusamus inventore velit.', 0, 0, '2016-11-30 10:46:33');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (80, 80, 80, 'Tenetur perspiciatis sapiente in nostrum earum. Nemo hic voluptatibus ut. Impedit odit vitae omnis aut ab expedita. Rerum veritatis nihil delectus non eum sunt et. Eveniet sequi expedita quo eveniet quo amet eum nihil.', 0, 1, '1990-10-07 12:54:46');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (81, 81, 81, 'Illum quis ipsa sint sed illum aut porro. Quaerat illo dolores aut cupiditate quia qui. Quia sed eaque consectetur quasi.', 1, 0, '1980-12-10 09:44:42');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (82, 82, 82, 'Ipsa rerum laboriosam voluptatem eius voluptatibus reiciendis. Sint eligendi id omnis nihil minus odit odio.', 0, 0, '1980-07-03 12:33:52');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (83, 83, 83, 'Corporis omnis enim asperiores quibusdam quia consequatur. Rerum quis nisi quos in vel assumenda. Quod possimus corrupti et fugiat exercitationem numquam.', 1, 0, '1977-08-24 16:12:19');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (84, 84, 84, 'Quidem similique molestias optio vero. Ea amet nostrum modi. Aliquam eius ea quis deleniti repellat corporis iste ea. Assumenda qui recusandae odio sit saepe. Maxime non eos aut et nam.', 0, 1, '2020-09-08 18:34:24');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (85, 85, 85, 'Accusantium molestias dolor iusto occaecati ad dolores in. Aut ut fugiat sunt voluptas natus dolor et. At eos delectus nisi odit nesciunt.', 1, 0, '1984-08-06 01:37:37');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (86, 86, 86, 'Corporis vel excepturi aperiam. Dolores voluptatum et rerum. Non sint et quo molestiae ad in dolorum. Quaerat iste officia amet et.', 0, 0, '1976-12-18 12:39:20');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (87, 87, 87, 'Est laborum laborum eveniet aperiam et maiores. Inventore id magni et rerum. Voluptates eveniet similique rerum deleniti ipsum doloribus omnis. Sapiente unde saepe aut harum iusto.', 0, 0, '1997-11-26 07:37:55');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (88, 88, 88, 'Vero alias veritatis veritatis dignissimos. Quia saepe et voluptatem blanditiis deleniti. Temporibus error omnis necessitatibus reprehenderit.', 0, 0, '1988-12-01 17:49:47');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (89, 89, 89, 'Natus nisi unde nisi minus id odio. Et id doloremque adipisci doloribus libero qui cupiditate. Occaecati atque quis incidunt et et in unde. Facilis quis nostrum omnis nemo libero.', 1, 0, '1989-09-06 22:56:45');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (90, 90, 90, 'Quod officiis molestiae totam aliquid explicabo error eos. Qui ipsa quisquam officia ipsam. A provident consequatur minima qui atque enim vero est.', 1, 0, '2015-09-04 22:01:50');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (91, 91, 91, 'Cumque rerum mollitia ut ipsa delectus ad aliquam. Maxime vel dolorem ut beatae est totam. Et explicabo dolorum sint quae.', 1, 0, '1981-07-27 20:16:54');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (92, 92, 92, 'Et dolores non in quae. Aliquid esse voluptate aspernatur qui non sequi. Ullam mollitia soluta debitis vero quia autem excepturi.', 1, 0, '1992-08-28 19:33:35');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (93, 93, 93, 'Voluptates recusandae quia quia sed eius aut. Incidunt sequi itaque officia qui molestias et. Minima doloremque dolorum exercitationem dolore.', 0, 1, '2011-05-20 05:51:09');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (94, 94, 94, 'Perspiciatis eos sunt tempore. Et odio molestiae omnis inventore accusantium occaecati. Quas recusandae animi enim consequatur tenetur. Ullam unde labore impedit est error harum.', 1, 0, '2014-08-08 20:43:57');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (95, 95, 95, 'Atque autem est corrupti suscipit totam similique dolores. Doloremque facere laboriosam id cumque molestias soluta aut et. Possimus aperiam perferendis alias deleniti ut voluptatem. Expedita et aliquid possimus dolorum.', 1, 0, '1996-12-08 09:28:51');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (96, 96, 96, 'Voluptatibus autem voluptates est est accusamus. Inventore tenetur recusandae non dignissimos neque repudiandae. Et eveniet magnam iusto sed cumque.', 1, 0, '1974-05-26 13:04:59');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (97, 97, 97, 'Minus fugiat atque harum corrupti facilis. Et ut cumque et. Quo dolores veritatis aliquid et sed veritatis possimus.', 1, 1, '1974-09-09 03:07:16');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (98, 98, 98, 'Non sit ut sit nostrum. Nisi voluptatem omnis provident corrupti odio aspernatur officiis. Repudiandae cum voluptatem non quia beatae libero. Et debitis tenetur sit tempora sunt qui.', 1, 1, '2010-10-18 16:07:08');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (99, 99, 99, 'Velit minima numquam dolores totam repellendus. Neque aut molestias ipsam. Consequatur sunt est aut iusto dolore ut.', 1, 1, '2019-04-30 09:03:02');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (100, 100, 100, 'Ut asperiores dignissimos officia ut ut. Porro optio aperiam maiores exercitationem aperiam et ipsam. Quo debitis ipsum ea.', 0, 1, '1987-08-20 18:27:34');
COMMIT;

--!!!!НУЖНО ИЗМЕНИТЬ ЗНАЧЕНИЕ ПОЛЯ to_user_id (ИНАЧЕ ПОЛУЧАЕТСЯ, ЧТО ПОЛЬЗОВАТЕЛЬ САМ СЕБЕ ОТПРАВЛЯЛ СООБЩЕНИЯ!!!!
UPDATE messages SET to_user_id=to_user_id+1 WHERE id>0 and id<=20;
UPDATE messages SET to_user_id=to_user_id+2 WHERE id>20 and id<=40;
UPDATE messages SET to_user_id=to_user_id+3 WHERE id>40 and id<=60;
UPDATE messages SET to_user_id=to_user_id-5 WHERE id>60 and id<=100;
COMMIT;

-- ДОП.ЗАПИСИ ДЛЯ ВЫПОЛНЕНИЯ ДЗ
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (101, 6, 5, 'Perspiciatis eos sunt tempore. Et odio molestiae omnis inventore accusantium occaecati. Quas recusandae animi enim consequatur tenetur. Ullam unde labore impedit est error harum.', 1, 0, '2014-08-08 20:43:57');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (102, 25, 5, 'Atque autem est corrupti suscipit totam similique dolores. Doloremque facere laboriosam id cumque molestias soluta aut et. Possimus aperiam perferendis alias deleniti ut voluptatem. Expedita et aliquid possimus dolorum.', 1, 0, '1996-12-08 09:28:51');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (103, 25, 5, 'Voluptatibus autem voluptates est est accusamus. Inventore tenetur recusandae non dignissimos neque repudiandae. Et eveniet magnam iusto sed cumque.', 1, 0, '1974-05-26 13:04:59');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (104, 88, 5, 'Minus fugiat atque harum corrupti facilis. Et ut cumque et. Quo dolores veritatis aliquid et sed veritatis possimus.', 1, 1, '1974-09-09 03:07:16');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (105, 88, 5, 'Non sit ut sit nostrum. Nisi voluptatem omnis provident corrupti odio aspernatur officiis. Repudiandae cum voluptatem non quia beatae libero. Et debitis tenetur sit tempora sunt qui.', 1, 1, '2010-10-18 16:07:08');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (106, 88, 5, 'Velit minima numquam dolores totam repellendus. Neque aut molestias ipsam. Consequatur sunt est aut iusto dolore ut.', 1, 1, '2019-04-30 09:03:02');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`) VALUES (107, 88, 5, 'Ut asperiores dignissimos officia ut ut. Porro optio aperiam maiores exercitationem aperiam et ipsam. Quo debitis ipsum ea.', 0, 1, '1987-08-20 18:27:34');


INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (1, 1, 'impedit', 33, NULL, 1, '2013-08-26 00:13:25', '1972-11-06 18:17:52');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (2, 2, 'possimus', 73, NULL, 2, '1980-02-09 02:12:01', '1970-10-07 16:16:58');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (3, 3, 'quia', 45972843, NULL, 3, '1986-03-05 12:44:07', '1971-02-24 00:37:17');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (4, 4, 'deserunt', 0, NULL, 4, '1986-11-03 16:29:11', '2008-07-28 19:28:31');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (5, 5, 'facere', 5, NULL, 5, '1988-09-04 17:43:22', '1999-11-28 22:05:39');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (6, 6, 'consectetur', 3423226, NULL, 1, '2011-03-12 04:25:53', '2009-12-10 05:44:37');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (7, 7, 'est', 7521, NULL, 2, '1970-09-05 21:59:20', '1980-12-17 04:50:34');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (8, 8, 'distinctio', 804, NULL, 3, '1977-06-21 00:20:44', '1996-08-25 12:55:57');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (9, 9, 'tempora', 3, NULL, 4, '2020-01-03 07:27:42', '2014-05-05 04:13:25');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (10, 10, 'voluptatem', 8, NULL, 5, '1983-12-31 20:03:49', '1979-01-13 13:11:51');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (11, 11, 'aliquid', 3661, NULL, 1, '1983-12-18 11:30:54', '2004-09-09 10:40:46');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (12, 12, 'asperiores', 2719, NULL, 2, '1997-07-17 21:33:26', '1983-05-05 18:16:31');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (13, 13, 'et', 453455226, NULL, 3, '2009-10-01 19:01:24', '1991-08-11 01:05:47');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (14, 14, 'odio', 9659, NULL, 4, '2003-06-02 22:34:04', '1977-05-02 07:23:36');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (15, 15, 'quis', 2517579, NULL, 5, '1972-09-29 13:44:41', '2003-07-22 20:49:51');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (16, 16, 'velit', 166, NULL, 1, '1970-11-25 11:54:03', '1997-07-02 05:41:36');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (17, 17, 'voluptatem', 184523, NULL, 2, '1999-03-19 07:49:50', '2002-01-19 23:27:54');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (18, 18, 'voluptatem', 44, NULL, 3, '1972-07-04 21:53:02', '1970-05-07 02:54:53');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (19, 19, 'et', 436900414, NULL, 4, '1973-08-23 05:34:41', '1989-12-12 13:56:28');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (20, 20, 'iste', 1361, NULL, 5, '1999-10-30 13:19:45', '1999-04-06 22:42:49');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (21, 21, 'consectetur', 83, NULL, 1, '1982-05-16 07:28:47', '1978-05-04 14:55:51');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (22, 22, 'aut', 1652038, NULL, 2, '1993-10-25 17:53:30', '1996-10-17 10:30:57');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (23, 23, 'facere', 70568, NULL, 3, '1982-12-29 02:59:16', '2011-06-08 07:18:46');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (24, 24, 'voluptatem', 605475, NULL, 4, '2000-11-09 04:48:12', '1998-07-31 14:55:56');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (25, 25, 'tempore', 0, NULL, 5, '2005-01-24 13:41:06', '1972-06-12 05:34:47');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (26, 26, 'similique', 2, NULL, 1, '2009-04-27 13:26:21', '1990-05-06 06:48:16');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (27, 27, 'non', 87280, NULL, 2, '2017-04-11 10:05:05', '1996-09-30 05:51:59');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (28, 28, 'nemo', 56337, NULL, 3, '2008-02-29 20:48:17', '1992-08-13 21:45:33');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (29, 29, 'omnis', 12624, NULL, 4, '1987-07-31 17:57:12', '2019-05-31 05:44:24');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (30, 30, 'eius', 80676, NULL, 5, '2002-01-01 05:38:53', '2018-12-18 02:07:02');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (31, 31, 'necessitatibus', 15043, NULL, 1, '1974-07-11 01:28:12', '1980-10-26 11:18:25');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (32, 32, 'occaecati', 9276, NULL, 2, '2003-08-30 02:57:01', '2006-03-20 11:15:04');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (33, 33, 'quas', 27, NULL, 3, '2004-03-27 01:35:42', '2019-05-18 23:54:46');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (34, 34, 'tempora', 37022, NULL, 4, '1991-09-10 08:50:42', '2010-03-29 03:58:52');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (35, 35, 'laborum', 72, NULL, 5, '1971-02-22 23:26:08', '2010-04-12 00:44:06');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (36, 36, 'aut', 23047914, NULL, 1, '1979-03-24 15:38:48', '2018-11-18 08:38:23');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (37, 37, 'ut', 67680, NULL, 2, '1974-07-19 18:19:02', '1986-07-15 02:45:25');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (38, 38, 'officiis', 8914, NULL, 3, '1994-08-24 06:40:32', '1982-06-24 19:26:10');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (39, 39, 'rem', 38363, NULL, 4, '1970-03-05 03:41:01', '1986-07-17 11:15:55');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (40, 40, 'illo', 877074, NULL, 5, '1974-03-03 16:04:41', '1981-04-02 13:49:10');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (41, 41, 'error', 0, NULL, 1, '1991-07-05 04:35:10', '1978-03-03 11:43:11');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (42, 42, 'tempora', 0, NULL, 2, '2002-09-06 07:54:58', '2004-04-19 17:28:29');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (43, 43, 'illum', 7, NULL, 3, '1979-08-02 15:00:20', '1999-10-26 14:20:44');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (44, 44, 'et', 8, NULL, 4, '2019-12-30 19:34:09', '1989-10-24 05:23:44');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (45, 45, 'optio', 288, NULL, 5, '1973-10-23 08:41:21', '1973-06-05 04:59:33');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (46, 46, 'nihil', 480279041, NULL, 1, '1994-03-24 23:34:40', '1992-07-06 06:51:22');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (47, 47, 'dolores', 57826684, NULL, 2, '2003-01-06 19:36:34', '2011-04-16 18:07:18');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (48, 48, 'temporibus', 0, NULL, 3, '2014-07-21 21:45:06', '1986-01-28 15:39:30');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (49, 49, 'facere', 11658, NULL, 4, '2016-05-02 11:45:42', '1982-06-11 17:30:00');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (50, 50, 'velit', 5064591, NULL, 5, '1972-03-27 05:52:59', '1973-09-10 16:28:02');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (51, 51, 'iusto', 55317230, NULL, 1, '1979-05-25 13:33:39', '2003-09-23 06:03:05');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (52, 52, 'qui', 72795, NULL, 2, '1977-02-26 13:39:48', '1972-02-16 06:15:15');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (53, 53, 'architecto', 255, NULL, 3, '2006-04-06 04:10:06', '2004-12-30 23:13:36');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (54, 54, 'voluptatem', 34245061, NULL, 4, '1983-02-14 20:19:23', '1984-05-17 18:50:09');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (55, 55, 'numquam', 6, NULL, 5, '2010-02-14 07:53:42', '1990-06-10 05:45:48');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (56, 56, 'quia', 0, NULL, 1, '1975-07-23 02:14:29', '1989-11-08 01:37:43');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (57, 57, 'debitis', 48, NULL, 2, '1979-09-19 01:57:54', '1986-08-23 13:51:17');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (58, 58, 'sed', 24308823, NULL, 3, '2008-01-05 22:59:59', '1975-04-16 03:19:47');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (59, 59, 'consequatur', 38052, NULL, 4, '1979-01-03 10:11:16', '2007-04-30 18:13:21');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (60, 60, 'quia', 0, NULL, 5, '1973-12-17 18:47:59', '1998-09-10 07:14:59');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (61, 61, 'nihil', 76935713, NULL, 1, '1995-09-04 08:42:13', '1993-07-10 04:19:10');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (62, 62, 'aliquam', 65028025, NULL, 2, '2009-09-08 07:19:18', '1980-07-10 09:52:41');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (63, 63, 'asperiores', 4, NULL, 3, '1977-01-22 19:56:17', '1994-02-26 05:34:21');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (64, 64, 'voluptatem', 404, NULL, 4, '2009-08-28 14:33:35', '2018-05-15 21:21:56');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (65, 65, 'minus', 33428, NULL, 5, '2012-10-02 10:01:04', '1989-07-05 03:11:01');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (66, 66, 'quam', 4665951, NULL, 1, '1977-07-01 08:13:38', '1978-05-17 10:38:18');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (67, 67, 'blanditiis', 9849, NULL, 2, '1986-10-29 20:05:13', '2017-04-30 07:04:55');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (68, 68, 'assumenda', 973, NULL, 3, '2018-05-17 04:31:18', '1993-11-18 01:18:40');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (69, 69, 'unde', 6, NULL, 4, '1999-12-28 08:06:01', '1972-02-21 09:56:36');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (70, 70, 'vel', 21617743, NULL, 5, '1981-10-17 01:08:32', '1987-07-28 17:06:26');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (71, 71, 'dolores', 8924792, NULL, 1, '1996-01-11 14:25:57', '1980-07-18 15:01:39');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (72, 72, 'porro', 0, NULL, 2, '2010-01-15 11:27:12', '1998-07-24 17:22:39');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (73, 73, 'temporibus', 6, NULL, 3, '1987-05-06 02:36:19', '1998-06-29 06:35:09');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (74, 74, 'ipsa', 2876012, NULL, 4, '1989-08-23 13:10:18', '1993-03-27 21:18:07');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (75, 75, 'quas', 0, NULL, 5, '2008-08-15 07:08:52', '1986-08-08 01:58:43');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (76, 76, 'esse', 275, NULL, 1, '2009-07-09 21:51:21', '1993-12-13 04:17:52');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (77, 77, 'ex', 38133396, NULL, 2, '2019-10-14 12:12:30', '1988-01-26 04:21:30');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (78, 78, 'rerum', 7972, NULL, 3, '1971-03-08 20:13:26', '2020-09-06 02:17:22');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (79, 79, 'deleniti', 250004, NULL, 4, '1997-11-02 07:10:59', '2012-10-04 19:59:30');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (80, 80, 'laboriosam', 11540, NULL, 5, '1971-05-04 03:14:11', '1991-03-29 05:14:14');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (81, 81, 'est', 0, NULL, 1, '1985-07-20 00:25:59', '1996-03-09 21:18:20');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (82, 82, 'laborum', 4, NULL, 2, '2018-09-18 21:38:13', '1982-05-23 18:24:05');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (83, 83, 'atque', 906831162, NULL, 3, '1983-10-31 22:17:11', '1987-09-30 22:10:41');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (84, 84, 'blanditiis', 511306556, NULL, 4, '1982-11-22 22:53:46', '2004-08-28 16:58:56');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (85, 85, 'consequatur', 25886, NULL, 5, '1972-04-02 08:29:09', '1976-12-02 11:21:04');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (86, 86, 'repellendus', 4, NULL, 1, '1973-07-21 13:26:39', '1975-01-26 06:53:06');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (87, 87, 'saepe', 49044, NULL, 2, '1984-01-06 07:55:59', '1989-09-28 13:33:52');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (88, 88, 'laudantium', 535, NULL, 3, '1975-05-17 18:08:49', '1998-07-25 16:01:16');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (89, 89, 'culpa', 2019737, NULL, 4, '2017-03-16 19:57:06', '2005-12-03 17:17:26');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (90, 90, 'qui', 821, NULL, 5, '2007-01-04 02:00:05', '2000-02-07 22:25:27');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (91, 91, 'corporis', 72495, NULL, 1, '1988-10-03 14:31:43', '2016-08-26 03:09:04');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (92, 92, 'minus', 795497420, NULL, 2, '2010-04-05 07:55:27', '1971-12-12 21:22:02');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (93, 93, 'provident', 3, NULL, 3, '1975-08-02 14:47:34', '2007-02-06 23:50:48');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (94, 94, 'quis', 6, NULL, 4, '1998-12-19 01:33:05', '1999-12-14 09:35:43');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (95, 95, 'illo', 8021, NULL, 5, '1999-09-05 13:36:25', '1985-11-06 23:38:31');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (96, 96, 'ullam', 26, NULL, 1, '1987-03-13 00:21:21', '2007-09-18 20:25:07');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (97, 97, 'occaecati', 2182, NULL, 2, '1984-05-25 21:48:42', '1982-05-25 23:48:04');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (98, 98, 'porro', 614426698, NULL, 3, '1990-08-03 17:25:27', '1999-08-19 09:54:24');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (99, 99, 'aut', 0, NULL, 4, '1996-09-27 20:54:49', '1973-11-18 21:02:10');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (100, 100, 'qui', 99, NULL, 5, '2013-10-02 19:42:49', '2014-05-22 23:00:13');
COMMIT;


INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (1, 1, 1, '1991-03-02 12:31:30', '1987-05-03 03:55:57', '1992-04-19 18:08:38', '1988-07-09 03:48:53');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (2, 2, 2, '1974-05-03 20:34:27', '1981-01-07 22:12:29', '1990-07-04 20:39:45', '2010-11-26 16:36:17');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (3, 3, 3, '1970-11-01 23:35:03', '2017-06-25 07:21:03', '2013-08-06 12:01:21', '2017-06-21 10:44:01');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (4, 4, 1, '1972-02-14 05:22:57', '1973-12-09 23:55:58', '2008-05-15 07:19:39', '1986-12-30 16:48:33');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (5, 5, 2, '1973-09-22 12:33:56', '2020-06-21 23:18:47', '1971-08-30 20:37:56', '1994-10-21 22:34:33');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (6, 6, 3, '2011-12-11 21:08:39', '1979-12-25 04:22:57', '1983-04-27 02:23:36', '1988-07-01 05:54:12');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (7, 7, 1, '1975-02-11 19:23:58', '1989-10-11 17:52:34', '1992-11-25 11:41:22', '1981-12-18 02:38:41');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (8, 8, 2, '1978-02-05 16:54:24', '1973-06-24 02:30:08', '1987-08-02 11:24:22', '2016-02-05 18:35:10');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (9, 9, 3, '1973-06-14 06:58:29', '2016-07-29 12:00:14', '1989-12-30 13:37:36', '1995-06-08 19:42:49');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (10, 10, 1, '2013-10-15 08:20:54', '2011-08-16 10:08:16', '1976-09-22 22:13:45', '1976-03-14 20:40:41');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (11, 11, 2, '2012-01-10 22:49:45', '1980-01-19 23:17:01', '2000-07-26 15:29:32', '2018-10-24 12:18:06');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (12, 12, 3, '1985-06-22 02:01:16', '2013-09-18 03:04:47', '2013-06-12 02:59:37', '1972-11-07 14:35:00');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (13, 13, 1, '1990-09-07 07:12:41', '1994-05-30 18:08:00', '1997-11-23 13:09:07', '1973-04-19 21:38:36');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (14, 14, 2, '2019-08-01 20:31:06', '1970-11-14 23:03:01', '2004-05-23 08:17:27', '1970-11-11 18:54:16');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (15, 15, 3, '1973-07-12 07:58:52', '1999-01-12 07:50:37', '1993-09-15 22:59:51', '2011-08-04 21:33:45');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (16, 16, 1, '1975-12-16 14:16:17', '1982-12-21 19:45:32', '2013-09-16 13:20:05', '1995-08-26 03:33:06');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (17, 17, 2, '1974-03-16 01:32:19', '1991-01-14 01:03:44', '2015-04-24 22:28:37', '1977-02-25 10:51:37');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (18, 18, 3, '2013-08-06 09:07:38', '2010-09-14 21:54:30', '2004-12-22 01:59:17', '2012-07-08 04:26:50');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (19, 19, 1, '2020-07-29 19:30:27', '1975-05-17 08:32:42', '2010-10-14 21:08:36', '1991-09-22 08:02:37');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (20, 20, 2, '2003-05-25 11:33:58', '2008-06-23 11:35:39', '2009-06-01 11:16:09', '1974-08-08 18:09:21');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (21, 21, 3, '1983-05-06 07:09:26', '1992-09-03 11:27:41', '2006-05-04 21:33:22', '1994-11-16 06:54:26');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (22, 22, 1, '1972-01-20 19:46:01', '1993-08-05 04:08:37', '1971-10-04 14:37:38', '2008-08-05 03:46:27');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (23, 23, 2, '2010-01-11 22:04:32', '2012-06-20 21:28:33', '2003-01-27 13:30:43', '1979-03-27 14:55:09');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (24, 24, 3, '2003-06-23 19:22:46', '2015-05-13 07:13:34', '1977-07-10 06:59:08', '1990-02-19 14:18:35');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (25, 25, 1, '2012-07-21 00:59:13', '1979-11-29 20:50:09', '2007-07-17 02:29:57', '1994-07-20 02:49:55');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (26, 26, 2, '1970-04-19 14:29:57', '2012-03-04 00:53:43', '2009-12-31 02:20:24', '2000-01-22 06:41:17');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (27, 27, 3, '2017-03-15 01:54:22', '1986-10-19 19:49:05', '1983-02-11 00:49:51', '2010-01-29 13:27:41');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (28, 28, 1, '2018-11-30 21:09:47', '1979-08-25 11:57:12', '2014-12-11 22:20:25', '2001-01-08 15:17:55');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (29, 29, 2, '2012-12-08 16:15:27', '2018-05-05 22:53:28', '1982-04-03 20:26:01', '1995-04-21 00:56:01');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (30, 30, 3, '1977-12-29 03:27:12', '1974-12-05 14:07:36', '2016-05-19 00:20:21', '2008-11-29 02:14:28');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (31, 31, 1, '1990-03-01 01:05:27', '2018-05-26 15:26:46', '2018-12-25 20:27:05', '1987-05-09 07:26:23');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (32, 32, 2, '2012-04-28 14:17:35', '1977-12-03 22:21:13', '1986-06-28 13:50:50', '1997-04-18 11:19:51');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (33, 33, 3, '2017-04-06 23:30:59', '2003-02-13 04:42:16', '2012-05-24 17:02:49', '1996-03-11 06:09:12');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (34, 34, 1, '2005-05-12 05:16:02', '1970-11-04 03:07:56', '2021-03-27 00:16:49', '2020-09-10 11:26:34');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (35, 35, 2, '1978-08-10 21:58:24', '1978-08-23 18:02:30', '1992-01-20 15:40:49', '2007-11-26 14:57:21');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (36, 36, 3, '1994-12-15 18:29:01', '2015-09-01 19:56:31', '2006-09-02 17:36:14', '1995-03-04 07:59:09');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (37, 37, 1, '1974-12-13 06:51:46', '1997-07-28 07:48:33', '2001-05-10 11:48:02', '2008-08-08 22:34:44');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (38, 38, 2, '2003-11-24 19:24:32', '2012-07-19 15:54:06', '1970-02-12 01:30:56', '2006-03-26 13:23:50');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (39, 39, 3, '1989-03-18 13:03:33', '1989-03-01 00:50:50', '1998-10-28 06:24:35', '1996-10-26 05:39:05');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (40, 40, 1, '2011-03-06 01:05:08', '2008-05-10 20:20:11', '1982-11-29 16:07:56', '2008-01-11 04:50:54');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (41, 41, 2, '1979-03-11 11:15:06', '2019-09-21 05:48:36', '1975-07-11 05:13:40', '1998-10-27 18:05:07');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (42, 42, 3, '2010-04-23 11:11:24', '1974-03-14 13:03:26', '2019-07-15 16:23:39', '1999-05-18 17:54:01');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (43, 43, 1, '2011-06-01 09:44:13', '1974-03-21 01:11:31', '1973-05-19 17:11:20', '2001-08-26 16:45:52');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (44, 44, 2, '2014-06-21 07:27:13', '2013-09-09 01:10:59', '1996-06-04 05:02:58', '2019-07-04 07:04:17');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (45, 45, 3, '1988-02-16 19:59:57', '2003-08-17 12:54:40', '1990-06-12 00:37:20', '2007-02-21 23:37:03');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (46, 46, 1, '1998-11-30 21:46:56', '1971-09-16 19:59:44', '1972-02-11 08:19:01', '1979-02-12 08:39:37');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (47, 47, 2, '2021-02-01 08:28:23', '2018-03-21 07:14:23', '2009-03-28 00:40:10', '2001-01-17 19:43:38');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (48, 48, 3, '1993-01-18 05:23:50', '1996-07-24 16:42:00', '1981-07-31 21:47:23', '2011-12-29 12:42:51');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (49, 49, 1, '2013-06-07 20:12:26', '1994-06-23 19:07:42', '1989-07-13 09:36:15', '1971-05-15 19:56:49');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (50, 50, 2, '2019-10-25 04:17:06', '2001-10-26 16:08:45', '1981-07-31 03:30:51', '2018-11-02 09:11:57');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (51, 51, 3, '2000-11-16 17:55:47', '2016-03-07 04:33:26', '1977-01-25 09:45:04', '2007-08-16 02:33:36');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (52, 52, 1, '2009-07-09 13:23:54', '1975-04-15 18:06:25', '1993-06-09 05:05:05', '1979-10-13 10:18:18');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (53, 53, 2, '2012-10-27 05:51:42', '1985-05-26 15:58:07', '1975-11-21 01:52:01', '1982-05-19 09:19:01');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (54, 54, 3, '2011-05-20 07:40:11', '2018-12-02 10:33:50', '2010-12-07 06:00:47', '2001-05-25 22:39:50');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (55, 55, 1, '1975-12-18 05:20:36', '2013-09-29 18:06:42', '1973-05-03 11:33:09', '1977-12-10 05:34:18');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (56, 56, 2, '2008-04-08 17:02:09', '2011-03-08 10:30:09', '1994-09-14 08:12:02', '2019-06-18 14:01:51');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (57, 57, 3, '1977-05-25 08:51:57', '1983-02-23 06:13:55', '1990-01-18 01:43:54', '1997-06-06 19:04:16');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (58, 58, 1, '1997-10-17 13:55:56', '2004-12-14 01:38:33', '1988-06-17 16:17:45', '1984-08-08 06:18:32');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (59, 59, 2, '2003-02-11 12:33:03', '1985-06-06 17:16:07', '1995-01-30 10:54:01', '1994-10-25 14:24:10');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (60, 60, 3, '1980-08-26 04:10:27', '1992-03-01 02:28:21', '2000-02-14 17:27:58', '1974-04-01 23:27:58');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (61, 61, 1, '2006-02-07 12:06:23', '1990-10-09 13:56:36', '2015-12-28 04:06:36', '1977-05-20 21:00:38');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (62, 62, 2, '2021-04-09 01:49:56', '2012-02-20 18:06:29', '1970-11-23 09:54:49', '2010-05-31 22:04:17');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (63, 63, 3, '2005-04-03 10:12:41', '1984-12-14 17:33:41', '1999-08-13 22:44:43', '1992-07-15 21:37:39');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (64, 64, 1, '2015-03-09 08:16:44', '2017-01-03 17:44:46', '1985-07-23 00:38:58', '2014-12-08 12:05:57');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (65, 65, 2, '2016-07-18 07:32:45', '1975-05-23 11:11:03', '1974-06-26 07:49:32', '1984-04-25 06:19:42');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (66, 66, 3, '2020-01-08 07:36:54', '2005-10-15 17:42:28', '2013-08-22 11:24:37', '1972-12-05 00:58:36');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (67, 67, 1, '1994-02-11 07:35:32', '2005-09-05 16:15:27', '2020-08-10 04:10:40', '2010-12-02 13:44:21');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (68, 68, 2, '1974-12-29 07:39:21', '2002-12-15 05:46:05', '1999-11-15 04:36:13', '1987-07-12 22:55:15');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (69, 69, 3, '1974-04-06 15:40:14', '2015-12-06 13:18:43', '1975-03-10 09:35:16', '2018-02-03 05:07:18');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (70, 70, 1, '2004-04-30 16:24:38', '1981-08-09 15:31:52', '1972-02-12 21:01:15', '1996-04-20 22:53:13');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (71, 71, 2, '1974-12-08 20:19:44', '1986-05-02 09:37:35', '1981-06-06 14:07:17', '1971-08-10 14:28:29');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (72, 72, 3, '1982-06-11 01:55:07', '1972-10-21 05:37:52', '1972-12-22 08:17:45', '1999-09-03 15:24:09');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (73, 73, 1, '2013-04-28 15:34:16', '1992-02-26 07:52:53', '2003-02-27 11:12:10', '2008-10-17 16:56:32');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (74, 74, 2, '1994-10-31 21:12:07', '2000-10-11 10:34:02', '2011-03-10 04:22:33', '1982-04-16 00:09:33');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (75, 75, 3, '2008-08-10 23:21:15', '1982-09-23 21:30:10', '2017-02-01 00:44:49', '1985-03-11 14:54:17');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (76, 76, 1, '2003-11-06 11:22:32', '1973-09-22 23:48:24', '1995-02-10 17:31:15', '1989-06-24 14:24:34');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (77, 77, 2, '1992-04-24 16:13:04', '1997-12-07 04:26:25', '2000-08-21 17:54:55', '1984-02-07 20:16:42');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (78, 78, 3, '1973-06-25 01:15:55', '2007-02-23 02:08:55', '1997-01-13 18:44:52', '1981-11-13 12:29:06');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (79, 79, 1, '1990-12-05 00:03:41', '1978-09-20 19:34:13', '1971-01-17 00:45:20', '1995-08-16 12:24:28');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (80, 80, 2, '1980-06-05 04:02:14', '1973-06-22 04:47:04', '2017-11-27 17:12:33', '2016-10-29 21:20:45');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (81, 81, 3, '1991-09-28 06:30:54', '1981-08-08 16:30:00', '2015-08-08 00:36:26', '1972-07-07 23:23:03');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (82, 82, 1, '2020-02-18 05:15:22', '1978-11-26 22:13:01', '2012-07-22 07:29:32', '1980-11-23 23:14:32');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (83, 83, 2, '1991-04-17 15:58:39', '1998-04-28 05:38:20', '2008-09-05 21:17:08', '1997-06-03 01:15:47');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (84, 84, 3, '1995-02-05 19:46:21', '1982-08-15 07:07:03', '2007-03-24 13:07:58', '2020-10-26 04:38:38');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (85, 85, 1, '1979-10-17 11:50:22', '1996-05-25 23:25:28', '2007-01-22 10:12:23', '1979-08-11 08:54:51');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (86, 86, 2, '2004-07-03 17:50:40', '1973-09-20 02:25:20', '2002-01-01 18:10:45', '2007-05-20 20:35:54');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (87, 87, 3, '1974-04-21 17:18:37', '1975-12-11 08:57:50', '1998-09-24 17:12:10', '2016-08-29 12:44:22');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (88, 88, 1, '1973-12-15 20:43:55', '1974-05-15 15:12:35', '1986-11-16 03:55:45', '2010-04-13 15:49:13');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (89, 89, 2, '2005-04-26 20:32:57', '1984-08-24 05:12:06', '2016-06-05 09:45:31', '2011-06-01 12:59:15');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (90, 90, 3, '1990-07-22 03:18:55', '2017-05-10 23:51:41', '1974-03-01 04:28:08', '1975-11-03 02:33:10');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (91, 91, 1, '1970-08-22 04:15:54', '1970-11-26 20:11:35', '1996-02-15 11:49:53', '1989-02-15 14:23:42');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (92, 92, 2, '1986-09-18 10:02:52', '1983-07-14 20:20:48', '2014-09-25 21:15:17', '1990-03-05 02:40:15');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (93, 93, 3, '2016-01-14 19:13:47', '1989-05-24 08:58:40', '2009-09-03 03:52:31', '2021-01-09 16:09:43');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (94, 94, 1, '1973-08-10 09:54:43', '2009-11-03 19:36:34', '1983-07-28 02:27:15', '2001-05-25 23:47:15');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (95, 95, 2, '1991-09-21 03:27:42', '2007-08-26 18:31:47', '1997-09-18 13:08:03', '2018-09-19 13:07:52');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (96, 96, 3, '2006-06-15 00:41:41', '2015-02-28 07:05:02', '2021-04-11 10:55:37', '2017-04-12 22:05:36');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (97, 97, 1, '1970-04-27 20:28:53', '2001-03-04 08:36:43', '1981-04-03 08:41:04', '2021-03-02 06:17:34');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (98, 98, 2, '1999-12-10 07:04:03', '2019-04-14 20:06:06', '1973-07-19 15:46:38', '2000-01-05 10:57:04');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (99, 99, 3, '2010-07-18 03:22:08', '1998-09-22 21:22:46', '2017-08-24 20:49:22', '1992-09-03 20:10:29');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (100, 100, 1, '2014-02-15 17:57:22', '1987-01-24 15:27:21', '1979-07-18 22:43:56', '2000-09-09 21:41:49');
COMMIT;

--!!!! НУЖНО ИЗМЕНИТЬ ЗНАЧЕНИЯ ПОЛЯ friend_id (ИНАЧЕ ПОЛУЧАЕТСЯ, ЧТО ПОЛЬЗОВАТЕЛЬ "ДРУЖИТ" САМ С СОБОЙ)!!!!
UPDATE friendship SET friend_id=friend_id+1 WHERE friend_id>0 AND friend_id<=40;
UPDATE friendship SET friend_id=friend_id+2 WHERE friend_id>40 AND friend_id<=80;
UPDATE friendship SET friend_id=friend_id-6 WHERE friend_id>80 AND friend_id<=100;

-- ВНЕСЕНИЕ ДОП.ЗАПИСЕЙ В ТАБЛИЦУ friendship (ДЛЯ ВЫПОЛНЕНИЯ ДЗ)
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (5, 25, 1, '2010-07-18 03:22:08', '1998-09-22 21:22:46', '2017-08-24 20:49:22', '1992-09-03 20:10:29');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (5, 88, 1, '2014-02-15 17:57:22', '1987-01-24 15:27:21', '1979-07-18 22:43:56', '2000-09-09 21:41:49');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (88, 5, 1, '2010-07-18 03:22:08', '1998-09-22 21:22:46', '2017-08-24 20:49:22', '1992-09-03 20:10:29');
INSERT INTO `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (25, 5, 1, '2014-02-15 17:57:22', '1987-01-24 15:27:21', '1979-07-18 22:43:56', '2000-09-09 21:41:49');
COMMIT;

INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (1, 1, '1984-02-26 08:27:21');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (2, 2, '1993-10-05 08:08:17');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (3, 3, '1991-02-19 03:04:48');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (4, 4, '2004-09-03 06:54:34');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (5, 5, '1979-01-20 02:41:07');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (6, 6, '2013-10-06 23:16:41');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (7, 7, '1988-08-24 18:37:35');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (8, 8, '2006-11-18 02:49:52');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (9, 9, '2021-03-30 16:35:06');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (10, 10, '1993-02-25 01:56:57');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (11, 11, '1998-07-17 05:30:23');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (12, 12, '2000-12-19 02:12:52');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (13, 13, '1998-03-29 18:27:10');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (14, 14, '1979-06-20 03:47:02');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (15, 15, '1997-08-29 23:32:07');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (16, 16, '1995-06-08 09:37:02');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (17, 17, '1977-06-25 03:25:37');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (18, 18, '1972-06-30 21:23:12');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (19, 19, '1973-04-16 08:35:38');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (20, 20, '1974-10-23 01:12:39');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (21, 21, '2016-09-29 00:06:00');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (22, 22, '1999-01-19 21:47:42');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (23, 23, '1972-10-06 17:44:31');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (24, 24, '2009-04-12 06:15:16');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (25, 25, '2004-05-19 02:01:09');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (26, 26, '1979-05-05 09:38:37');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (27, 27, '1992-02-26 13:40:48');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (28, 28, '1993-01-18 20:05:21');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (29, 29, '1988-09-22 22:58:58');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (30, 30, '2001-05-07 10:12:36');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (31, 31, '2018-09-01 04:53:36');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (32, 32, '2019-03-23 22:03:47');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (33, 33, '1973-01-14 02:14:21');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (34, 34, '1987-04-17 02:53:19');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (35, 35, '1970-03-02 04:59:02');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (36, 36, '2017-10-06 16:38:41');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (37, 37, '2002-05-15 21:41:08');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (38, 38, '2009-08-08 18:24:48');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (39, 39, '1985-03-24 22:11:30');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (40, 40, '1996-10-13 10:14:56');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (41, 41, '2004-01-06 08:59:41');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (42, 42, '2013-10-16 09:17:09');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (43, 43, '1989-11-13 12:46:15');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (44, 44, '1998-08-07 01:29:53');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (45, 45, '1997-11-06 19:28:27');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (46, 46, '2001-08-30 20:02:47');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (47, 47, '1980-06-27 20:55:55');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (48, 48, '2006-05-21 23:18:37');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (49, 49, '2019-11-29 08:22:53');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (50, 50, '2012-11-13 06:39:22');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (51, 51, '2019-08-19 17:33:33');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (52, 52, '1987-04-21 18:50:28');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (53, 53, '1973-01-31 03:48:51');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (54, 54, '1974-03-26 11:47:10');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (55, 55, '1981-10-14 05:55:58');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (56, 56, '1996-10-30 03:48:41');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (57, 57, '1977-07-16 12:12:30');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (58, 58, '1979-03-07 07:36:28');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (59, 59, '1979-09-16 23:15:58');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (60, 60, '1997-06-23 13:40:28');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (61, 61, '2019-10-22 22:08:19');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (62, 62, '2019-09-20 13:57:19');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (63, 63, '2007-04-16 16:53:30');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (64, 64, '2016-06-17 17:47:39');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (65, 65, '1987-08-14 15:04:38');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (66, 66, '1993-03-29 21:55:12');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (67, 67, '1992-12-12 07:34:20');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (68, 68, '1970-03-19 09:54:21');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (69, 69, '1972-03-08 03:00:34');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (70, 70, '2000-05-31 18:22:16');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (71, 71, '1972-01-18 18:02:25');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (72, 72, '1997-11-27 22:50:42');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (73, 73, '2015-06-07 12:15:36');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (74, 74, '2020-04-29 03:15:26');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (75, 75, '2010-11-04 22:14:49');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (76, 76, '2017-07-03 13:19:44');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (77, 77, '1975-11-07 11:10:36');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (78, 78, '2020-06-25 08:07:56');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (79, 79, '1997-03-29 04:46:25');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (80, 80, '1975-01-17 20:18:01');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (81, 81, '2010-06-10 00:21:14');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (82, 82, '2011-04-27 07:19:54');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (83, 83, '2008-07-19 08:01:45');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (84, 84, '1994-07-18 05:22:59');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (85, 85, '2019-05-12 00:52:14');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (86, 86, '1980-03-09 05:46:55');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (87, 87, '2013-11-12 12:30:04');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (88, 88, '1994-04-08 10:44:22');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (89, 89, '1981-07-04 23:42:31');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (90, 90, '1999-09-14 03:37:29');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (91, 91, '1975-11-05 16:55:50');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (92, 92, '1995-11-04 19:58:39');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (93, 93, '2003-03-07 05:40:33');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (94, 94, '1997-09-02 00:10:52');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (95, 95, '2014-03-25 04:34:13');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (96, 96, '2008-10-02 00:19:59');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (97, 97, '2012-09-05 07:11:30');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (98, 98, '1992-10-27 01:11:20');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (99, 99, '2002-11-14 19:52:13');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (100, 100, '1979-06-04 06:24:38');
COMMIT;

INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (1, 1, 'Eius aliquam distinctio nemo qui doloribus. Enim voluptatibus cupiditate dignissimos omnis ut quam maxime aut.', '1977-03-18 04:40:08', '1977-02-03 19:33:59');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (2, 2, 'Et asperiores beatae harum sint facere consequatur. Voluptatibus corrupti et illo soluta aspernatur doloribus. Autem officia quia voluptatem. Consequatur unde error nesciunt sed.', '1994-07-11 08:12:14', '2010-06-29 20:58:47');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (3, 3, 'Reprehenderit hic sunt quo molestiae. Non quis architecto omnis numquam fugiat voluptate. Laborum omnis sapiente voluptate ea delectus dicta animi suscipit.', '2016-01-25 11:11:19', '1999-09-01 14:16:33');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (4, 4, 'Neque porro et aliquam ut et. Veritatis dignissimos rerum nisi quos officiis corporis. Nesciunt praesentium eum dolores at. Dolore et occaecati et sed sed debitis.', '2013-03-20 06:43:26', '1996-05-31 04:58:54');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (5, 5, 'Excepturi assumenda debitis quasi quod quo eligendi. Fugit neque iste alias. Officiis impedit libero sapiente maiores dignissimos.', '2002-04-11 18:15:42', '2017-10-19 14:47:32');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (6, 6, 'Numquam impedit error quia repellat non est accusamus. Minus odit veritatis consequatur quisquam dolores iure modi aspernatur. Quisquam provident harum omnis odio. Fugiat praesentium est tempora iste.', '1984-03-10 05:49:31', '2014-10-31 18:27:52');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (7, 7, 'Vero dolor id voluptatem optio possimus iste. Eius eum dolores et exercitationem. Corrupti quos est facere eum. Aut veritatis rerum molestiae dolore voluptatum sapiente ratione.', '2010-04-28 10:46:31', '2004-12-28 03:45:39');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (8, 8, 'Dolorem maxime pariatur dignissimos sed. Quam voluptas praesentium sapiente aut dolores dolor eum. Consequatur ut alias dolorem velit.', '1988-04-21 04:38:48', '1984-04-19 04:17:40');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (9, 9, 'Voluptatem dignissimos corrupti aut illo consequatur. Eum modi vero omnis eligendi itaque recusandae deserunt voluptas. Officiis ipsum quis nam nesciunt.', '2016-04-18 13:37:35', '1994-01-26 13:02:40');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (10, 10, 'Voluptas ut velit id amet. Hic rerum voluptas eum qui tenetur. Quis magnam quae eius molestiae quas. Error molestiae maxime doloremque numquam totam.', '1999-08-17 23:57:07', '2018-12-18 08:52:17');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (11, 11, 'Cumque eum rem quasi suscipit sit laudantium eum. Qui voluptatem saepe natus ut libero. Repellat qui deleniti deserunt rerum qui voluptatem. Tenetur ullam optio saepe architecto cupiditate qui.', '2003-12-20 04:03:48', '1983-02-09 09:26:37');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (12, 12, 'Enim vero vero sit magni tenetur quia deleniti occaecati. Amet officiis harum itaque velit. Quo fugit ea eaque quos fugiat fugiat. Doloribus et commodi ipsum eos delectus.', '1978-01-11 00:57:29', '1993-07-03 15:36:52');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (13, 13, 'Dolores laudantium temporibus eligendi aperiam voluptas tempora et. Quos temporibus ut id nisi. Qui at qui optio asperiores sed autem. Eligendi autem excepturi commodi nobis id fugiat est.', '1988-03-02 02:39:26', '2015-12-09 01:54:38');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (14, 14, 'Voluptatibus vitae occaecati tempore sunt. Recusandae ipsa eum eius voluptatum ullam. Ad tempora ipsam hic et veritatis occaecati. Asperiores delectus cumque expedita ut qui ducimus quisquam voluptas.', '2005-07-22 06:01:09', '1989-02-27 05:28:09');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (15, 15, 'Dolorum vero exercitationem incidunt ullam. Amet porro perferendis dolorem sapiente quasi autem.', '2005-01-30 17:51:34', '1975-07-12 00:58:30');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (16, 16, 'Ut qui voluptas fugit vel quia commodi ut. Accusamus voluptatum veritatis occaecati officia.', '1977-03-03 03:56:41', '2016-05-30 16:29:07');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (17, 17, 'Suscipit iure facilis iure at suscipit nihil adipisci. Suscipit nostrum voluptatum et saepe libero nihil dolores qui. Qui et quia culpa perferendis. Tenetur in aspernatur quae asperiores.', '1974-03-03 03:21:20', '1986-10-03 12:07:10');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (18, 18, 'Ut excepturi quam explicabo voluptatem. Soluta omnis dolores vel doloribus est. Velit fugiat ipsa fugiat assumenda. Vitae aut eum porro eum.', '2001-07-16 02:09:14', '2002-02-25 04:39:32');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (19, 19, 'Consequatur et quo veritatis quis. Necessitatibus sint natus qui laboriosam aliquam praesentium esse. Magnam voluptatem et rerum veniam. Quia minus sint non qui ipsum dolorem dolores.', '1978-11-10 12:01:54', '1999-08-04 22:33:47');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (20, 20, 'Qui rem placeat temporibus rerum. Distinctio omnis soluta eos possimus fugiat. Sit qui pariatur ad perspiciatis autem dignissimos.', '1983-04-23 00:45:07', '1984-08-09 21:18:30');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (21, 21, 'Fugiat neque nihil quaerat deleniti et. Sapiente in omnis enim aspernatur. Ipsam et qui est harum aut animi consequatur aspernatur.', '1996-06-01 21:55:31', '1971-12-17 15:16:51');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (22, 22, 'Deleniti quidem consectetur quis similique aliquam harum. Consequatur illum ut id facere quia. Sit aut et voluptatem unde. Quia sint facilis at reprehenderit nobis.', '1971-09-17 15:14:49', '1974-06-09 01:51:55');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (23, 23, 'Rerum eos nulla similique voluptates non veniam assumenda ea. Quo molestiae placeat id vero. Voluptas natus aperiam molestiae itaque. Ab eos odio possimus incidunt.', '2019-12-19 14:19:05', '1973-04-19 23:37:19');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (24, 24, 'Id repellendus eos incidunt quisquam atque voluptatibus odit. Consequuntur unde enim perspiciatis adipisci aut exercitationem.', '2020-06-24 01:09:49', '2018-01-23 03:29:20');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (25, 25, 'Dolores delectus quis corporis et voluptate veritatis. Unde placeat aut corporis aliquam. Rem omnis in non.', '2001-07-03 04:26:21', '2010-05-27 13:13:10');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (26, 26, 'In exercitationem et qui quia voluptas ut modi. Deserunt sint aut vitae pariatur. Quod laudantium in possimus provident sed pariatur magnam. Et quia nihil sunt sit.', '1989-11-06 03:30:45', '2012-03-20 17:30:55');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (27, 27, 'Veniam enim eum ut quo ea blanditiis. Enim rerum qui cumque exercitationem eos non illum. Aspernatur voluptate deleniti est repudiandae nihil aperiam.', '2013-11-04 04:45:52', '2015-10-02 15:12:21');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (28, 28, 'Dolorem quo ex a quia voluptas soluta. Illo ipsa ex velit nemo illum. Facere consequatur ipsam enim voluptas et corrupti.', '2016-07-19 08:30:23', '2004-05-05 17:26:22');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (29, 29, 'Et vel ducimus quia illum voluptas ex autem. Ipsam aut fugit veniam id in quibusdam voluptatem magni. Quas necessitatibus sit tempora sit aut nesciunt. Veritatis quidem dolorum voluptatem dolorem debitis.', '2012-07-01 06:58:44', '2002-07-26 09:01:28');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (30, 30, 'Est cupiditate in id sapiente et architecto delectus. Aut non est molestias rem sit labore dignissimos. Minima sapiente exercitationem fugit quo neque expedita aut.', '1999-09-06 01:06:57', '2009-03-17 13:55:58');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (31, 31, 'Unde earum et architecto harum pariatur beatae. Et fugiat sit dicta qui autem impedit. Sapiente illo cum et quo perferendis alias.', '2013-06-19 13:29:23', '2012-06-10 08:59:21');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (32, 32, 'Ipsum reprehenderit qui nemo officia quia reiciendis. Aut praesentium vel quia. Aut aut veritatis veniam. Omnis sit saepe magnam.', '1979-03-26 19:37:47', '1993-01-25 10:50:09');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (33, 33, 'Dolores quia at enim iste quia sint quia. Cumque quo earum dolore nisi.', '2017-09-11 05:46:12', '1972-10-30 08:17:38');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (34, 34, 'Consequatur tempora est quam repellat reiciendis est. Aut dolorem consequatur itaque similique laborum voluptatem. Voluptates atque eligendi porro laborum. Dolores assumenda inventore voluptatum placeat ab maxime natus et.', '2005-10-24 19:20:13', '1995-02-08 04:23:15');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (35, 35, 'Nulla expedita nostrum expedita sunt non labore. Voluptatum quis ea et. Nam vel exercitationem odit et debitis. Ab nostrum sed et magnam nam omnis.', '1992-09-29 17:04:23', '1998-10-11 06:39:49');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (36, 36, 'Autem voluptate et eius quidem eveniet itaque unde. Cum nesciunt fugiat molestiae iusto maxime. Laboriosam quo est et excepturi sit.', '2000-01-16 05:00:21', '1970-02-03 12:57:45');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (37, 37, 'Quod et velit consequuntur voluptas. Maiores incidunt similique sed consectetur perspiciatis earum. Velit soluta repudiandae delectus corrupti. Sapiente ut est minima doloribus reiciendis quasi.', '1994-06-28 22:18:10', '1981-03-09 18:48:59');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (38, 38, 'Optio dolores optio ea id non animi eum non. Quia earum ex deserunt magnam ipsam. Molestiae sint possimus qui est dolor. Sit nisi at molestiae hic similique qui molestiae sint.', '1971-08-19 10:59:39', '1991-09-30 11:34:59');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (39, 39, 'Ut illum ea cumque tempore dolor. Fuga repellat dolor maxime veniam aut sit. Debitis quia exercitationem aut sit id dolorum voluptatibus.', '1978-03-25 12:27:38', '2001-03-20 03:21:48');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (40, 40, 'Impedit ut odit consequuntur. Soluta ducimus minima ab repudiandae ullam maxime. Explicabo iure maiores debitis nesciunt doloribus.', '1997-05-02 22:56:01', '1981-01-17 17:03:11');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (41, 41, 'Recusandae in eaque dolorem et. Eaque officia nisi aperiam repellendus atque. Aliquam et et accusantium ea. Nisi quas placeat labore. Corrupti incidunt dolorum harum provident eligendi odit quia.', '2006-05-25 06:34:34', '2008-06-16 09:33:06');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (42, 42, 'Optio veniam nulla voluptate est est. Error non voluptatum nulla sit. Officiis aut rerum sed sunt iste cumque exercitationem placeat.', '2000-01-29 11:41:07', '1981-02-25 22:29:40');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (43, 43, 'Iusto dolor voluptatibus excepturi ut. Sunt dolores quos vero praesentium porro omnis quidem accusantium. Nam qui sunt facere et aliquam magnam aut.', '2013-07-19 06:50:37', '2020-06-06 21:43:56');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (44, 44, 'Perferendis beatae qui reprehenderit id. A dolorem nihil ex similique laborum ut impedit. In veritatis deserunt sed odio harum nulla.', '1977-02-16 13:30:25', '2009-12-26 17:15:15');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (45, 45, 'Nisi aliquid asperiores libero laudantium voluptatem sed. Eligendi quae recusandae velit laudantium eligendi. Inventore rerum voluptatem blanditiis aut similique.', '1980-10-09 10:53:28', '1988-07-05 15:21:35');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (46, 46, 'Enim ipsam distinctio qui est id placeat. Cupiditate voluptas consequuntur error sit rerum hic qui. Iste veniam hic ut libero et.', '1980-03-18 14:35:10', '1994-10-21 15:02:07');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (47, 47, 'Blanditiis aperiam facere nobis recusandae. Perferendis aliquam ut ut ullam dolore voluptatum. Quia quia id quo alias odio ut nostrum. Recusandae illo illum ad rerum et.', '2020-08-06 13:51:36', '1984-10-28 18:26:26');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (48, 48, 'Doloremque velit dolorum sequi nobis molestiae. Libero laborum vitae eum et culpa. Optio architecto voluptatem optio ut sed debitis omnis inventore.', '1994-03-30 02:20:08', '2013-03-08 05:50:51');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (49, 49, 'Iste dolor suscipit omnis quibusdam error et praesentium magni. Earum voluptates minus laborum quod molestiae. Provident et libero repudiandae pariatur. Itaque hic et debitis consequatur quia commodi.', '2003-03-20 19:02:06', '1978-05-09 07:23:53');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (50, 50, 'Praesentium ut qui voluptas ut et. Deleniti et rerum quis quisquam tenetur. Quis est architecto eius error expedita explicabo commodi.', '1975-12-17 03:48:34', '1999-03-25 10:30:51');

INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (1, 1, '1993-06-22 18:43:41');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (2, 2, '2018-01-07 14:21:31');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (3, 3, '1971-01-12 14:31:58');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (4, 4, '1983-09-05 13:08:27');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (5, 5, '2016-12-26 13:59:57');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (6, 6, '1981-06-22 03:01:24');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (7, 7, '1979-02-13 22:50:36');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (8, 8, '2016-04-06 18:30:47');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (9, 9, '2015-01-11 00:28:48');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (10, 10, '1975-09-07 11:35:22');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (11, 11, '1977-08-08 11:15:28');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (12, 12, '2016-02-28 08:13:44');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (13, 13, '1976-04-24 02:19:47');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (14, 14, '1997-03-06 12:31:13');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (15, 15, '1983-09-21 11:18:37');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (16, 16, '1994-10-14 18:32:17');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (17, 17, '1991-09-24 22:42:03');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (18, 18, '2012-09-13 21:17:59');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (19, 19, '1979-07-26 22:34:01');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (20, 20, '2003-12-28 22:24:53');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (21, 21, '2017-10-31 16:44:27');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (22, 22, '2018-12-07 14:01:32');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (23, 23, '2000-05-08 20:51:37');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (24, 24, '1993-06-21 06:47:56');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (25, 25, '2000-06-10 19:28:49');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (26, 26, '2003-04-19 05:44:06');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (27, 27, '2016-07-11 06:49:46');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (28, 28, '2005-09-14 13:48:01');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (29, 29, '2008-12-18 01:59:41');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (30, 30, '1988-02-13 06:47:02');
COMMIT;

INSERT INTO `media_likes` (`media_id`, `user_id`, `created_at`) VALUES (1, 1, '1993-06-22 18:43:41');
INSERT INTO `media_likes` (`media_id`, `user_id`, `created_at`) VALUES (2, 2, '2018-01-07 14:21:31');
INSERT INTO `media_likes` (`media_id`, `user_id`, `created_at`) VALUES (3, 3, '1971-01-12 14:31:58');
INSERT INTO `media_likes` (`media_id`, `user_id`, `created_at`) VALUES (4, 4, '1983-09-05 13:08:27');
INSERT INTO `media_likes` (`media_id`, `user_id`, `created_at`) VALUES (5, 5, '2016-12-26 13:59:57');
INSERT INTO `media_likes` (`media_id`, `user_id`, `created_at`) VALUES (6, 6, '1981-06-22 03:01:24');
INSERT INTO `media_likes` (`media_id`, `user_id`, `created_at`) VALUES (7, 7, '1979-02-13 22:50:36');
INSERT INTO `media_likes` (`media_id`, `user_id`, `created_at`) VALUES (8, 8, '2016-04-06 18:30:47');
INSERT INTO `media_likes` (`media_id`, `user_id`, `created_at`) VALUES (9, 9, '2015-01-11 00:28:48');
INSERT INTO `media_likes` (`media_id`, `user_id`, `created_at`) VALUES (10, 10, '1975-09-07 11:35:22');
INSERT INTO `media_likes` (`media_id`, `user_id`, `created_at`) VALUES (11, 11, '1977-08-08 11:15:28');
INSERT INTO `media_likes` (`media_id`, `user_id`, `created_at`) VALUES (12, 12, '2016-02-28 08:13:44');
INSERT INTO `media_likes` (`media_id`, `user_id`, `created_at`) VALUES (13, 13, '1976-04-24 02:19:47');
COMMIT;
----------------------------------------------------------------------------
/* Задание 1. Проанализировать запросы, которые выполнялись на занятии, определить возможные корректировки и/или улучшения (JOIN пока не применять).*/

--1.1 На вебинаре был следующий запрос:
SELECT * FROM friendship WHERE user_id=5
UNION
SELECT * FROM friendship WHERE friend_id=5;

-- Этот запрос можно улучшить:
SELECT * FROM friendship 
WHERE user_id=5 OR friend_id=5;




-- 1.2 На вебинаре был следующий запрос:
SELECT user_id, friend_id FROM friendship
WHERE user_id=5 AND friend_id in
	(SELECT user_id FROM friendship
    WHERE friend_id=5);
	
-- Этот запрос можно улучшить:
WITH t AS 
(SELECT user_id FROM friendship
    WHERE friend_id=5)
SELECT user_id, friend_id FROM friendship
WHERE user_id=5 AND friend_id IN (SELECT user_id FROM t);



--1.3 На вебинаре был следующий запрос:
SELECT * FROM friendship WHERE user_id=5
UNION
SELECT * FROM friendship WHERE user_id=88;

-- Этот запрос можно улучшить:
SELECT * FROM friendship WHERE user_id IN (5,88)
ORDER BY user_id;



--1.4 На вебинаре был следующий запрос:
SELECT friend_id FROM friendship
WHERE user_id in 
(SELECT user_id FROM friendship WHERE user_id=5
UNION
SELECT user_id FROM friendship WHERE user_id=88);

--Этот запрос можно улучшить:
SELECT friend_id FROM friendship 
WHERE user_id IN (5,88);



--1.5 На вебинаре был следующий запрос:
SELECT * FROM profiles
WHERE user_id IN
	(SELECT DISTINCT friend_id FROM friendship
	WHERE user_id in 
					(SELECT user_id FROM friendship WHERE user_id=5
					UNION
					SELECT user_id FROM friendship WHERE user_id=88
                    )
	);
	
--Этот запрос можно улучшить (2 способа):
SELECT * FROM profiles
WHERE user_id IN
(SELECT DISTINCT friend_id FROM friendship
WHERE user_id in (5,88));

WITH t1 AS
(SELECT DISTINCT friend_id FROM friendship
WHERE user_id in (5,88))
SELECT * FROM profiles
WHERE user_id IN (SELECT friend_id from t1);

/*ЗАДАНИЕ 2. Пусть задан некоторый пользователь. 
Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.*/

WITH m AS
(SELECT DISTINCT friend_id FROM friendship --определяем всех друзей пользователя (в нашем случае user_id=5)
WHERE user_id =5 and friendship_status_id=1),
m1 AS
(SELECT from_user_id, count(*) as sms_count FROM messages -- определяем количество сообщений каждого друга пользователю c user_id=5
WHERE to_user_id =5 and from_user_id in (select friend_id from m) 
group by from_user_id )                        
select * from m1	-- выводим друзей пользователя и количество сообщений с сортировкой по убыванию. Самая первая строка показывает нам друга, который больше всего общался с пользователем 
ORDER BY sms_count desc


/* ЗАДАНИЕ 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.*/

-- Поскольку в выборке есть пользователи, которым нет и года, то было решено внести изменения в данные:

UPDATE profiles SET birthday=DATE_ADD(birthday, INTERVAL -10 YEAR) where birthday>'2015-01-01';
COMMIT;

-- Добавляем данные в таблицу posts_likes (для выполнения задания)
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (5, 26, '2003-04-19 05:44:06');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (5, 27, '2016-07-11 06:49:46');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (5, 28, '2005-09-14 13:48:01');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (5, 29, '2008-12-18 01:59:41');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (26, 30, '1988-02-13 06:47:02');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (26, 90, '2003-04-19 05:44:06');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (26, 27, '2016-07-11 06:49:46');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (44, 28, '2005-09-14 13:48:01');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (44, 29, '2008-12-18 01:59:41');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (44, 30, '1988-02-13 06:47:02');

  WITH A AS
  (SELECT user_id, birthday, curdate() as current_day, -- загружаем в A 10 самых молодых пользователей
  TIMESTAMPDIFF(month,birthday,CURDATE())/12, 
  truncate(TIMESTAMPDIFF(month,birthday,CURDATE())/12,0) AS age
  FROM profiles
  ORDER BY age
  limit 10),
  A1 AS(
  SELECT count(*) as likes_count FROM posts_likes l -- подсчет количества лайков постов
  INNER JOIN user_posts p on l.post_id = p.id 
  where p.user_id in (select user_id from A)
  UNION
  SELECT count(*) as likes_count from media_likes l -- подсчет количества лайков медиафайлов
  INNER JOIN media p ON l.media_id=p.id
  WHERE p.user_id in (select user_id from A)  )
  select sum(likes_count) from A1 -- суммируем количество лайков постов и медиафайлов
  
  
  
/* ЗАДАНИЕ 4.  Определить кто больше поставил лайков (всего) - мужчины или женщины? */

--Поскольку поле gender при вставке данных было NULL, обновляем поле:
UPDATE profiles SET gender='M' WHERE user_id>0 AND user_id <=65; --мужчины (male)
UPDATE profiles SET gender='F' WHERE user_id>65 AND user_id <=100; --женщины (female)
COMMIT;

SELECT * FROM profiles; --проверяем, что данные в поле gender появились

-- Вносим дополнительные данные в таблицы:
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (51, 71, 'Eius aliquam distinctio nemo qui doloribus. Enim voluptatibus cupiditate dignissimos omnis ut quam maxime aut.', '1977-03-18 04:40:08', '1977-02-03 19:33:59');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (52, 72, 'Et asperiores beatae harum sint facere consequatur. Voluptatibus corrupti et illo soluta aspernatur doloribus. Autem officia quia voluptatem. Consequatur unde error nesciunt sed.', '1994-07-11 08:12:14', '2010-06-29 20:58:47');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (53, 73, 'Reprehenderit hic sunt quo molestiae. Non quis architecto omnis numquam fugiat voluptate. Laborum omnis sapiente voluptate ea delectus dicta animi suscipit.', '2016-01-25 11:11:19', '1999-09-01 14:16:33');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (54, 74, 'Neque porro et aliquam ut et. Veritatis dignissimos rerum nisi quos officiis corporis. Nesciunt praesentium eum dolores at. Dolore et occaecati et sed sed debitis.', '2013-03-20 06:43:26', '1996-05-31 04:58:54');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (55, 75, 'Excepturi assumenda debitis quasi quod quo eligendi. Fugit neque iste alias. Officiis impedit libero sapiente maiores dignissimos.', '2002-04-11 18:15:42', '2017-10-19 14:47:32');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (56, 76, 'Numquam impedit error quia repellat non est accusamus. Minus odit veritatis consequatur quisquam dolores iure modi aspernatur. Quisquam provident harum omnis odio. Fugiat praesentium est tempora iste.', '1984-03-10 05:49:31', '2014-10-31 18:27:52');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (57, 77, 'Vero dolor id voluptatem optio possimus iste. Eius eum dolores et exercitationem. Corrupti quos est facere eum. Aut veritatis rerum molestiae dolore voluptatum sapiente ratione.', '2010-04-28 10:46:31', '2004-12-28 03:45:39');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (58, 78, 'Dolorem maxime pariatur dignissimos sed. Quam voluptas praesentium sapiente aut dolores dolor eum. Consequatur ut alias dolorem velit.', '1988-04-21 04:38:48', '1984-04-19 04:17:40');
INSERT INTO `user_posts` (`id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES (59, 79, 'Voluptatem dignissimos corrupti aut illo consequatur. Eum modi vero omnis eligendi itaque recusandae deserunt voluptas. Officiis ipsum quis nam nesciunt.', '2016-04-18 13:37:35', '1994-01-26 13:02:40');

INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (51, 86, '2003-04-19 05:44:06');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (51, 87, '2016-07-11 06:49:46');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (52, 88, '2005-09-14 13:48:01');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (52, 89, '2008-12-18 01:59:41');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (53, 90, '1988-02-13 06:47:02');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (56, 90, '2003-04-19 05:44:06');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (56, 87, '2016-07-11 06:49:46');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (54, 88, '2005-09-14 13:48:01');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (54, 89, '2008-12-18 01:59:41');
INSERT INTO `posts_likes` (`post_id`, `user_id`, `created_at`) VALUES (54, 90, '1988-02-13 06:47:02');

  WITH F AS(
  SELECT sum(male_likes_count) FROM -- количество лайков мужчин
	( SELECT count(*) as male_likes_count FROM posts_likes l --лайки на посты
	INNER JOIN profiles pp on l.user_id = pp.user_id
	WHERE pp.gender = 'M' --male
	UNION
	SELECT count(*) as male_likes_count FROM media_likes l --лайки на медиафайлы
	INNER JOIN profiles pp on l.user_id = pp.user_id
	WHERE pp.gender = 'M' --male
    ) as b
  ),
 F1 AS (
 SELECT sum(female_likes_count) FROM 
	(SELECT count(*) as female_likes_count FROM posts_likes l -- лайки на посты
	INNER JOIN profiles pp on l.user_id = pp.user_id
	WHERE pp.gender = 'F' --female
	UNION
	SELECT count(*) as female_likes_count FROM media_likes l -- лайки на медиафайлы
	INNER JOIN profiles pp on l.user_id = pp.user_id
	WHERE pp.gender = 'F') as b1
	)
 SELECT * FROM F, F1
 
 -- ВЫВОД: !!!Количество лайков, поставленных мужчинами, больше!!!
 
 
 
 /* ЗАДАНИЕ 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.*/
 
/* Для выполнения данной задачи надо сначала понять, что понимается под активностью в социальной сети. Это может быть:
-- отправка сообщений друзьям
-- выкладывание медиафайлов
-- выкладывание постов
-- лайки на медиафайлы
-- лайки на посты
Исходя из этого нужно искать пользователей, которые меньше всего выполняет данные операции */
 
 
SELECT aa.user_id, SUM(a) as kolvo FROM
	(SELECT u.user_id, count(b.id) as a FROM profiles u
	LEFT JOIN messages b on u.user_id = b.from_user_id -- сообщения
	GROUP BY u.user_id	
	UNION
	SELECT  u.user_id, count(b.post_id) as a FROM profiles u
	LEFT JOIN posts_likes b on u.user_id = b.user_id -- лайки на посты
	GROUP BY u.user_id
	UNION
	SELECT  u.user_id, count(b.media_id) as a FROM profiles u
	LEFT JOIN media_likes b on u.user_id = b.user_id -- лайки на медиафайлы
	GROUP BY u.user_id
	UNION 
	SELECT  u.user_id, count(b.id) as a FROM profiles u
	LEFT JOIN user_posts b on u.user_id = b.user_id -- выкладывание постов
	GROUP BY u.user_id
	UNION
	SELECT  u.user_id, count(b.id) as a  FROM profiles u
	LEFT JOIN media b on u.user_id = b.user_id -- загрузка медиафайлов
	GROUP BY u.user_id
	) as aa
GROUP BY aa.user_id
ORDER BY kolvo
LIMIT 10;