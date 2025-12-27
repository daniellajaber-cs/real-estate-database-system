Question 1
Retrieve each property�s ID, address, base price, and the name of its owner.

SELECT P.Property_ID, P.Address, P.Base_Price, O.Name AS Owner_Name
FROM Property AS P  JOIN Owner AS O 
ON P.Owner_ID=O.Owner_ID;


QuestioN 2 
Retrieve each property�s address, city, area name, and property type.

SELECT P.Property_ID ,P.Address, L.City, L.Area_Name,T.Type_Name
FROM Property AS P JOIN Location AS L
ON P.Location_ID=L.Location_ID
JOIN PropertyType AS T
ON P.Type_ID=T.Type_ID;


Question 3 
 List all properties with their sale price and sale date if sold.
SELECT P.Property_ID,P.Address,P.Status,S.Sale_Price,S.Sale_Date
FROM Property AS P LEFT JOIN Listing AS L 
ON P.Property_ID = L.Property_ID
LEFT JOIN Sale AS S
ON L.Listing_ID = S.Listing_ID;

Question 4 
Retrieve all listings along with their agent name.
SELECT A.Agent_ID , A.First_Name ,A.Last_Name,L.Listing_ID,L.Asking_Price
FROM Agent AS A 
RIGHT JOIN Listing AS L
ON A.Agent_ID=L.Agent_ID;


Question 5:
Count how many properties exist in each city.
SELECT L.City, COUNT (P.Property_ID) AS NumberOfProperties
FROM Property AS P JOIN Location AS L 
ON P.Location_ID=L.Location_ID 
GROUP BY L.City; 

Question 6
Retreve agents who have more than three active listings.

SELECT A.Agent_ID, A.First_Name, A.Last_Name, COUNT(L.Listing_ID) AS ActiveListings
FROM Agent AS A JOIN Listing AS L
ON A.Agent_ID = L.Agent_ID
WHERE L.Is_Active = 'Y'
GROUP BY A.Agent_ID, A.First_Name, A.Last_Name
HAVING COUNT(L.Listing_ID) < 3;


Question 7
List all listings with the property address and the owner name (through Listing ? Property ? Owner).

SELECT L.Listing_ID ,L.Asking_Price ,P.Address, O.Name AS Owner_Name 
FROM Listing AS L JOIN Property AS P 
ON L.Property_ID=P.Property_ID
JOIN Owner AS O 
ON P.Owner_ID=O.Owner_ID;

Question 8 
Show all offers with the buyer name and the city of the property, ordered by offer price from highest to lowest.
SELECT O.Offer_ID,B.Name AS Buyer_Name,L.Listing_ID,O.Offer_Price,LC.City
FROM Offer AS O JOIN Buyer AS B 
ON O.Buyer_ID = B.Buyer_ID
JOIN Listing AS L 
ON O.Listing_ID = L.Listing_ID
JOIN Property AS P  
ON L.Property_ID = P.Property_ID
JOIN Location AS LC
ON P.Location_ID = LC.Location_ID
ORDER BY O.Offer_Price DESC;

Question 9 
List all active listings with the property address and the agent�s name.
SELECT L.Listing_ID, P.Address,A.First_Name ,A.Last_Name
FROM Listing AS L JOIN Property AS P 
ON L.Property_ID=P.Property_ID
JOIN Agent AS A 
ON L.Agent_ID=A.Agent_ID 
WHERE L.Is_Active='Y';



Question 10
Display all payment records with the buyer name, sale ID, payment date, amount, and method.
SELECT Py.Sale_ID,B.Name AS Buyer_Name,Py.Payment_No,Py.Payment_Date,Py.Amount,Py.Method
FROM Payment AS Py JOIN Sale AS S 
ON Py.Sale_ID=S.Sale_ID
JOIN Buyer AS B 
ON S.Buyer_ID=B.Buyer_ID;



Question 11
Find buyers who have made at least one offer but do not have any accepted offer.
SELECT B.Buyer_ID, B.Name
FROM Buyer AS B
WHERE EXISTS
 ( SELECT *
  FROM Offer
  WHERE Buyer_ID = B.Buyer_ID )
AND NOT EXISTS
 ( SELECT *
FROM Offer
WHERE Buyer_ID = B.Buyer_ID
 AND Status = 'Accepted' );


Question 12
Find all agents who have at least one active listing, and show how many active listings each one has.
SELECT A.Agent_ID , A.First_Name ,A.Last_Name, COUNT (L.Listing_ID ) AS ActiveListing
FROM Agent AS A JOIN Listing AS L 
ON A.Agent_ID=L.Agent_ID
WHERE L.Is_Active='Y'
GROUP BY A.Agent_ID,A.First_Name,A.Last_Name
HAVING COUNT (L.Listing_ID ) >=1;


Question 13
Find the highest sale price and the buyer who purchased that property.
SELECT S.Sale_ID , S.Sale_Price,B.Name AS Buyer_Name
FROM Sale AS S JOIN Buyer AS B 
ON S.Buyer_ID=B.Buyer_ID
WHERE S.Sale_Price=(
SELECT MAX(Sale_Price)
FROM Sale
);

Question 14
List all properties whose base price is above the average base price of all properties.
SELECT P.Property_ID, P.Address, P.Base_Price
FROM Property AS P 
WHERE P.Base_Price>(
SELECT AVG(Base_Price)
FROM Property
);


Question 15
Show the total amount of payments made by each buyer, and order the buyers from the highest total paid to lowest . 
SELECT B.Buyer_ID,
 B.Name AS Buyer_Name, SUM(Pay.Amount) AS TotalPaid
FROM Payment AS Pay JOIN Sale AS S
ON Pay.Sale_ID = S.Sale_ID
JOIN Buyer AS B
ON S.Buyer_ID = B.Buyer_ID
GROUP BY B.Buyer_ID, B.Name
ORDER BY TotalPaid DESC;


