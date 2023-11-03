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
  ("Wesley", "f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3", "Rhiannon", "Salazar"),
  ("Wallace", "f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3","Jacob","Edwards"),
  ("Genevieve", "f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3","Felix","Crosby"),
  ("Wylie", "f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3","Bianca","Cameron"),
  ("Joelle", "f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3","Cooper","Wilkins"),
  ("Geoffrey", "f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3","Tanek","Santiago"),
  ("Darryl", "f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3","Whoopi","Rivas"),
  ("Zane", "f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3","Irene","Roberson"),
  ("Chastity", "f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3","Quintessa","Martin"),
  ("Philip", "f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3","Ivory","Snider");
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