CREATE DATABASE IF NOT EXISTS bookWorm; #Ok, this will be easy
USE bookWorm;
#DROP DATABASE bookWorm;
/* This table is the master holder of all user data. This will be used in conjunction with 
Customer, Employee, and Manager
*/
CREATE TABLE IF NOT EXISTS USERS (
userID INT NOT NULL,
firstName TEXT NOT NULL,
lastName TEXT NOT NULL,
streetAddress TEXT NOT NULL,
city TEXT NOT NULL,
state CHAR(2) NOT NULL,
zipCode INT NOT NULL,
CONSTRAINT PK_Users_userID PRIMARY KEY (userID));

# This is the first type of user that we can have. Not too much we need to expalin
CREATE TABLE IF NOT EXISTS Customer (
customerID INT NOT NULL,
userID INT NOT NULL,
libraryCardNo CHAR(10) NOT NULL,
fines DECIMAL(10,2) NOT NULL,
CONSTRAINT PK_Customer_customerID_userID PRIMARY KEY (customerID, userID),
CONSTRAINT FK_Customer_userID FOREIGN KEY (userID) REFERENCES Users (userID));

/*
This is just a log of our current managers. Nothing special
*/
CREATE TABLE IF NOT EXISTS Manager (
managerID INT NOT NULL,
userID INT NOT NULL,
ssn CHAR(9) NOT NULL,
title TEXT NOT NULL,
CONSTRAINT PK_Manager_userID_managerID PRIMARY KEY (managerID, userID),
CONSTRAINT FK_Manager_userID FOREIGN KEY (userID) REFERENCES Users (userID));

/*
This is just a log of of our current employees. ManagerID can be Null because a employee can be a manager
*/
CREATE TABLE IF NOT EXISTS Employee (
employeeID INT NOT NULL,
userID INT NOT NULL,
ssn CHAR(9) NOT NULL,
title TEXT NOT NULL,
managerID INT,
CONSTRAINT PK_Employee_userID_employeeID PRIMARY KEY (employeeID, userID),
CONSTRAINT FK_Employee_userID FOREIGN KEY (userID) REFERENCES Users (userID),
CONSTRAINT FK_Employee_managerID FOREIGN KEY (managerID) REFERENCES Manager (managerID));

/*
This is used so people cna make reservations. We keep track of what they want to reserve and their userID
*/
CREATE TABLE IF NOT EXISTS Reservation(
reservationID INT NOT NULL,
typeOfResv TEXT NOT NULL,
userID INT NOT NULL,
CONSTRAINT PK_Reservation_reservationID PRIMARY KEY (reservationID),
CONSTRAINT FK_Reservation_userID FOREIGN KEY (userID) REFERENCES Users (userID));

/*
This keeps track of some inventory information.
We like to keep track of who has it on hold at the moment and what the inventory item is named
*/
CREATE TABLE IF NOT EXISTS Inventory (
inventoryID INT NOT NULL,
name TEXT NOT NULL,
reservationID INT,
floorNum SMALLINT NOT NULL,
shelfNum INT NOT NULL,
mediaType VARCHAR(50) NOT NULL,
CONSTRAINT PK_Inventory_inventoryID PRIMARY KEY (inventoryID),
CONSTRAINT FK_Inventory_reservationID FOREIGN KEY (reservationID) REFERENCES Reservation (reservationID));

/*
This is so we can log all events that happen in the library.
For the purpose of this assignment, we log all inventory and check in/check out events
*/
CREATE TABLE IF NOT EXISTS Log (
logID INT NOT NULL,
logType TEXT NOT NULL,
descp TEXT NOT NULL,
inventoryID INT NOT NULL,
reservationID INT,
CONSTRAINT PK_Log_logID PRIMARY KEY (logID),
CONSTRAINT FK_Log_inventoryID FOREIGN KEY (inventoryID) REFERENCES Inventory (inventoryID),
CONSTRAINT FK_Log_reservationID FOREIGN KEY (reservationID) REFERENCES Reservation (reservationID));

/*
THis is a log of our rooms
We keep a record of where the room is in our DB
We also keep track of reservationID's so we know who currently has it booked
*/
CREATE TABLE IF NOT EXISTS Room (
roomID INT NOT NULL,
floor SMALLINT NOT NULL,
roomNum SMALLINT NOT NULL,
reservationID INT,
CONSTRAINT PK_Room_roomID PRIMARY KEY (roomID),
CONSTRAINT FK_Room_reservationID FOREIGN KEY (reservationID) REFERENCES Reservation (reservationID));

/*
This keeps track of what classes we offer
We store the room number here so we know which room its in
We dont store the floor because its in the Room table
*/
CREATE TABLE IF NOT EXISTS Class (
classID INT NOT NULL,
classDesc TEXT NOT NULL,
roomID INT NOT NULL,
reservationID INT,
CONSTRAINT PK_Class_classID PRIMARY KEY (classID),
CONSTRAINT FK_Class_reservationID FOREIGN KEY (reservationID) REFERENCES Reservation (reservationID),
CONSTRAINT FK_Class_roomID FOREIGN KEY (roomID) REFERENCES Room (roomID));

/*
This is just a log of the book. The name is stored in Inventory
*/
CREATE TABLE IF NOT EXISTS Book (
bookID INT NOT NULL,
inventoryID INT NOT NULL,
iSBN VARCHAR(13) NOT NULL,
CONSTRAINT PK_Book_bookID PRIMARY KEY (bookID),
CONSTRAINT FK_Book_inventoryID FOREIGN KEY (inventoryID) REFERENCES Inventory (inventoryID));

/*
This is just a log of the movie. The name is stored in Inventory
*/
CREATE TABLE IF NOT EXISTS Movie (
movieID INT NOT NULL,
inventoryID INT NOT NULL,
CONSTRAINT PK_Movie_movieID PRIMARY KEY (movieID),
CONSTRAINT FK_Movie_inventoryID FOREIGN KEY (inventoryID) REFERENCES Inventory (inventoryID));

CREATE TABLE IF NOT EXISTS BorrowStatus (
transactionID INT NOT NULL,
inventoryID INT NOT NULL,
checkIn CHAR(1) NOT NULL,
checkOut CHAR(1) NOT NULL,
todDate DATE NOT NULL,
userID INT NOT NULL,
CONSTRAINT PK_BorrowStatus_transactionID PRIMARY KEY (transactionID),
CONSTRAINT FK_BorrowStatus_inventoryID FOREIGN KEY (inventoryID) REFERENCES Inventory (InventoryID),
CONSTRAINT FK_BorrowStatus_userID FOREIGN KEY (userID) REFERENCES Users (userID));