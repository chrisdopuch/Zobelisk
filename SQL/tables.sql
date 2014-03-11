/* This is the sql file that will build the web database for Zobelisk */

DROP TABLE IF EXISTS database.users;
DROP TABLE IF EXISTS database.posts;
DROP TABLE IF EXISTS database.favorites;
DROP TABLE IF EXISTS database.interests;
DROP TABLE IF EXISTS database.tags;
DROP TABLE IF EXISTS database.zobelisks;
DROP TABLE IF EXISTS database.zones;
DROP TABLE IF EXISTS database.comments;
DROP TABLE IF EXISTS database.authorization;

CREATE SCHEMA database;
SET search_path TO database;

CREATE TABLE users (
email		VARCHAR(50) NOT NULL PRIMARY KEY,
salt		char(40) NOT NULL,
fname		char(30) NOT NULL,
lname		char(30) NOT NULL,
dob			date NOT NULL,
phone		varchar(10),
picture		varchar(260),
address		varchar(max),
twitter		char(18),
);

CREATE TABLE authorization (
email 			varchar(50) NOT NULL REFERENCES database.users(email) ON DELETE CASCADE PRIMARY KEY,
pwhash			varchar(40) NOT NULL
);

CREATE TABLE tags (
tag				varchar(30) NOT NULL PRIMARY KEY
);

CREATE TABLE interests (
email			varchar(50) NOT NULL REFERENCES database.users(email)  ON DELETE CASCADE,
tag 			varchar(30) NOT NULL REFERENCES database.tags(tag)  ON DELETE CASCADE,
PRIMARY KEY (email, tag)
);

CREATE TABLE zones (
zoneID			serial NOT NULL PRIMARY KEY,
name			varchar NOT NULL(50)		
);

CREATE TABLE zobelisks (
zobID			serial NOT NULL PRIMARY KEY,
zoneID			numeric NOT NULL REFERENCES database.zones(zoneID),
name			varchar(30) NOT NULL,
location		geography(POINT, 4326)
);



