DROP DATABASE IF EXISTS book_library;
CREATE DATABASE book_library;

\c book_library

CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	username VARCHAR(32),
	password_digest VARCHAR(60),
	zip_code INTEGER NOT NULL
);

CREATE TABLE categories(
	id SERIAL PRIMARY KEY,
	name VARCHAR(64)
);
INSERT INTO categories (name) VALUES(
'horror'
);
INSERT INTO categories (name) VALUES(
'western'
);
INSERT INTO categories (name) VALUES(
'science'
);
INSERT INTO categories (name) VALUES(
'fantasy'
);
INSERT INTO categories (name) VALUES(
'romance'
);
INSERT INTO categories (name) VALUES(
'biography'
);

CREATE TABLE books(
	id SERIAL PRIMARY KEY,
	title VARCHAR(60),
	author VARCHAR(60),
	published_year INTEGER NOT NULL,
	description VARCHAR(1000),
	image VARCHAR(1000),
	user_id INTEGER REFERENCES users(id),
	category_id INTEGER REFERENCES categories(id)
);

CREATE TABLE comments(
	id SERIAL PRIMARY KEY,
	comment_for VARCHAR(1000),
	user_id INTEGER REFERENCES users(id),
	from_id INTEGER REFERENCES users(id),
	book_offered_id INTEGER REFERENCES books(id),
	book_for_exchange_id INTEGER REFERENCES books(id),
	sender_name VARCHAR(65)
);