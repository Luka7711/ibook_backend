# Installation
npm install


# Book exchange

Web app, where people can exchange books.
User creates a list of unwanted books.
* User searches book
* If book found, select the book you want to exchange from your unwanted list
* Hit button offer
* Person can either accept or decline offer
* If both users come to positive agreement
* New book will be added to User's EXCHANGE list


## API endpoints

POST /auth/login - user logs in
POST /auth/register - user creates new account
GET /auth/login - redirects to login form
GET /auth/register - redirects to register form

INDEX ROUTE
GET /ibook - home page, returns all books in whole web app

NEW ROUTE
GET /ibook/new - show form where user can add new book to unwanted list

CREATE ROUTE
POST /ibook/unwantedList - user adds new book to library

INDEX ROUTE
GET /ibook/profile - show unwanted list, exchanged book list, proposals list of user's books.

SHOW ROUTE
GET /ibook/unwantedList/attributes {book.id} - user sees single book from unwanted list

SHOW ROUTE
GET /ibook/offersList/attributes {user.id} - show single book of some user, who sent a proposal for exchange

CREATE ROUTE
POST /ibook/offerList - Add exchanged book to users list

DESTROY ROUTE
DELETE /ibook/offerList/:attributes {book.id} - Removes book from exchanging list of user, and redirects to user's profile

DESTROY ROUTE
DELETE /ibook/unwantedList/attributes {book.id} - user deletes single book from unwanted list

EDIT ROUTE
GET /ibook/unwantedList/edit - shows edit form, to edit book data

UPDATE ROUTE
PUT /ibook/unwantedList/:attributes {book.id} - updating book from unwanted list


## MVP

User able to:

- Register
- Login
- Create list of unwanted books
- Send offer to another user for book exchange
- Edit/Delete book from list of unwanted books

Features: 

- Categories for books
- Location of user (Google Map)


## Stretch Goals

- Have a messenger
- Leave comments on user profile
