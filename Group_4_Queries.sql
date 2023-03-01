USE bookWorm;
#DROP DATABASE bookWorm;
/*
Question 1
What state do our customers mainly come from?
*/
SELECT state, COUNT(userID) FROM Users GROUP BY state ORDER BY COUNT(userID) DESC LIMIT 1;
/*
Question 2
What item does User# 1 have on reservation right now?
*/
SELECT Users.userID, name AS NameOfItem FROM Reservation LEFT JOIN Users
 ON Reservation.userID = Users.userID LEFT JOIN Inventory ON Reservation.reservationID = Inventory.reservationID
 LIMIT 1;
/*
Question 3
What room and floor will ClassID 29 be held in? 
*/
SELECT floor AS floorNumebr, roomNum AS RoomNumber FROM Class LEFT JOIN Room on Class.roomID = Room.roomID WHERE
 classID = 29;
/*
Question 4
What is our earliest check out ?
*/
SELECT todDate FROM BorrowStatus WHERE checkOut = 1 ORDER BY todDate ASC LIMIT 1;
/*
Question 5
What is our latest check in and what was the name of the customer?
*/
SELECT todDate, firstName, lastname FROM BorrowStatus LEFT JOIN Users ON Users.userID = BorrowStatus.userID 
WHERE checkIn = 1 ORDER BY todDate DESC LIMIT 1;
/*
Question 6
How many books do we have overall?
*/
SELECT COUNT(bookID) FROM Book;
/*
Question 7
How many check ins are there overall?
*/
SELECT COUNT(transactionID) FROM BorrowStatus WHERE checkIn = 1;
/*
Question 8
What’s the ISBN of BorrowStatusID 1?
*/
SELECT ISBN from BorrowStatus LEFT JOIN Inventory ON BorrowStatus.inventoryID = Inventory.inventoryID LEFT
 JOIN Book ON Inventory.inventoryID = Book.inventoryID WHERE transactionID = 1;
/*
Question 9
What is the name of our first item added into the database?
*/
SELECT name FROM Inventory ORDER BY inventoryID LIMIT 1;
/*
Question 10
What City and State are 10 of our customers from?
*/
SELECT city, state FROM Customer LEFT JOIN Users ON Users.userID = Customer.userID ORDER BY rand() LIMIT 10;