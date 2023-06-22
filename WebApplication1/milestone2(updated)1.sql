CREATE PROCEDURE createAllTables 
AS
BEGIN
CREATE TABLE SystemUser 
(
username VARCHAR(20) PRIMARY KEY,
password VARCHAR(20)
);
CREATE TABLE Fan 
(
national_ID VARCHAR(20) PRIMARY KEY ,
name VARCHAR(20),
birth_date DATE,
address VARCHAR(20),
phone_no VARCHAR(20),
status BIT DEFAULT '1',
username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser(username) 
);

CREATE TABLE Stadium
(
ID INT PRIMARY KEY IDENTITY,
name VARCHAR(20),
location VARCHAR(20),
capacity INT ,
status BIT DEFAULT '1'
);

CREATE TABLE StadiumManager 
(
ID INT PRIMARY KEY IDENTITY,
name VARCHAR(20),
stadium_ID INT FOREIGN KEY REFERENCES Stadium(ID),
username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser(username) 
);


CREATE TABLE Club 
(
club_ID INT PRIMARY KEY IDENTITY,
name VARCHAR(20),
location VARCHAR(20)
);


CREATE TABLE ClubRepresentative 
(
ID INT PRIMARY KEY IDENTITY,
name VARCHAR(20),
club_ID INT FOREIGN KEY REFERENCES Club(club_ID),
username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser(username) 
);

CREATE TABLE Match 
(
match_ID INT PRIMARY KEY IDENTITY,
start_time DATETIME,
end_time DATETIME ,
host_club_ID INT FOREIGN KEY REFERENCES Club(club_ID),
guest_club_ID INT FOREIGN KEY REFERENCES Club(club_ID),
stadium_ID INT FOREIGN KEY REFERENCES Stadium(ID) 
);


CREATE TABLE Ticket 
(
ID INT PRIMARY KEY IDENTITY,
status BIT DEFAULT '1' ,
match_ID INT FOREIGN KEY REFERENCES Match(match_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE TicketBuyingTransactions 
(
fan_national_ID VARCHAR(20) FOREIGN KEY REFERENCES Fan(national_ID),
ticket_ID INT FOREIGN KEY REFERENCES Ticket(ID) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE HostRequest 
(
ID INT PRIMARY KEY IDENTITY,
representative_ID INT FOREIGN KEY REFERENCES ClubRepresentative(ID) ON UPDATE CASCADE ON DELETE SET NULL,
manager_ID INT FOREIGN KEY REFERENCES StadiumManager(ID) ON UPDATE CASCADE ON DELETE SET NULL,
match_ID INT FOREIGN KEY REFERENCES Match(match_ID) ON UPDATE CASCADE ON DELETE SET NULL, 
status VARCHAR(20) NOT NULL CHECK ( status IN ('unhandled' ,'accepted','rejected')) DEFAULT 'unhandled'  
);

CREATE TABLE SportsAssociationManager 
(
ID INT PRIMARY KEY IDENTITY,
name VARCHAR(20),
username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser(username) 
);

CREATE TABLE SystemAdmin
(
ID INT PRIMARY KEY IDENTITY,
name VARCHAR(20),
username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser(username) 
);
END
select * from systemUser
GO;

EXEC createAllTables
INSERT INTO SystemUser VALUES ('muhammed' , '123')
INSERT INTO SystemAdmin VALUES ('muhammed hesham' , 'muhammed')

GO;

select * from club

CREATE PROCEDURE dropAllTables 
AS
BEGIN
DROP TABLE SystemAdmin;
DROP TABLE SportsAssociationManager;
DROP TABLE HostRequest;
DROP TABLE TicketBuyingTransactions;
DROP TABLE Ticket;
DROP TABLE Match;
DROP TABLE ClubRepresentative;
DROP TABLE Club;
DROP TABLE StadiumManager;
DROP TABLE Stadium;
DROP TABLE Fan;
DROP TABLE SystemUser;
END
GO;



CREATE PROCEDURE dropAllProceduresFunctionsViews 
AS
BEGIN
drop procedure createAllTables;
drop procedure dropAllTables;
drop procedure clearAllTables;
drop procedure addAssociationManager;
drop procedure addNewMatch;
drop procedure deleteMatch;
drop procedure deleteMatchesOnStadium;
drop procedure addClub; 
drop procedure addTicket;
drop procedure deleteClub;
drop procedure addStadium;
drop procedure deleteStadium;
drop procedure blockFan;
drop procedure unblockFan; 
drop procedure addRepresentative;
drop procedure addHostRequest;
drop procedure addStadiumManager; 
drop procedure acceptRequest;
drop procedure rejectRequest;
drop procedure addFan;
drop procedure purchaseTicket;
drop procedure updateMatchHost; 
drop procedure deleteMatchesOnStadium;

drop view allAssocManagers;
drop view allClubRepresentatives;
drop view allStadiumManagers;
drop view allFans;  
drop view allMatches; 
drop view allTickets;
drop view allCLubs;
drop view allStadiums; 
drop view allRequests;
drop view clubsWithNoMatches;
drop view matchesPerTeam;
drop view clubsNeverMatched;

drop function viewAvailableStadiumsOn;
drop function allUnassignedMatches;
drop function allPendingRequests;
drop function upcomingMatchesOfClub;
drop function availableMatchesToAttend;
drop function clubsNeverPlayed;
drop function matchWithHighestAttendance;
drop function matchesRankedByAttendance;
drop function requestsFromClub;
END

GO;

CREATE PROCEDURE clearAllTables 
AS
BEGIN
DELETE FROM SystemAdmin;
DELETE FROM SportsAssociationManager;
DELETE FROM HostRequest;
DELETE FROM TicketBuyingTransactions;
DELETE FROM Ticket;
DELETE FROM Match;
DELETE FROM ClubRepresentative;
DELETE FROM Club;
DELETE FROM StadiumManager;
DELETE FROM Stadium;
DELETE FROM Fan;
DELETE FROM SystemUser;
END
GO;

CREATE VIEW allAssocManagers
AS

SELECT s.username , m.password ,  s.name
FROM SportsAssociationManager s , SystemUser m
Where s.username=m.username
GO;


CREATE VIEW allClubRepresentatives
AS
SELECT r.username , u.password ,r.name AS 'representative name',  c.name AS 'club name'
FROM ClubRepresentative r , Club c , SystemUser u
where r.club_ID = c.club_ID AND r.username=u.username
GO;


CREATE VIEW allStadiumManagers
AS
SELECT  m.username , u.password , m.name AS 'manager name' , s.name AS 'stadium name' 
FROM Stadium s , StadiumManager m , SystemUser u
where s.ID = m.stadium_ID AND m.username=u.username
GO;


CREATE VIEW allFans
AS
SELECT f.username , m.password , f.name , f.national_ID  , f.birth_date , f.status 
FROM Fan f , SystemUser m
Where f.username=m.username
GO;


CREATE VIEW allCLubs
AS 
SELECT name, location
FROM Club 
GO;

CREATE VIEW allStadiums 
AS
SELECT name, location, capacity, status 
FROM Stadium 
GO;

CREATE VIEW allRequests
AS
SELECT r.username AS 'club representative' , m.username AS 'stadium manager', h.status AS 'request status' 
FROM HostRequest h , StadiumManager m, ClubRepresentative r 
WHERE h.representative_ID = r.ID AND h.manager_ID = m.ID 
GO;

CREATE VIEW  allMatches
AS
SELECT c1.name AS 'host_club' , c2.name AS 'guest_club' , m.start_time , m.end_time
FROM Club c1, Club c2, Match m
WHERE m.host_club_ID = c1.club_ID AND m.guest_club_ID = c2.club_ID 
GO;

CREATE VIEW allTickets
AS
SELECT c1.name AS 'host club' , c2.name AS 'guest club' , s.name AS 'stadium' , m.start_time AS 'start time'
FROM Club c1, Club c2, Stadium s, Match m
WHERE m.host_club_ID = c1.club_ID AND  m.guest_club_ID = c2.club_ID AND m.stadium_ID = s.ID
GO;



CREATE PROCEDURE purchaseTicket 
@nID VARCHAR(20),
@hostname VARCHAR(20),
@guestname VARCHAR(20),
@starttime DATETIME

AS
BEGIN
DECLARE @ticketID INT 
DECLARE @host_ID INT 
DECLARE @guest_ID INT 

SELECT @host_ID = c1.club_ID 
FROM Club c1 
WHERE c1.name = @hostname

SELECT @guest_ID = c2.club_ID 
FROM Club c2 
WHERE c2.name = @guestname

SELECT @ticketID = t.ID 
FROM Ticket t , Match m 
WHERE t.match_ID = m.match_ID
AND m.host_club_ID = @host_ID
AND m.guest_club_ID = @guest_ID 
AND m.start_time = @starttime
AND t.status = 1


IF (SELECT status FROM Fan WHERE national_ID = @nID) = 1 AND (@ticketID is NOT NULL)
	BEGIN
	INSERT INTO TicketBuyingTransactions VALUES (@nID , @ticketID);
	UPDATE Ticket SET Ticket.status=0  WHERE Ticket.ID = @ticketID
	END
ELSE 
	PRINT('you Cannot buy this ticket')
END


GO;



CREATE PROCEDURE addStadium 
@name VARCHAR(20),
@location VARCHAR(20),
@capacity INT
AS
BEGIN
INSERT INTO Stadium 
VALUES (@name, @location, @capacity, 1);
END
GO;




CREATE PROCEDURE deleteStadium
@name VARCHAR(20)
AS
BEGIN
DECLARE @stadium_ID INT
SELECT @stadium_ID = s.ID 
FROM Stadium s 
WHERE s.name = @name

DECLARE @manager_ID INT 
SELECT @manager_ID = s1.ID
FROM StadiumManager s1 JOIN Stadium ss ON s1.stadium_ID = ss.ID 
WHERE ss.name = @name

DECLARE @mUsername VARCHAR(20)
SELECT @mUsername = m.username
FROM StadiumManager m 
WHERE m.ID = @manager_ID


UPDATE Match  SET stadium_ID = NULL WHERE stadium_ID = @stadium_ID;
DELETE FROM Stadium WHERE Stadium.ID = @stadium_ID ;
DELETE FROM StadiumManager WHERE StadiumManager.ID = @manager_ID; 
DELETE FROM SystemUser WHERE username = @mUsername;
END

GO;

CREATE PROCEDURE blockFan 
@national_ID VARCHAR(20)
AS
BEGIN
UPDATE Fan 
SET status = 0
WHERE Fan.national_ID = @national_ID;
END


GO;

CREATE PROCEDURE unblockFan 
@national_ID VARCHAR(20)
AS
BEGIN
UPDATE Fan 
SET status = 1
WHERE Fan.national_ID = @national_ID;
END


GO;


CREATE PROCEDURE addRepresentative
@name VARCHAR(20),
@name_of_club VARCHAR(20),
@username VARCHAR(20),
@password VARCHAR(20)
AS

BEGIN
DECLARE @club_ID INT
SELECT @club_ID = c.club_ID
FROM Club c
where c.name = @name_of_club 
INSERT INTO SystemUser 
VALUES (@username, @password)
INSERT INTO ClubRepresentative 
VALUES (@name,@club_ID,@username);

END

GO;


CREATE PROCEDURE addAssociationManager
@name VARCHAR(20),
@username VARCHAR(20),
@password VARCHAR(20)

AS
BEGIN
INSERT INTO SystemUser
VALUES ( @username , @password)

INSERT INTO SportsAssociationManager 
VALUES ( @name , @username);
END


GO;



CREATE PROCEDURE addClub
@clubName VARCHAR(20),
@clubLocation VARCHAR(20)

AS
BEGIN
INSERT INTO Club 
Values(@clubName , @clubLocation)
END

GO;



CREATE PROCEDURE deleteClub
@clubName VARCHAR(20)
AS

BEGIN
DECLARE @club_ID INT 
DECLARE @rUsername VARCHAR(20)

SELECT @club_ID = c1.club_ID 
FROM Club c1 
WHERE c1.name = @clubName

SELECT @rUsername = r.username 
FROM ClubRepresentative r 
WHERE r.club_ID = @club_ID

DELETE FROM ClubRepresentative
WHERE ClubRepresentative.club_ID = @club_ID

DELETE FROM SystemUser 
WHERE SystemUser.username = @rUsername

/*DELETE FROM Match 
WHERE Match.host_club_ID = @club_ID OR Match.guest_club_ID = @club_ID */

UPDATE Match SET host_club_ID = NULL WHERE Match.host_club_ID = @club_ID
UPDATE Match SET guest_club_ID = NULL WHERE Match.guest_club_ID = @club_ID

DELETE FROM Club 
Where Club.club_ID = @club_ID

END


GO;



CREATE FUNCTION upcomingMatchesOfClub
(@club_name VARCHAR(20))
RETURNS TABLE
AS
RETURN(
SELECT c1.name AS 'club name' ,c2.name AS 'competing_club_name' , m.start_time AS 'start time', s.name AS 'stadium name'
FROM Match m LEFT OUTER JOIN Stadium s ON m.stadium_ID=s.ID
			 INNER JOIN Club c1 ON m.host_club_ID=c1.club_ID OR m.guest_club_ID=c1.club_ID
			 INNER JOIN Club c2 ON m.guest_club_ID=c2.club_ID OR m.host_club_ID=c2.club_ID
WHERE (host_club_ID IN (SELECT club_ID FROM Club WHERE name=@club_name)
	   OR guest_club_ID IN (SELECT club_ID FROM Club WHERE name=@club_name))
       AND m.start_time>CURRENT_TIMESTAMP
	   AND C1.name<>c2.name 
	   AND c1.name=@club_name
)
GO;


CREATE PROCEDURE availableMatchesToAttend
(@date DATETIME)
AS
BEGIN
SELECT c.name AS 'HOST', c1.name AS 'GUEST' , st.name AS 'STAD NAME' , st.location AS 'STAD LOCATION' , ma.start_time AS 'START TIME'
FROM Club c , Club c1 , Match ma ,Stadium st
WHERE ma.start_time >= @date  AND c.club_ID=ma.host_club_ID AND c1.club_ID=ma.guest_club_ID AND st.ID=ma.stadium_ID
AND EXISTS (SELECT * FROM Ticket t WHERE t.match_ID=ma.match_ID AND t.status=1)
END


GO;


CREATE FUNCTION allPendingRequests
(@username varchar(20))
RETURNS TABLE
AS

RETURN 
(
SELECT cr.name AS 'representative' , c.name AS 'guest club' , m.start_time
FROM StadiumManager sm , HostRequest hr , ClubRepresentative cr,  Club c , Match m 
WHERE sm.username = @username 
  AND sm.ID = hr.manager_ID
  AND hr.representative_ID = cr.ID
  AND hr.match_ID = m.match_ID 
  AND m.guest_club_ID = c.club_ID
  AND hr.status = 'unhandled'
)

GO;

CREATE PROCEDURE addTicket
@name_host_club VARCHAR(20),
@name_guest_club VARCHAR(20),
@start_time DATETIME

AS
BEGIN
DECLARE @host_ID INT 
SELECT @host_ID = c1.club_ID 
FROM Club c1 
WHERE c1.name = @name_host_club

DECLARE @guest_ID INT 
SELECT @guest_ID = c2.club_ID 
FROM Club c2 
WHERE c2.name = @name_guest_club

DECLARE @match_ID INT 
SELECT @match_ID = m.match_ID
FROM Match m 
WHERE m.host_club_ID = @host_ID AND m.guest_club_ID =@guest_ID AND m.start_time = @start_time 

INSERT INTO Ticket
Values(1, @match_ID)
END


GO;

CREATE PROCEDURE acceptRequest
@usernameOfManager VARCHAR(20),
@hostname VARCHAR(20),
@gusetname VARCHAR(20),
@starttime DATETIME
AS
BEGIN

DECLARE @matchID INT
DECLARE @stadiumID INT
DECLARE @i INT = 0

SELECT @matchID = match_ID 
FROM Match m , Club c1 , Club c2
WHERE m.host_club_ID = c1.club_ID 
  AND m.guest_club_ID = c2.club_ID
  AND c1.name = @hostname
  AND c2.name = @gusetname
  AND m.start_time = @starttime

SELECT @stadiumID = stadium_ID 
FROM StadiumManager 
WHERE username = @usernameOfManager

UPDATE HostRequest 
SET status = 'accepted' 
WHERE match_ID = @matchID

UPDATE Match 
SET stadium_ID = @stadiumID
WHERE match_ID = @matchID

WHILE @i < (SELECT capacity FROM Stadium WHERE ID = @stadiumID)
	BEGIN
		EXEC addTicket @hostname, @gusetname, @starttime
		SET @i+=1
	END

END

GO;


CREATE PROCEDURE rejectRequest
@usernameOfManager VARCHAR(20),
@hostname VARCHAR(20),
@gusetname VARCHAR(20),
@starttime DATETIME
AS
BEGIN

DECLARE @matchID INT
DECLARE @stadiumID INT

SELECT @matchID = match_ID 
FROM Match m , Club c1 , Club c2
WHERE m.host_club_ID = c1.club_ID 
  AND m.guest_club_ID = c2.club_ID
  AND c1.name = @hostname
  AND c2.name = @gusetname
  AND m.start_time = @starttime

UPDATE Match 
SET stadium_ID = NULL
WHERE match_ID = @matchID

UPDATE HostRequest 
SET status = 'rejected' 
WHERE match_ID = @matchID
END

GO;



CREATE PROCEDURE addStadiumManager
@name VARCHAR(20),
@stadiumName VARCHAR(20) ,
@username VARCHAR(20),
@password VARCHAR(20) 

AS 
BEGIN
DECLARE @stadID INT 
SELECT @stadID = s.ID
FROM Stadium s 
WHERE s.name = @stadiumName

INSERT INTO SystemUser
VALUES ( @username , @password )

INSERT INTO StadiumManager
VALUES ( @name , @stadID , @username )
END
GO;



CREATE FUNCTION allUnassignedMatches
(@clubname VARCHAR(20))
RETURNS TABLE 
AS
RETURN 
(
SELECT c2.name , m.start_time 
FROM Club c1 ,Club c2 , Match m 
WHERE c1.name = @clubname
  AND c1.club_ID = m.host_club_ID
  AND c2.club_ID = m.guest_club_ID
  AND m.stadium_ID IS NULL
)

GO;


CREATE PROCEDURE addFan
(@Name varchar(20) ,@Username varchar(20),@pass varchar(20), @NatID VARCHAR(20) , @BirthDate DATETIME , @Add varchar(20) , @phoneNo VARCHAR(20) )
AS
BEGIN
INSERT INTO SystemUser
VALUES (@Username,@pass)

INSERT INTO Fan
VALUES (@NatID, @Name, @BirthDate, @Add ,@phoneNo ,1 , @Username)
END

GO;


CREATE PROCEDURE checkIfExistingUser 
@user VARCHAR(20),
@exists INT OUT
AS
BEGIN
IF EXISTS (SELECT username FROM SystemUser WHERE username = @user)
SET @exists = 1;
ELSE 
SET @exists = 0;
END


GO;

CREATE PROC login 
@user VARCHAR(20),
@pass  VARCHAR(20),
@exists BIT OUTPUT,
@type AS VARCHAR(25) OUTPUT
AS
BEGIN
IF EXISTS (SELECT username FROM SystemUser WHERE username = @user AND password=@pass)
BEGIN
	SET @exists = 1;
	IF EXISTS(SELECT username FROM Fan WHERE username=@user)
		SET @type = 'fan';
	ELSE IF EXISTS (SELECT username FROM SystemAdmin WHERE username=@user)
		SET @type = 'systemAdmin';
	ELSE IF EXISTS (SELECT username FROM StadiumManager WHERE username=@user)
		SET @type = 'stadiumManager';
	ELSE IF EXISTS (SELECT username FROM ClubRepresentative WHERE username=@user)
		SET @type = 'clubRepresentative';
	ELSE IF EXISTS (SELECT username FROM SportsAssociationManager WHERE username=@user)
		SET @type = 'associationManager';			
END
ELSE 
SET @exists = 0;

END

GO;

CREATE PROC viewStadInfo 
@username VARCHAR(20)

AS
BEGIN
SELECT s.ID , s.name , s.location , s.capacity , s.status
FROM StadiumManager m , Stadium s
WHERE m.stadium_ID = s.ID AND m.username=@username
END

go;

CREATE PROC allReqForManager
@username VARCHAR(20)
AS
BEGIN
SELECT r.name AS 'rname' , c1.name AS 'host' , c2.name AS 'guest' , m.start_time , m.end_time , hr.status
FROM ClubRepresentative r , Match m , Club c1 , Club c2 , HostRequest hr , StadiumManager sm
WHERE hr.manager_ID = sm.ID AND hr.representative_ID=r.ID AND m.host_club_ID = c1.club_ID AND m.guest_club_ID = c2.club_ID
AND m.match_ID = hr.match_ID AND r.club_ID = c1.club_ID AND sm.username = @username
END
go;

CREATE PROC clubInfo 
@username VARCHAR(20)
AS
BEGIN
SELECT c.name , c.location 
FROM Club c, ClubRepresentative r
WHERE c.club_ID = r.club_ID AND r.username = @username
END

go;

CREATE PROC comingMatches 
@username VARCHAR(20)
AS
BEGIN

SELECT t.host , t.guest , t.start_time , t.end_time , s.name AS 'stad name'  
FROM
(SELECT c1.name AS 'host' , c2.name AS 'guest' , m.start_time , m.end_time , m.stadium_ID
FROM ClubRepresentative r , Club c1 , Club c2 , Match m 
WHERE 
(r.club_ID = c2.club_ID or r.club_ID=c1.club_ID )
AND m.host_club_ID = c1.club_ID 
AND m.guest_club_ID = c2.club_ID 
AND r.username = @username
AND m.start_time>CURRENT_TIMESTAMP) t left outer join Stadium s on (s.ID = t.stadium_ID)
END

GO;


CREATE FUNCTION viewAvailableStadiumsOn
(@datetime DATETIME)
RETURNS TABLE 
AS 
RETURN
(
SELECT name , location , capacity 
FROM Stadium
EXCEPT
(
SELECT s1.name, s1.location, s1.capacity 
FROM Stadium s1 JOIN Match m ON (s1.ID=m.stadium_ID)
WHERE (@datetime BETWEEN start_time AND end_time) OR  s1.status = 0
)
)

GO;

CREATE PROC avStads 
@datetime DATETIME 
AS
BEGIN
SELECT * FROM dbo.viewAvailableStadiumsOn(@datetime)
END

GO;

CREATE PROCEDURE addHostRequest
@username VARCHAR(20),
@stadium_name VARCHAR(20),
@starttime DATETIME
AS
BEGIN

DECLARE @stad_ID INT 
DECLARE @club_ID  INT
DECLARE @rep_ID   INT
DECLARE @mang_ID  INT
DECLARE @match_ID INT

SELECT @club_ID = r.club_ID
FROM ClubRepresentative r
WHERE @username = r.username

SELECT @rep_ID = c1.ID
FROM ClubRepresentative c1
WHERE @club_ID = c1.club_ID

SELECT @stad_ID = s.ID
FROM Stadium s
WHERE @stadium_name = s.name

SELECT @mang_ID = s1.ID
FROM StadiumManager s1
Where @stad_ID = s1.stadium_ID

SELECT @match_ID = m.match_ID
FROM Match m 
WHERE @starttime = m.start_time

INSERT INTO HostRequest (representative_ID, manager_ID, match_ID, status)
VALUES (@rep_ID, @mang_ID, @match_ID,'unhandled')
END

GO;

CREATE PROCEDURE addNewMatch 
@name_host_club VARCHAR(20),
@name_guest_club VARCHAR(20),
@start_time DATETIME,
@end_time DATETIME

AS
BEGIN
DECLARE @host_ID INT 
SELECT @host_ID = c1.club_ID 
FROM Club c1 
WHERE c1.name = @name_host_club

DECLARE @guest_ID INT 
SELECT @guest_ID = c2.club_ID 
FROM Club c2 
WHERE c2.name = @name_guest_club

INSERT INTO Match(start_time , end_time , host_club_ID , guest_club_ID , stadium_ID)
VALUES(@start_time,@end_time, @host_ID, @guest_ID , NULL)
END

GO;

CREATE PROCEDURE deleteMatch
@name_host_club VARCHAR(20),
@name_guest_club VARCHAR(20),
@start_time DATETIME,
@end_time DATETIME

AS
BEGIN
DECLARE @host_ID INT 
SELECT @host_ID = c1.club_ID 
FROM Club c1 
WHERE c1.name = @name_host_club

DECLARE @guest_ID INT 
SELECT @guest_ID = c2.club_ID 
FROM Club c2 
WHERE c2.name = @name_guest_club

DECLARE @match_ID INT 
SELECT @match_ID = m.match_ID
FROM Match m 
WHERE m.host_club_ID = @host_ID AND m.guest_club_ID =@guest_ID AND m.start_time = @start_time AND m.end_time=@end_time

DELETE FROM Match 
WHERE Match.host_club_ID = @host_ID AND Match.guest_club_ID = @guest_ID
END

GO;


CREATE PROC allUpcomingMatches 
AS
BEGIN
select * from allMatches where start_time > CURRENT_TIMESTAMP
END

GO;

CREATE PROC alreadyPlayedMatches
AS
BEGIN
select * from allMatches where start_time < CURRENT_TIMESTAMP 
END

GO;


CREATE PROC clubsNeverMatched
AS 
BEGIN
SELECT t.first_Club_name , t.second_club_name
FROM
(
SELECT c1.name AS 'first_Club_name' , c1.club_ID AS 'first_club_id' , c2.name AS 'second_club_name',  c2.club_ID AS 'second_club_id'
FROM club c1 , club c2
WHERE c1.name <> c2.name AND c1.club_ID <= c2.club_ID
) t 
LEFT OUTER JOIN Match m ON (t.first_club_id = m.host_club_ID AND t.second_club_id = m.guest_club_ID) OR (t.first_club_id = m.guest_club_ID AND t.second_club_id = m.host_club_ID)
WHERE (m.host_club_ID IS NULL AND m.guest_club_ID IS NULL)
END

GO;


CREATE PROC existingStadium 
@stadium VARCHAR(20),
@exists BIT OUTPUT
AS
IF EXISTS (SELECT name FROM Stadium Where name=@stadium)
	SET @exists = 1;
ELSE
	SET @exists = 0;


GO;

CREATE PROC existingClub 
@club VARCHAR(20),
@exists BIT OUTPUT
AS
IF EXISTS (SELECT name FROM Club Where name=@club)
	SET @exists = 1;
ELSE
	SET @exists = 0;

GO;

CREATE PROC existingNatID 
@natID VARCHAR(20),
@exists BIT OUTPUT
AS
BEGIN
IF EXISTS (SELECT national_ID FROM Fan Where national_ID=@natID)
	SET @exists = 1;
ELSE
	SET @exists = 0;
END
GO;




