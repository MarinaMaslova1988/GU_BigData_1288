/* Задание 1. Повторить все действия по доработке БД vk.
Задание 2. Заполнить новые таблицы данными*/

--1.1 Таблица profiles
ALTER TABLE profiles ADD CONSTRAINT fk_profiles_users FOREIGN KEY (user_id) REFERENCES users (id);

ALTER TABLE profiles ADD COLUMN media_id INT UNSIGNED;
DESCRIBE profiles;

ALTER TABLE profiles ADD CONSTRAINT fk_profiles_media FOREIGN KEY (media_id) REFERENCES media (id);

-- 1.2 Таблица friendship
ALTER TABLE friendship ADD CONSTRAINT fk_friendship_users_1 FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE friendship ADD CONSTRAINT fk_friendship_users_2 FOREIGN KEY (friend_id) REFERENCES users (id);
ALTER TABLE friendship ADD CONSTRAINT fk_friendship_status FOREIGN KEY (friendship_status_id) REFERENCES friendship_statuses (id);

-- 1.3 Таблица message_statues 
--(после создания таблица заполняется данными - это задание 2)
CREATE TABLE message_statues (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL UNIQUE,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT 'Статусы сообщений'

INSERT INTO message_statues (name) VALUES ('Создан');
INSERT INTO message_statues (name) VALUES ('Отправлен');
INSERT INTO message_statues (name) VALUES ('Доставлен');
INSERT INTO message_statues (name) VALUES ('Ошибка');

--1.4 Таблица messages
-- (для создания внешнего ключа fk_message_status новое поле status_id заполняется данными)
ALTER TABLE messages ADD COLUMN status_id INT UNSIGNED NOT NULL;
SELECT * FROM messages;
UPDATE messages SET status_id = 1 WHERE id>0 ;

-- поскольку поле media_id может принимать NULL значения, необязательно заполнять это поле media_id данными
ALTER TABLE messages ADD COLUMN media_id INT UNSIGNED;
DESCRIBE messages;

ALTER TABLE messages ADD CONSTRAINT fk_messages_media FOREIGN KEY (media_id) REFERENCES media (id);
ALTER TABLE messages ADD CONSTRAINT fk_message_status FOREIGN KEY (status_id) REFERENCES message_statues (id); 
ALTER TABLE messages ADD CONSTRAINT fk_message_users_1 FOREIGN KEY (from_user_id) REFERENCES users (id);
ALTER TABLE messages ADD CONSTRAINT fk_message_users_2 FOREIGN KEY (to_user_id) REFERENCES users (id);

--1.5 Таблица communities_users
ALTER TABLE communities_users ADD CONSTRAINT fk_communities_user FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE communities_users ADD CONSTRAINT fk_community_id FOREIGN KEY (community_id) REFERENCES communities (id);

-- 1.6 Таблица media
ALTER TABLE media ADD CONSTRAINT fk_media_type FOREIGN KEY (media_type_id) REFERENCES media_types (id);

-- 1.7 Таблица user_posts
ALTER TABLE user_posts ADD CONSTRAINT fk_user_posts FOREIGN KEY (user_id) REFERENCES users (id);

-- 1.8 Таблица posts_likes
ALTER TABLE posts_likes ADD CONSTRAINT fk_posts_likes_user FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE posts_likes ADD CONSTRAINT fk_posts_likes_post FOREIGN KEY (post_id) REFERENCES user_posts (id);

-- 1.9 Таблица media_likes
ALTER TABLE media_likes ADD CONSTRAINT fk_media_likes_user FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE media_likes ADD CONSTRAINT fk_media_likes_post FOREIGN KEY (media_id) REFERENCES media (id);


/* Задание 3. Повторить все действия CRUD.*/

-- 3.1 Таблица media_types
--(таблица была заполнена в ходе выполнения ДЗ к Уроку 3)

SELECT * FROM media_types;
/* Результат выполнения запроса ДО внесения изменений:

1	photo	2021-04-02 19:58:17	2021-04-02 19:58:17
2	video	2021-04-02 19:58:52	2021-04-02 19:58:52
3	music	2021-04-02 22:42:31	2021-04-02 22:42:31
*/

UPDATE media_types SET name = 'audio' where id=3;
COMMIT;

INSERT INTO media_types (name) values ('file');
INSERT INTO media_types (name) values ('gif');

SELECT * FROM media_types;
/* Результат выполнения запроса ПОСЛЕ внесения изменений:
1	photo	2021-04-02 19:58:17	2021-04-02 19:58:17
2	video	2021-04-02 19:58:52	2021-04-02 19:58:52
3	audio	2021-04-02 22:42:31	2021-04-06 20:19:54
4	file	2021-04-06 20:20:51	2021-04-06 20:20:51
5	gif	    2021-04-06 20:20:51	2021-04-06 20:20:51
*/

/* Удаление одной записи из таблицы. Очистка таблицы. Перед очисткой таблицы нужно отключить (либо удалить) FK. */
DELETE FROM media_types WHERE id = 5;
COMMIT;

ALTER TABLE media DROP FOREIGN KEY fk_media_type; -- удаление FK fk_media_type

TRUNCATE TABLE media_types; -- очистка таблицы

/*Внесение данных в таблицу media_types. Повторное создание FK fk_media_type*/
INSERT INTO media_types (name) values ('photo');
INSERT INTO media_types (name) values ('audio');
INSERT INTO media_types (name) values ('video');
INSERT INTO media_types (name) values ('gif');
INSERT INTO media_types (name) values ('file');
COMMIT;

ALTER TABLE media ADD CONSTRAINT fk_media_type FOREIGN KEY (media_type_id) REFERENCES media_types (id);

/*Задание 4. Подобрать сервис-образец для курсовой работы.

Для курсовой работы был выбран магазин детских товаров: https://www.akusherstvo.ru/ */



