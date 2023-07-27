-- Create new schema as ecommerce
-- Import .csv file users_data into MySQL
-- (right click on ecommerce schema -> Table Data import Wizard -> Give path of the file -> Next -> choose options : Create a new table , select delete if exist -> next -> next)
use ecommerce;

-- 3. Run SQL command to see the structure of table
-- select count(*)	  from users_data;
desc users_data;


-- 4. Run SQL command to select first 100 rows of the database
select * from users_data limit 100;

-- 5. How many distinct values exist in table for field country and language 
select count(distinct(country)) Countries, count(distinct(language)) languages from users_data;


-- 6. Check whether male users are having maximum followers or female users.
select gender,sum(socialNbFollowers) from users_data group by gender; -- m 262458 f 77038


-- 7.(a) Total users who Uses Profile Picture in their Profile
select sum(hasProfilePicture = "True" ) from users_data;

-- 7.(b) Total users who Uses Application for Ecommerce platform
select sum(hasAnyApp = "True") from users_data; -- 26174

-- 7.(c) Total users Uses Android app
select sum(hasAndroidApp = "True") from users_data;-- 4819

-- 7.(d) Total users Uses ios app
select sum(hasIosApp = "True") from users_data;-- 21527
-- Total users who use both Android and i-os 
-- select sum(hasIosApp = "True" and hasAndroidApp ="True") from users_data;-- 172

-- 8. Calculate the total number of buyers for each country and 
-- sort the result in descending order of total number of buyers.
--  (Hint: consider only those users having at least 1 product bought.)

SELECT 
    COUNT(*) Buyers , country 
FROM
    users_data
WHERE
    productsBought >=1
GROUP BY country
ORDER BY Buyers DESC ;

-- SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));  -- uncomment if error code  1140 arises

-- 9. Calculate the total number of sellers for each country and 
-- sort the result in ascending order of total number of sellers.
--  (Hint: consider only those users having at least 1 product sold.)
SELECT 
    COUNT(*) Sellers , country
FROM
    users_data
WHERE
    productsSold >= 1
GROUP BY country
ORDER BY Sellers DESC;


-- 10 . Display name of top 10 countries having maximum products pass rate.
select country , productsPassRate from users_data order by productsPassRate desc limit 10;


-- 11. Calculate the number of users on an ecommerce platform for different 
-- language choices.
select language,count(*) number_of_users  from users_data GROUP BY language;



-- 12. Check the choice of female users about putting the product in a wishlist
--  or to like socially on an ecommerce platform. (Hint: use UNION to answer
--  this question.)
select sum(productsWished) as wishlist_products_to_total_liked, gender from users_data where gender = "F" 
union
select sum(socialProductsLiked), gender from users_data where gender = "F" ;



--  13. Check the choice of male users about being seller or buyer. (Hint: use UNION 
-- to solve this question.)
select count(gender) Sellers_to_buyers , gender from users_data where gender = "M" and productsSold >= 1
Union
select count(gender) , gender from users_data where gender = "M" and productsBought >= 1;



-- 14. Which country is having maximum number of buyers?

SELECT 
    country ,COUNT(*) Buyers  
FROM
    users_data
WHERE
    productsBought >= 1
GROUP BY country
ORDER BY Buyers DESC limit 1;

-- 15. List the name of 10 countries having zero number of sellers.
SELECT 
    country ,productsSold 
FROM
    users_data
where productsSold = 0
GROUP BY country limit 10;

-- 16. Display record of top 110 users who have used ecommerce 
-- platform recently.
SELECT 
    *
FROM
    users_data
ORDER BY daysSinceLastLogin
LIMIT 110;


-- 17. Calculate the number of female users those who have not 
-- logged in since last 100 days.
SELECT 
    count(*)
FROM
    users_data
WHERE
    daysSinceLastLogin > 100
        AND gender = 'F'; -- 70189
        

-- 18. Display the number of female users of each country at ecommerce platform.
SELECT 
    country, COUNT(*) Female_users
FROM
    users_data
where gender = 'F'
GROUP BY country
ORDER BY COUNT(country) DESC;


-- 19. Display the number of male users of each country at ecommerce platform.
SELECT 
    country, COUNT(country) Male_users
FROM
    users_data
where gender  = "M"
GROUP BY country
ORDER BY COUNT(country) DESC;



-- 20. Calculate the average number of products sold and bought 
-- on ecommerce platform by male users for each country
SELECT 
    country,
    AVG(productsSold) AvgProductsSoldbyMale,
    AVG(productsBought) AvgProductsBoughtbyMale
FROM
    users_data
WHERE
    gender = 'M'
GROUP BY country
ORDER BY AVG(productsSold) desc, AVG(productsBought);

