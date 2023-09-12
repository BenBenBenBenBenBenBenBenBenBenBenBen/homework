-- ﻿drop database homes;
create database homes;
use homes;


CREATE TABLE Owner_tbl
(
OwnerNo	   smallint  PRIMARY KEY,
OName  	   varchar(20) ,
OPhone 	   varchar(10)	
) engine=innoDB;


CREATE TABLE  Agent
(
AgentNo 		smallint  PRIMARY KEY,
AgentName 		varchar(20),
AgentPhone		varchar(10),
TotalValueListed	decimal(9) 
) engine=innoDB;

CREATE TABLE Home 
(
HomeNo		smallint PRIMARY KEY,
HStreet		VarChar(20),
HSuburb		varchar(20),
HCity		varchar(20),
HBedrooms	smallint,
HBuilt		smallint,
HGovtValue	decimal(6),
OwnerNo 	smallint not null,
FOREIGN KEY  (OwnerNo) REFERENCES  Owner_tbl (OwnerNo)
) engine=innoDB;

CREATE TABLE  Listing
(
ListingNo	smallint auto_increment Primary key,
HomeNo		smallint NOT NULL,
AgentNo		smallint not null,
ListingDate	date not null,
SellingPrice	decimal(6) not null,
FOREIGN KEY  (HomeNo) REFERENCES Home (HomeNo),
FOREIGN KEY  (AgentNo) REFERENCES Agent (AgentNo)
) engine=innoDB;

/*Home History Table created*/
CREATE TABLE  HomeHistory
(
HomeNo Smallint AUTO_increment,
Changedate	Date,
PrevOwnerNo		smallint,
NewOwnerNo		smallint,
PRIMARY KEY(HomeNo, Changedate)
) engine=innoDB;

delimiter $$
/*
*********************************************************
Triggers
*/

-- Trigger 1
DELIMITER $$

CREATE TRIGGER Trigger1 AFTER INSERT ON Listing
FOR EACH ROW
BEGIN
    UPDATE Agent
    SET TotalValueListed = TotalValueListed + NEW.SellingPrice
    WHERE AgentNo = NEW.AgentNo;
END $$

DELIMITER ;


/*Create Procedure*/




delimiter ;


/*View 1*/

CREATE VIEW View1 AS
SELECT H.HomeNo, H.HStreet, H.HSuburb, H.HCity, L.SellingPrice, O.OName, A.AgentName
FROM Home H
JOIN Listing L ON H.HomeNo = L.HomeNo
JOIN Owner_tbl O ON H.OwnerNo = O.OwnerNo
JOIN Agent A ON L.AgentNo = A.AgentNo
ORDER BY A.AgentNo, L.SellingPrice;

/*
view2
*/
-- create view2 a

-- create view2 b

-- create view2 

CREATE VIEW View2 AS
SELECT H.HomeNo, H.HStreet, H.HSuburb, H.HCity, H.OwnerNo, L.SellingPrice, A.AgentNo
FROM Home H
JOIN Listing L ON H.HomeNo = L.HomeNo
JOIN Agent A ON L.AgentNo = A.AgentNo
WHERE H.HBedrooms = 3
AND L.SellingPrice > (
    SELECT AVG(SellingPrice)
    FROM Listing L2
    JOIN Home H2 ON L2.HomeNo = H2.HomeNo
    WHERE H2.HCity = H.HCity
)
ORDER BY H.HCity, L.SellingPrice;

-- create view 3 a
-- create view 3 
CREATE VIEW View3 AS
SELECT H.OwnerNo, O.OName, AVG(H.HGovtValue) AS averageGV
FROM Home H
JOIN Owner_tbl O ON H.OwnerNo = O.OwnerNo
GROUP BY H.OwnerNo, O.OName
HAVING COUNT(H.HomeNo) > 1
ORDER BY averageGV;

DELIMITER $$

CREATE PROCEDURE totalvalue(IN owner_id INT, OUT owner_name VARCHAR(20), OUT total_govt_value DECIMAL(9))
BEGIN
    -- Retrieve the owner's name
    SELECT OName INTO owner_name
    FROM Owner_tbl
    WHERE OwnerNo = owner_id;
    
    -- Calculate the total government value of homes owned by the owner
    SELECT IFNULL(SUM(HGovtValue), 0)
    INTO total_govt_value
    FROM Home
    WHERE OwnerNo = owner_id;
END $$

DELIMITER ;








insert into Agent values (300,'Dave', '1234-567', 0);
insert into Agent values (301,'Henry','2222-222',0);
insert into Agent values (302,'Ed', '3333-444',0);
insert into Agent values (303,'Anne', '5555-666',0);
insert into Agent values (304,'Valarie','2233-444',0);
insert into Agent values (305,'Fiona', '7777-668',0);
insert into Agent values (306,'Marama','5566-222',0);
insert into Agent values (307,'Wirimu','5566-222',0);
/*Owners name in Uppercase*/

insert into Owner_tbl values (200,UCASE('JOHN'),'9966-888');
insert into Owner_tbl values (201,UCASE('SCott'),'7700-555');
insert into Owner_tbl values (202,UCASE('JOe'),'8855-666');
insert into Owner_tbl values (203,UCASE('MICHAEL'), '5585-333');
insert into Owner_tbl values (204,UCASE('TonI'),'7575-999');
insert into Owner_tbl values (205,UCASE('JANE'), '6060-777');
insert into Owner_tbl values (206,UCASE('SUE'), '3355-677');
insert into Owner_tbl values (207,UCASE('AMY'), '4455-678');
insert into Owner_tbl values (208,UCASE('Julie'),'5775-765');

insert into Home values(100,'10 Colombo St','Cashmere','Christchurch', 3,1988,250000,204);
insert into Home values(101,'111 Centaurus Rd','Cashmere','Christchurch', 3,1948,200000,204);
insert into Home values(102,'55 Pages Rd','Aranui','Christchurch', 3,1950,150000,202);
insert into Home values(103,'222 Dyers Pass Rd','Cashmere','Christchurch', 3,1966,450000,201);
insert into Home values(104,'65 Wainoni Rd','Aranui','Christchurch', 3,1942,145000,202);
insert into Home values(105,'22 Wainoni Rd','Aranui','Christchurch', 1,1942,100000,202);
insert into Home values(106,'21 Wainoni Rd','Aranui','Christchurch', 2,1895,90000,202);

insert into Home values(107,'21 River Rd','Caversham','Dunedin', 4,1955,190000,206);
insert into Home values(108,'15 Queen St','Caversham','Dunedin', 3,1960,290000,207);
insert into Home values(109,'345 Princes Dr','Caversham','Dunedin', 5,1966,320000,206);
insert into Home values(110,'18 View Cresc','Caversham','Dunedin', 3,1990,280000,207);
insert into Home values(111,'10 Park Ave','Caversham','Dunedin', 3,1945,180000,207);
insert into Home values(112,'110 Hill Rd','Caversham','Dunedin', 4,1935,150000,205);

insert into Listing values(null,100,304,str_to_date('20-oct-2002', "%d-%b-%Y"),260000);
insert into Listing values(null,100,302,str_to_date('21-oct-2002', "%d-%b-%Y"),260000);
insert into Listing values(null,101,301,str_to_date('10-oct-2002', "%d-%b-%Y"),210000);
insert into Listing values(null,102,303,str_to_date('8-oct-2002', "%d-%b-%Y"),175000);
insert into Listing values(null,103,303,str_to_date('21-oct-2002', "%d-%b-%Y"),500000);
insert into Listing values(null,103,302,str_to_date('22-oct-2002', "%d-%b-%Y"),500000);
insert into Listing values(null,104,302,str_to_date('20-oct-2002', "%d-%b-%Y"),150000);
insert into Listing values(null,104,305,str_to_date('21-oct-2002', "%d-%b-%Y"),150000);
insert into Listing values(null,104,305,str_to_date('24-oct-2002', "%d-%b-%Y"),150000);
insert into Listing values(null,104,306,str_to_date('24-oct-2002', "%d-%b-%Y"),150000);

insert into Listing values(null,107,306,str_to_date('18-oct-2002', "%d-%b-%Y"),200000);
insert into Listing values(null,108,306,str_to_date('15-oct-2002', "%d-%b-%Y"),300000);
insert into Listing values(null,109,306,str_to_date('20-oct-2002', "%d-%b-%Y"),350000);
insert into Listing values(null,110,306,str_to_date('21-oct-2002', "%d-%b-%Y"),300000);
insert into Listing values(null,111,306,str_to_date('21-oct-2002', "%d-%b-%Y"),150000);
insert into Listing values(null,111,307,str_to_date('24-oct-2002', "%d-%b-%Y"),150000);

/*Test for Trigger home_au*/
delimiter ;
update home
set OwnerNo = 200
where HomeNo = 100;

/*Test for Trigger Listing_a1*/
insert into Listing values(null,104,300,str_to_date("24-oct-2002", "%d-%b-%Y"),300000);

/*Test for Trigger Listing_a1*/
delete from listing
where ListingNo = 17;

/*Testing the Procedure*/
CALL totalvalue(202,@ownername,@totalvalue);
SELECT @ownername, @totalvalue;