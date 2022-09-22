create database steam;
use steam;


CREATE TABLE IF NOT EXISTS Steam.User (
  idUser INT NOT NULL AUTO_INCREMENT,
  login VARCHAR(45) NOT NULL,
  password VARCHAR(45) NOT NULL,
  Chat_idChat INT NOT NULL,
  PRIMARY KEY (`idUser`));
 
 
CREATE TABLE IF NOT EXISTS Steam.Profile (
  idProfile INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  country VARCHAR(45) NOT NULL,
  idUser INT NOT NULL,
  level INT NOT NULL,
  PRIMARY KEY (`idProfile`));
   
   
CREATE TABLE IF NOT EXISTS Steam.Inventar (
  idInventar INT NOT NULL AUTO_INCREMENT,
  idGame INT NOT NULL,
  idItem INT NOT NULL,
  UserId INT NOT NULL,
  PRIMARY KEY (`idInventar`));
 
 
CREATE TABLE IF NOT EXISTS Steam.Forum (
  idForum INT NOT NULL AUTO_INCREMENT,
  category VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idForum`));
 
 
 CREATE TABLE IF NOT EXISTS Steam.Item (
  idItem INT NOT NULL AUTO_INCREMENT,
  idGame INT NOT NULL,
  name VARCHAR(45) NOT NULL,
  FomerOwner VARCHAR(45) NOT NULL,
  NewOwner VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idItem`));
 
 
 CREATE TABLE IF NOT EXISTS Steam.Games (
  idGame INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  creator VARCHAR(45) NOT NULL,
  price INT NOT NULL,
  PRIMARY KEY (`idGame`));
 
 
 CREATE TABLE IF NOT EXISTS Steam.Chat (
  idChat INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(45) NOT NULL,
  date DATE NOT NULL,
  PRIMARY KEY (`idChat`));

 
CREATE TABLE IF NOT EXISTS Steam.Comments (
  idComments INT NOT NULL AUTO_INCREMENT,
  comment VARCHAR(45) NOT NULL,
  idUser INT NOT NULL,
  GamesId INT NOT NULL,
  PRIMARY KEY (`idComments`));
 
 
CREATE TABLE IF NOT EXISTS Steam.Friends (
  idFriends INT NOT NULL AUTO_INCREMENT,
  from_user_id INT NOT NULL,
  to_user_id INT NOT NULL,
  PRIMARY KEY (`idFriends`));
 
 
CREATE TABLE IF NOT EXISTS Steam.Games_has_Profile (
  GamesId INT NOT NULL,
  ProfileId INT NOT null);
 
 
 CREATE TABLE IF NOT EXISTS Steam.Forum_has_User (
  ForumId INT NOT NULL,
  UserId INT NOT null);
 
 
 CREATE TABLE IF NOT EXISTS Steam.`Chat_has_User`(
 ChatId int not null,
 UserId int not null);
 

--forum_has_user !
 
alter table forum_has_user 
 add constraint foreign key(ForumId) references forum(idForum);

alter table forum_has_user
add constraint foreign key(UserId) references user(idUser);


--chat_has_user !

alter table chat_has_user
add constraint foreign key (ChatId) references chat(idChat);

alter table chat_has_user
add constraint foreign key (UserId) references user(idUser);
 


--games has profile !

alter table games_has_profile 
add constraint foreign key (GamesId) references games(idGame);

alter table games_has_profile 
add constraint foreign key (ProfileId) references profile(idProfile)

alter table profile
add constraint  foreign key(idUser) references user(idUser);

--friends !

alter table friends 
add constraint foreign key(from_user_id) references user(idUser);

--item !

alter table item
add constraint  foreign key(idGame) references games(idGame);


--inventar !

alter table inventar 
add constraint foreign key(idGame) references games(idGame);

alter table inventar
add constraint foreign key(idItem) references item(idItem);

alter table inventar
add constraint foreign key(UserId) references user(idUser);


--comments !

alter table comments
add constraint foreign key(GamesId) references games(idGame);

alter table comments
add constraint foreign key(idUser) references user(idUser);


