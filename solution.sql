/* create the database */
create schema Intercollegiate_Database;
/* use the database */
use Intercollegiate_Database;
/* drop the database */
drop schema intercollegiate_database;

/* create table customer*/
create table customer(
custno varchar(8) not null,
custname varchar(30) not null ,
address varchar(30) not null,
internal varchar(1) not null,
contact varchar(30) not null,
phone int(7) not null,
city varchar(30) not null,
state varchar(2) not null,
zip int(5) not null,
CONSTRAINT PK_CUSTOMER PRIMARY KEY (custno)

);

/* create table Facility*/
CREATE TABLE Facility (
FacNo VARCHAR(8) NOT NULL,
 FacName VARCHAR(30) NOT NULL, CONSTRAINT 
 PK_FACILITY PRIMARY KEY (FacNo), 
CONSTRAINT Unique_FacName UNIQUE(FacName)
);

/* create table location*/
create table location(
locno varchar(8)  not null,
locname  varchar(30) not null,
facno varchar(8) not null,
CONSTRAINT FK_FACNO FOREIGN KEY (FacNo) REFERENCES FACILITY (FacNo),
CONSTRAINT PK_LOCATION PRIMARY KEY (locno)
);

/* create table ResourceTbl*/
create table ResourceTbl(
resno varchar(8) not null ,
resname varchar(30) not null,
rate decimal(10,2) not null ,
CONSTRAINT PK_RESOURCETBL PRIMARY KEY (resno),
CONSTRAINT RESOURCE_RATE CHECK (Rate > 0)
);

/* create table EventRequest*/
create table EventRequest (
eventno varchar(8) not null, 
dateheld date ,
datereq date ,
custno varchar(8) not null,
facNo VARCHAR(8) NOT NULL,
dateauth date,
status_ varchar(8)  not null ,
estcost decimal(10,2) not null,
estaudience int(8) ,
budno varchar(8), 
CONSTRAINT PK_EVENTREQUEST PRIMARY KEY (eventno),
CONSTRAINT FK_EVENTREQUEST1 FOREIGN KEY (custno) REFERENCES customer (custno) ,
CONSTRAINT FK_EVENTREQUEST2 FOREIGN KEY (FacNo) REFERENCES FACILITY (FacNo),
CONSTRAINT EVENT_REQUEST_STATUS CHECK (Status_ IN ('Approved', 'Pending', 'Denied')),
CONSTRAINT EVENT_REQUEST_AUDIENCE CHECK (EstAudience > 0)
);

/* create table employee*/
create table employee(
empno varchar(8)  not null, 
empname varchar(30) not null,
department varchar(30) not null,
email  varchar(30) not null,
phone  varchar(30) not null,
CONSTRAINT PK_EMPLOYEE PRIMARY KEY (empno)
);

/* create table eventplan*/
create table eventPlan(
planno varchar(8)  not null, 
eventno varchar(8) not null, 
workdate date,
notes varchar(30),
activity varchar(30),
empno varchar(8) , 
CONSTRAINT PK_EVENTPLAN PRIMARY KEY (planno),
CONSTRAINT FK_EVENTNO FOREIGN KEY (eventno) REFERENCES EventRequest (eventno) ,
CONSTRAINT FK_EMPNO FOREIGN KEY (empno) REFERENCES employee (empno)
);

/* create table EventPlanLine*/
create table EventPlanLine(
planno varchar(8)  not null, 
lineno int(10)  not null, 
timestart datetime,
timeend datetime,
numberfld int(10),
locno varchar(8)  not null, 
resno varchar(8)  not null, 
CONSTRAINT FK_EVENTPLANLINE FOREIGN KEY (planno) REFERENCES EventPlan(planno),
CONSTRAINT PK_EVENTPLANLINE PRIMARY KEY (planno,lineno),
CONSTRAINT FK_LOCNO FOREIGN KEY (locno) REFERENCES Location(locno),
CONSTRAINT FK_RESNO FOREIGN KEY (resno) REFERENCES Resourcetbl (resno),
CONSTRAINT TIME_START_LT_END CHECK (TimeStart < TimeEnd)

);


/* VISUALIZE THE TABLES AFTER INSERT THE VALUES FROM THE FILE: sql_insert_data.sql */

select * from intercollegiate_database.employee;
select * from intercollegiate_database.resourcetbl;
select * from intercollegiate_database.eventplanline;
select * from intercollegiate_database.eventplan;
select * from intercollegiate_database.eventrequest;