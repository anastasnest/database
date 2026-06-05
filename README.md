# database
Database Basics


# ER_model_Mail_order.png
Mail Order database has following requirements:

• The mail order company has employees, each identified by a unique employee number, first and last name, and ZIP code (postal code)

• Each customer of the company is identified by a unique customer number, first and last name, and ZIP code (postal code)

• Each part sold by the company is identified by a unique part number, a part name, price, and quantity in stock

• Each order placed by a customer is taken by an employee and is given a unique order number. Each order contains specified quantities of one or more parts. Each order has date of receipt as well as an expected ship date. The actual ship date is also recorded


# Relational_model_Mail_order.png
Relational model had to go through following steps:

•Identify keys (superkeys, keys, and candidate keys)

•Choose a primary key for each relation and mark it on the diagram

•Describe attribute data types and domains; Are there any restricted data types?

•Indicate foreign keys

•What types of constraints would you expect to check on those relations?

•Carry out data model normalization and get the data model to 3rd normal form.

1 Table - Order
Name - Data Type - Data Type Size

id - INT

Date_of_receipt - VARCHAR(n) - 30

Exp_ship_date - VARCHAR(n) - 30

Actual_ship_date - VARCHAR(n) - 30

Customer_id (FK)

Employee_id (FK)

___________

Key: id

Candidate key: superkey from date_of_receipt and customer_id. NB! In this case date_of_receipt should be specific to seconds.

Possible constraints: Date_of_receipt, Exp_ship_date, Actual_ship_date should be of the same format (like "HH:MM:SS DD-MM-YYYY")


2 Table - Employee
Name - Data Type - Data Type Size

id - INT
ZIP_code - INT
First_Name - VARCHAR(n) - 55
Last_Name - VARCHAR(n) - 55
___________
Key: id
Candidate key: none. Even superkey from all other attributes won't be sufficient. For example, two sisters were given the same name by parents (not forbiden by law) and they decided to live in same appartment to save money. In this case ZIP_code, First_Name and Last_Name have the same value.
Possible constraints: such ZIP code should exist.


3 Table - Customer
Name - Data Type - Data Type Size

id - INT
ZIP_code - INT
First_Name - VARCHAR(n) - 55
Last_Name - VARCHAR(n) - 55
___________
Key: id
Candidate key: none. Even superkey from all other attributes won't be sufficient. For example, two sisters were given the same name by parents (not forbiden by law) and they decided to live in same appartment to save money. In this case ZIP_code, First_Name and Last_Name have the same value.
Possible constraints: ZIP_code should be valid (Maybe some control through the databases of ZIP codes to check whether the company offers delivery to that place)


4 Table - Part
Name - Data Type - Data Type Size

id - INT
Name - VARCHAR(n) - 255
Price - FLOAT
Quantity_in_stock - INT
___________
Key: id
Candidate key: none. For example, there might be writen the model in Name. But the color isn't pointed out in the Name (if the same part is sold in different colors) and is only seen on a picture. Then these are different parts.
Possible constraints: Quantity_In_stock can't be negative.


5 Table - Order_Part
Name - Data Type - Data Type Size

Order_id (FK)
Part_id (FK)
Quantity_of_part - INT
___________
Superkey - Order_id, Part_id
Candidate key: none.
Possible constraints: Quantity_of_part can't be less than 1.


# Relational_database_Mail_order.sql
The Mail order database
•Insert data such that:
  oThere would be at least 5 customers.
  oThere would be at least 3 employees.
  oThere would be at least 10 different parts.
  oThere would be multiple orders for each of the customers, some of which would be handled by one employee, others by different employee(s).
  oEach of these orders should contain more than 1 part, some of which would have quantity greater than 1.
  oSome of the orders should have an actual shipping date set, others not.
•Query all orders in a specified time frame, returning the order number, customer name, number of ordered items and their total sum, as well as expected shipping date and actual shipping date (when the order has been shipped, or NULL when it has not)
•Select a single order and list both order header info (order number, date and time of the order, customer name) as well as all ordered items (part name, quantity and price).
•List all parts (their names) and how many times they have been included in orders (across all orders)


# MiniInsta_queries.sql
MiniInsta is a database created by our teacher. I cannot upload it here, so I'll add only queries I did.

1. Front Page – posts by people I follow. The “I” can be hardcoded, meaning that use a variable to specify the ID of the user which is considered to be “me”. Since one post can contain more than one media record, the query can either be created as a single query (thus duplicating the post information), or separate queries for general post information and list of media elements. In case of a single query, the resulting dataset should contain following columns:
o PostID
o Username,
o CreationTime (of the post)
o MediaTypeID
o MediaFileUrl
o NumberOfLikes

In case of separate data sets, these should contain columns like:

o PostID
o Username,
o CreationTime
o NumberOfLikes

and (for Post Media portion)

o PostID
o MediaTypeID
o MediaFileUrl

2. Profile page – Profile header + posts by that user
o Main query
▪ UserID
▪ Username
▪ Website
▪ Bio
▪ ProfileImageUrl,
▪ NumberOfPosts,
▪ NumberOfFollowers,
▪ NumberOfFollowedUsers

3. Posts by the user, in chronologically descending order. It is sufficient to return top 1 media file for each post
▪ PostID
▪ LocationName
▪ MediaType
▪ MediaFileUrl
• Post details page
o Main query
▪ PostID
▪ Username
▪ ProfileImageUrl
▪ LocationName
▪ Location
▪ NumberOfLikes
o Media files (in their natural order)
▪ PostMediaID
▪ MediaTypeID
▪ MediaFileUrl
o Comments in chronological order
▪ CommentID
▪ Comment
▪ CreationTime

4. Analytical values as a single data set (each number as a separate column):
oTotalNumberOfUsers
oTotalNumberOfPosts
oAvgNumberOfPostsPerUser
oMaxNumberOfPostsPerUser
oAvgNumberOfLikesPerPost
oMaxNumberOfLikesPerPost

5. Top 10 Users with most followers (in descending order of the number of followers)
oUserID
oUsername
oNumberOfFollowers
•Number of user registrations by date (will return as many rows as there are unique dates)
oDate (date only, not date and time)
oNumberOfRegistrations

6. User division by gender (should return 3 rows, one for each gender)
oGenderName
oNumberOfUsers
