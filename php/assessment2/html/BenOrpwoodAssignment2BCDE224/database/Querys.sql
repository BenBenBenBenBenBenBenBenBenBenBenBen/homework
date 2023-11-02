-- Insert/Add/ Update query 
Use freshcart;
INSERT INTO `Product` (`productName`,`productDescription`,`productImageLink`, `seller_username`)
VALUES ("pumpkin","a pumpkin","pumpkin", "Wesley");

-- Simple query (1-2 tables) 
SELECT username, firstName, lastName
	FROM user_tbl
		WHERE username="Wesley";

-- Complex query (>2 tables, joins, sort, one other functions)
SELECT u.username, p.productName FROM user_tbl u
	INNER JOIN product p
		ON u.username = p.seller_username
	WHERE u.username="Wesley"
    ORDER BY u.username;

-- Create a search query
SELECT productName, productDescription FROM product
WHERE (productName LIKE '%pumpkin%' OR productDescription LIKE '%pumpkin%');