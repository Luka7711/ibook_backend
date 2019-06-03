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

INSERT INTO users (username, password_digest, zip_code) VALUES(
'Luka', '6737', 60630
);

INSERT INTO users (username, password_digest, zip_code) VALUES(
'Jim', '6737', 10035
);


INSERT INTO books (title, author, published_year, description,
image, user_id, category_id) VALUES('Undisputed Truth', 'Mike Tyson',
2015, 'Hey guys just read this book, i want to exchange on something cool',
'https://images-na.ssl-images-amazon.com/images/I/51-nYcAl5WL._SX338_BO1,204,203,200_.jpg',
3, 6);

