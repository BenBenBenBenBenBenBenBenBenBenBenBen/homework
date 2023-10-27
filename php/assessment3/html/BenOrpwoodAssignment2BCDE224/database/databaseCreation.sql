CREATE DATABASE IF NOT EXISTS FreshCart;
USE FreshCart;

CREATE TABLE IF NOT EXISTS user_tbl(
	username varchar(20) Primary key NOT NULL,
    password varchar(20) NOT NULL,
	firstName varchar(20) NOT NULL,
    lastName varchar(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Product(
	productName varchar(20) NOT NULL,
	productDescription varchar(200) NOT NULL,
    productImageLink varchar(20) NOT NULL,
    seller_username varchar(20) NOT NULL,
    primary key (productName, productDescription),
    foreign key(seller_username) references user_tbl(username)
);


INSERT INTO `user_tbl` (`username`, `password`, `firstName`, `lastName`)
VALUES
  ("Wesley", "password", "Rhiannon", "Salazar"),
  ("Wallace", "password","Jacob","Edwards"),
  ("Genevieve", "password","Felix","Crosby"),
  ("Wylie", "password","Bianca","Cameron"),
  ("Joelle", "password","Cooper","Wilkins"),
  ("Geoffrey", "password","Tanek","Santiago"),
  ("Darryl", "password","Whoopi","Rivas"),
  ("Zane", "password","Irene","Roberson"),
  ("Chastity", "password","Quintessa","Martin"),
  ("Philip", "password","Ivory","Snider");
INSERT INTO `user_tbl` (`username`, `password`,`firstName`,`lastName`)
VALUES
  ("Brian", "password","Sean","Rosario"),
  ("Rashad", "password","Reed","Gentry"),
  ("Quamar", "password","Owen","Stein"),
  ("Venus", "password","Aretha","Perry"),
  ("Uta", "password","Brooke","Griffith"),
  ("Ignacia", "password","Tasha","Patrick"),
  ("Sylvester", "password","Mira","Rivers"),
  ("Ria", "password","Aquila","Hahn"),
  ("Emerald", "password","Hanae","Faulkner"),
  ("Adara", "password","Kieran","Lynch");