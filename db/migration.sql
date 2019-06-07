DROP DATABASE IF EXISTS book_library;
CREATE DATABASE book_library;

\c book_library

CREATE TABLE states(
	id SERIAL PRIMARY KEY,
	code CHAR(2) NOT NULL,
	name VARCHAR(120) NOT NULL
);

insert into states (code,name) values ('AL','Alabama');
insert into states (code,name) values ('AK','Alaska');
insert into states (code,name) values ('AS','American Samoa');
insert into states (code,name) values ('AZ','Arizona');
insert into states (code,name) values ('AR','Arkansas');
insert into states (code,name) values ('CA','California');
insert into states (code,name) values ('CO','Colorado');
insert into states (code,name) values ('CT','Connecticut');
insert into states (code,name) values ('DE','Delaware');
insert into states (code,name) values ('DC','District of Columbia');
insert into states (code,name) values ('FL','Florida');
insert into states (code,name) values ('GA','Georgia');
insert into states (code,name) values ('GU','Guam');
insert into states (code,name) values ('HI','Hawaii');
insert into states (code,name) values ('ID','Idaho');
insert into states (code,name) values ('IL','Illinois');
insert into states (code,name) values ('IN','Indiana');
insert into states (code,name) values ('IA','Iowa');
insert into states (code,name) values ('KS','Kansas');
insert into states (code,name) values ('KY','Kentucky');
insert into states (code,name) values ('LA','Louisiana');
insert into states (code,name) values ('ME','Maine');
insert into states (code,name) values ('MD','Maryland');
insert into states (code,name) values ('MA','Massachusetts');
insert into states (code,name) values ('MI','Michigan');
insert into states (code,name) values ('MN','Minnesota');
insert into states (code,name) values ('MS','Mississippi');
insert into states (code,name) values ('MO','Missouri');
insert into states (code,name) values ('MT','Montana');
insert into states (code,name) values ('NE','Nebraska');
insert into states (code,name) values ('NV','Nevada');
insert into states (code,name) values ('NH','New Hampshire');
insert into states (code,name) values ('NJ','New Jersey');
insert into states (code,name) values ('NM','New Mexico');
insert into states (code,name) values ('NY','New York');
insert into states (code,name) values ('NC','North Carolina');
insert into states (code,name) values ('ND','North Dakota');
insert into states (code,name) values ('OH','Ohio');
insert into states (code,name) values ('OK','Oklahoma');
insert into states (code,name) values ('OR','Oregon');
insert into states (code,name) values ('PW','Palau');
insert into states (code,name) values ('PA','Pennsylvania');
insert into states (code,name) values ('PR','Puerto Rico');
insert into states (code,name) values ('RI','Rhode Island');
insert into states (code,name) values ('SC','South Carolina');
insert into states (code,name) values ('SD','South Dakota');
insert into states (code,name) values ('TN','Tennessee');
insert into states (code,name) values ('TX','Texas');
insert into states (code,name) values ('UT','Utah');
insert into states (code,name) values ('VT','Vermont');
insert into states (code,name) values ('VI','Virgin Islands');
insert into states (code,name) values ('VA','Virginia');
insert into states (code,name) values ('WA','Washington');
insert into states (code,name) values ('WV','West Virginia');
insert into states (code,name) values ('WI','Wisconsin');
insert into states (code,name) values ('WY','Wyoming');



CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	username VARCHAR(32),
	password_digest VARCHAR(60),
	city VARCHAR(32),
	state_code INTEGER REFERENCES states(id)
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
	sender_name VARCHAR(65),
	time_date VARCHAR(100)
);

