CREATE DATABASE EducationMediaAppDB;
USE EducationMediaAppDB;

  CREATE TABLE tblstates
(
	StateId int identity primary key,
	StateName varchar(50) unique not null,
	Flag int default 1,
	InsertedAt datetime,
	UpdatedAt datetime,
	DeletedAt datetime,
	RestoredAt datetime

)
DROP PROCEDURE IF EXISTS sp_tblStates;
GO

CREATE PROCEDURE sp_tblstates
(
	@Action varchar(10),
	@StateId int=null,
	@StateName varchar(50)=null
)
as
begin
	if(@Action='Insert')
		insert into tblstates(StateName,Flag,InsertedAt) values(@StateName,0,getdate());
	if(@Action='Update')
		update tblstates set  StateName=@StateName , UpdatedAt=getdate() where StateId=@StateId;
	if(@Action='Delete')
		update tblstates set Flag=0 , DeletedAt=getdate() where StateId=@StateId;
	if(@Action='Restore')
		update tblstates set Flag=1 , RestoredAt=getdate() where StateId=@StateId;

end;
DELETE FROM tblLocations;

DELETE FROM tblCities;
DELETE FROM tblStates;


DBCC CHECKIDENT ('tblStates', RESEED, 0);
DBCC CHECKIDENT ('tblCities', RESEED, 0);
DBCC CHECKIDENT ('tblLocations', RESEED, 0);




EXEC sp_tblStates @Action = 'INSERT', @stateName = 'Maharashtra';
EXEC sp_tblStates @Action = 'INSERT', @stateName = 'Karnataka';
EXEC sp_tblStates @Action = 'INSERT', @stateName = 'Tamil Nadu';
EXEC sp_tblStates @Action = 'INSERT', @stateName = 'Kerala';
EXEC sp_tblStates @Action = 'INSERT', @stateName = 'Gujarat';
EXEC sp_tblStates @Action = 'INSERT', @stateName = 'Rajasthan';
EXEC sp_tblStates @Action = 'INSERT', @stateName = 'Punjab';
EXEC sp_tblStates @Action = 'INSERT', @stateName = 'Haryana';
EXEC sp_tblStates @Action = 'INSERT', @stateName = 'Madhya Pradesh';
EXEC sp_tblStates @Action = 'INSERT', @stateName = 'Chhattisgarh';
EXEC sp_tblStates @Action = 'INSERT', @stateName = 'Odisha';
EXEC sp_tblStates @Action = 'INSERT', @stateName = 'West Bengal';
EXEC sp_tblStates @Action = 'INSERT', @stateName = 'Bihar';
EXEC sp_tblStates @Action = 'INSERT', @stateName = 'Jharkhand';
EXEC sp_tblStates @Action = 'INSERT', @stateName = 'Uttar Pradesh';
SELECT * FROM tblStates;

CREATE PROCEDURE  sp_fetch_tblstates(@StateId int =null)
as
begin
	if(@StateId is null)
		select StateId,StateName from tblstates where Flag=0;
	else
	select StateId,StateName from tblstates where Flag=0 and StateId=@StateId;
end;
EXEC sp_fetch_tblstates ;


  CREATE TABLE tblcities
(
	CityId int identity primary key,
	CityName varchar(50) unique not null,
	StateId int constraint fkstateid references tblstates(StateId),
    Flag int default 1,
	InsertedAt datetime,
	UpdatedAt datetime,
	DeletedAt datetime,
	RestoredAt datetime

)
CREATE PROCEDURE  sp_tblcities
(
	@Action varchar(10),
	@CityId int=null,
	@StateId int=null,
	@CityName varchar(50)=null
)
as
begin
	if(@Action='Insert')
		insert into tblcities(CityName,StateId,Flag,InsertedAt) values(@CityName,@StateId,0,getdate());
	if(@Action='Update')
		update tblcities set  CityName=@CityName , UpdatedAt=getdate() where CityId=@CityId;
	if(@Action='Delete')
		update tblcities set Flag=0 , DeletedAt=getdate() where CityId=@CityId;
	if(@Action='Restore')
		update tblcities set Flag=1 , RestoredAt=getdate() where CityId=@CityId;

end;


EXEC sp_tblCities @Action='INSERT', @CityName='Mumbai', @StateId=1;
EXEC sp_tblCities @Action='INSERT', @CityName='Bengaluru', @StateId=2;
EXEC sp_tblCities @Action='INSERT', @CityName='Chennai', @StateId=3;
EXEC sp_tblCities @Action='INSERT', @CityName='Kochi', @StateId=4;
EXEC sp_tblCities @Action='INSERT', @CityName='Ahmedabad', @StateId=5;
EXEC sp_tblCities @Action='INSERT', @CityName='Jaipur', @StateId=6;
EXEC sp_tblCities @Action='INSERT', @CityName='Amritsar', @StateId=7;
EXEC sp_tblCities @Action='INSERT', @CityName='Gurugram', @StateId=8;
EXEC sp_tblCities @Action='INSERT', @CityName='Indore', @StateId=9;
EXEC sp_tblCities @Action='INSERT', @CityName='Raipur', @StateId=10;
EXEC sp_tblCities @Action='INSERT', @CityName='Bhubaneswar', @StateId=11;
EXEC sp_tblCities @Action='INSERT', @CityName='Kolkata', @StateId=12;
EXEC sp_tblCities @Action='INSERT', @CityName='Patna', @StateId=13;
EXEC sp_tblCities @Action='INSERT', @CityName='Ranchi', @StateId=14;
EXEC sp_tblCities @Action='INSERT', @CityName='Lucknow', @StateId=15;
SELECT * FROM tblCities;

CREATE PROCEDURE  sp_fetch_tblcities(@CityId int =null,@StateId int =null)
as
begin
	if(@StateId is null and @CityId is null)
		select CityId,CityName, s.StateId,StateName  from tblcities c join tblstates s on c.StateId=s.StateId where c.Flag=0 and s.Flag=0;

	if(@StateId is null and @CityId is not null)
		select CityId,CityName, s.StateId,StateName  from tblcities c join tblstates s on c.StateId=s.StateId 
		where c.Flag=0 and s.Flag=0 and CityId=@CityId;
	if(@StateId is not null and @CityId is  null)
		select CityId,CityName, s.StateId,StateName  from tblcities c join tblstates s on c.StateId=s.StateId 
		where c.Flag=0 and s.Flag=0 and s.StateId=@StateId;
 end;

 EXEC sp_fetch_tblcities ;

  CREATE TABLE tblLocations
(
    locationId       INT IDENTITY(1,1) PRIMARY KEY,
    locationName     VARCHAR(50),
    cityId           INT FOREIGN KEY REFERENCES tblCities(cityId),

    flag             BIT DEFAULT 1,
    insertedDate     DATETIME DEFAULT GETDATE(),
    updatedDate      DATETIME NULL,
    deleteDateTime   DATETIME NULL,
    restoreDateTime  DATETIME NULL
);
CREATE PROCEDURE sp_tblLocations
(
    @Action VARCHAR(10),
    @LocationId INT = NULL,
    @CityId INT = NULL,
    @LocationName VARCHAR(50) = NULL
)
AS
BEGIN
    IF(@Action = 'Insert')
        INSERT INTO tblLocations(locationName, cityId, flag, insertedDate)
        VALUES(@LocationName, @CityId, 1, GETDATE());

    IF(@Action = 'Update')
        UPDATE tblLocations
        SET locationName = @LocationName,
            updatedDate = GETDATE()
        WHERE locationId = @LocationId;

    IF(@Action = 'Delete')
        UPDATE tblLocations
        SET flag = 0,
            deleteDateTime = GETDATE()
        WHERE locationId = @LocationId;

    IF(@Action = 'Restore')
        UPDATE tblLocations
        SET flag = 1,
            restoreDateTime = GETDATE()
        WHERE locationId = @LocationId;
END;
EXEC sp_tblLocations @Action='INSERT', @LocationName='Andheri', @CityId=1;
EXEC sp_tblLocations @Action='INSERT', @LocationName='Whitefield', @CityId=2;
EXEC sp_tblLocations @Action='INSERT', @LocationName='T. Nagar', @CityId=3;
EXEC sp_tblLocations @Action='INSERT', @LocationName='Edappally', @CityId=4;
EXEC sp_tblLocations @Action='INSERT', @LocationName='Maninagar', @CityId=5;
EXEC sp_tblLocations @Action='INSERT', @LocationName='Malviya Nagar', @CityId=6;
EXEC sp_tblLocations @Action='INSERT', @LocationName='Golden Temple Road', @CityId=7;
EXEC sp_tblLocations @Action='INSERT', @LocationName='Cyber City', @CityId=8;
EXEC sp_tblLocations @Action='INSERT', @LocationName='Vijay Nagar', @CityId=9;
EXEC sp_tblLocations @Action='INSERT', @LocationName='Pandri Market', @CityId=10;
EXEC sp_tblLocations @Action='INSERT', @LocationName='Saheed Nagar', @CityId=11;
EXEC sp_tblLocations @Action='INSERT', @LocationName='Salt Lake', @CityId=12;
EXEC sp_tblLocations @Action='INSERT', @LocationName='Rajendra Nagar', @CityId=13;
EXEC sp_tblLocations @Action='INSERT', @LocationName='Kanke Road', @CityId=14;
EXEC sp_tblLocations @Action='INSERT', @LocationName='Hazratganj', @CityId=15;
SELECT * FROM tblLocations;

CREATE PROCEDURE sp_tblLocations_Fetch
(
    @LocationId INT = NULL,
    @CityId INT = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        l.locationId,
        l.locationName,
        c.cityId,
        c.cityName,
        s.stateId,
        s.stateName
    FROM tblLocations l
    JOIN tblCities c ON l.cityId = c.cityId
    JOIN tblStates s ON c.stateId = s.stateId
    WHERE 
        l.flag = 1 AND
        (@LocationId IS NULL OR l.locationId = @LocationId) AND
        (@CityId IS NULL OR c.cityId = @CityId)
    ORDER BY l.locationId;
END;
GO
EXEC sp_tblLocations_Fetch;

CREATE TABLE tblQualification
(
    qualificationId    INT IDENTITY(1,1) PRIMARY KEY,
     
    qualificationName  VARCHAR(30) NOT NULL,

    flag              BIT DEFAULT 1,
    insertedDate      DATETIME DEFAULT GETDATE(),
    updatedDate       DATETIME NULL,
    deleteDateTime    DATETIME NULL,
    restoreDateTime   DATETIME NULL,
);
Go
CREATE PROCEDURE sp_tblQualification
(
    @Action VARCHAR(10),
    @QualificationId INT = NULL,
    @QualificationName VARCHAR(50) = NULL
)
AS
BEGIN
    IF(@Action = 'Insert')
    BEGIN
        INSERT INTO tblQualification(qualificationName, flag, insertedDate)
        VALUES(@QualificationName, 1, GETDATE());
    END
    IF(@Action = 'Update')
    BEGIN
        UPDATE tblQualification
        SET qualificationName = @QualificationName,
    
            updatedDate = GETDATE()
        WHERE qualificationId = @QualificationId;
    END
    IF(@Action = 'Delete')
    BEGIN
        UPDATE tblQualification
        SET flag = 0, deleteDateTime = GETDATE()
        WHERE qualificationId = @QualificationId;
    END
    IF(@Action = 'Restore')
    BEGIN
        UPDATE tblQualification
        SET flag = 1, restoreDateTime = GETDATE()
        WHERE qualificationId = @QualificationId;
    END
END;

EXEC sp_tblQualification @Action='INSERT', @QualificationName='High School (10th)';
EXEC sp_tblQualification @Action='INSERT', @QualificationName='Higher Secondary (12th)';
EXEC sp_tblQualification @Action='INSERT', @QualificationName='Diploma in Engineering';
EXEC sp_tblQualification @Action='INSERT', @QualificationName='Bachelor of Arts (BA)';
EXEC sp_tblQualification @Action='INSERT', @QualificationName='Bachelor of Science (BSc)';
EXEC sp_tblQualification @Action='INSERT', @QualificationName='Bachelor of Commerce (BCom)';
EXEC sp_tblQualification @Action='INSERT', @QualificationName='Bachelor of Technology (BTech)';
EXEC sp_tblQualification @Action='INSERT', @QualificationName='Bachelor of Com App (BCA)';
EXEC sp_tblQualification @Action='INSERT', @QualificationName='Master of Arts (MA)';
EXEC sp_tblQualification @Action='INSERT', @QualificationName='Master of Science (MSc)';
EXEC sp_tblQualification @Action='INSERT', @QualificationName='Master of Commerce (MCom)';
EXEC sp_tblQualification @Action='INSERT', @QualificationName='Master of Technology (MTech)';
EXEC sp_tblQualification @Action='INSERT', @QualificationName='Master of Com App (MCA)';
EXEC sp_tblQualification @Action='INSERT', @QualificationName='PhD (Doctorate)';
EXEC sp_tblQualification @Action='INSERT', @QualificationName='Professional Certification ';

ALTER PROCEDURE sp_fetch_tblQualifications
(
    @QualificationId INT = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @QualificationId IS NULL
        SELECT * 
        FROM tblQualification 
        WHERE Flag = 1; 

    ELSE
        SELECT * 
        FROM tblQualification 
        WHERE Flag = 1 AND QualificationId = @QualificationId;
END;
GO

EXEC sp_fetch_tblQualifications;

 CREATE TABLE tblRoles
(
    roleId           INT IDENTITY(1,1) PRIMARY KEY,
    roleName         VARCHAR(50),

    flag             BIT DEFAULT 1,
    insertedDate     DATETIME DEFAULT GETDATE(),
    updatedDate      DATETIME NULL,
    deleteDateTime   DATETIME NULL,
    restoreDateTime  DATETIME NULL
);
CREATE PROCEDURE sp_tblRoles
(
    @Action            VARCHAR(20),
    @RoleId            INT=NULL,
    @RoleName          VARCHAR(25)
)
AS
BEGIN
    SET NOCOUNT ON;

    IF(@Action = 'INSERT')
    BEGIN
        INSERT INTO tblRoles(roleName, flag, insertedDate)
        VALUES (@RoleName,0,getdate());
    END
    IF(@Action = 'UPDATE')
    BEGIN
        UPDATE tblRoles
        SET roleName = @RoleName,
            updatedDate = GETDATE()
        WHERE roleId = @RoleId;
    END
    IF(@Action = 'DELETE')
    BEGIN
        UPDATE tblRoles
        SET flag = 0, deleteDateTime = GETDATE()
        WHERE roleId = @RoleId;
    END
    IF(@Action = 'RESTORE')
    BEGIN
        UPDATE tblRoles
        SET flag = 1,
            deleteDateTime = NULL,
            restoreDateTime = GETDATE()
        WHERE roleId = @RoleId;
    END

END;
GO

EXEC sp_tblRoles @Action='Insert', @RoleName='Admin';
EXEC sp_tblRoles @Action='Insert', @RoleName='User';
EXEC sp_tblRoles @Action='Insert', @RoleName='Moderator';
EXEC sp_tblRoles @Action='Insert', @RoleName='Guest';
EXEC sp_tblRoles @Action='Insert', @RoleName='Author';
EXEC sp_tblRoles @Action='Insert', @RoleName='Editor';
EXEC sp_tblRoles @Action='Insert', @RoleName='Viewer';
EXEC sp_tblRoles @Action='Insert', @RoleName='Manager';
EXEC sp_tblRoles @Action='Insert', @RoleName='Supervisor';
EXEC sp_tblRoles @Action='Insert', @RoleName='Operator';
EXEC sp_tblRoles @Action='Insert', @RoleName='Support';
EXEC sp_tblRoles @Action='Insert', @RoleName='Trainer';
EXEC sp_tblRoles @Action='Insert', @RoleName='Intern';
EXEC sp_tblRoles @Action='Insert', @RoleName='HR';
EXEC sp_tblRoles @Action='Insert', @RoleName='Finance';

CREATE Or Alter PROCEDURE sp_fetch_tblroles(@RoleId int=null)
as 
begin
if @RoleId is null
   select RoleId,RoleName from tblRoles where Flag=0

else
   select RoleId,RoleName from tblRoles where Flag=0 and RoleId=@RoleId
end;
Go
EXEC sp_fetch_tblroles;



ALTER TABLE tblUsers
ADD roleId INT;
UPDATE u
SET u.roleId = ur.roleId
FROM tblUsers u
JOIN tblUserRole ur ON u.userId = ur.userId;
ALTER TABLE tblUsers
ADD CONSTRAINT FK_Users_Roles
FOREIGN KEY (roleId) REFERENCES tblRoles(roleId);
SELECT 
    u.userId,
    u.userName,
    u.roleId,
    r.roleName
FROM tblUsers u
JOIN tblRoles r 
    ON u.roleId = r.roleId;





CREATE TABLE TblUsers
(
    userId            INT IDENTITY(1,1) PRIMARY KEY,
    userName          VARCHAR(50) NOT NULL,
    email             VARCHAR(70) NOT NULL,
    password          VARCHAR(50) NOT NULL,
    mobile            VARCHAR(20),
    gender            VARCHAR(10),
    birthDate         DATE,
    localAddress      VARCHAR(100),
    qualification     VARCHAR(50),
    location          VARCHAR(100),
    profileImage      VARCHAR(200),
    joiningDateTime   DATETIME,

    flag              BIT DEFAULT 1,
    insertedDate      DATETIME DEFAULT GETDATE(),
    updatedDate       DATETIME NULL,
    deleteDateTime    DATETIME NULL,
    restoreDateTime   DATETIME NULL
);

CREATE PROCEDURE sp_tblUsers_CRUD
(
    @Action            VARCHAR(20),
    @userId            INT = NULL,
    @userName          VARCHAR(50) = NULL,
    @Email             VARCHAR(100) = NULL,
    @Password          VARCHAR(50) = NULL,
    @Mobile            VARCHAR(20) = NULL,
    @Gender            VARCHAR(10) = NULL,
    @BirthDate         DATE = NULL,
    @LocalAddress      VARCHAR(100) = NULL,
    @Qualification     VARCHAR(50) = NULL,
    @Location          VARCHAR(100) = NULL,
    @ProfileImage      VARCHAR(200) = NULL,
    @JoiningDateTime   DATETIME = NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    IF(@Action = 'INSERT')
    BEGIN
        INSERT INTO tblUsers
        (
            userName, email, password, mobile, gender, birthDate,
            localAddress, qualification, location, profileImage, joiningDateTime
        )
        VALUES
        (
            @userName, @Email, @Password, @Mobile, @Gender, @BirthDate,
            @LocalAddress, @Qualification, @Location, @ProfileImage, @JoiningDateTime
        );
    END
    IF(@Action = 'UPDATE')
    BEGIN
        UPDATE tblUsers
        SET 
            userName = @userName,
            email = @Email,
            password = @Password,
            mobile = @Mobile,
            gender = @Gender,
            birthDate = @BirthDate,
            localAddress = @LocalAddress,
            qualification = @Qualification,
            location = @Location,
            profileImage = @ProfileImage,
            joiningDateTime = @JoiningDateTime,
            updatedDate = GETDATE()
        WHERE userId = @userId;
    END
    IF(@Action = 'DELETE')
    BEGIN
        UPDATE tblUsers
        SET flag = 0, deleteDateTime = GETDATE()
        WHERE userId = @userId;
    END
IF(@Action = 'RESTORE')
BEGIN
    UPDATE tblUsers
    SET flag = 1,
        deleteDateTime = NULL
    WHERE userId = @userId;
END
END;
Go
EXEC sp_tblUsers_CRUD @Action='Insert', @userName='Amit Sharma', @Email='amit@gmail.com', @Password='Pass@123', @Mobile='9876543101', @Gender='Male', @BirthDate='1990-01-15', @LocalAddress='Andheri, Mumbai', @Qualification='Bachelor of Commerce (BCom)', @Location='Andheri', @ProfileImage='amit.jpg';

EXEC sp_tblUsers_CRUD @Action='Insert', @userName='Priya Desai', @Email='priya@gmail.com', @Password='Pass@123', @Mobile='9876543102', @Gender='Female', @BirthDate='1992-03-20', @LocalAddress='Whitefield, Bengaluru', @Qualification='Bachelor of Science (BSc)', @Location='Whitefield', @ProfileImage='priya.jpg';

EXEC sp_tblUsers_CRUD @Action='Insert', @userName='Rohan Patil', @Email='rohan@gmail.com', @Password='Pass@123', @Mobile='9876543103', @Gender='Male', @BirthDate='1989-07-10', @LocalAddress='T. Nagar, Chennai', @Qualification='Bachelor of Arts (BA)', @Location='T. Nagar', @ProfileImage='rohan.jpg';

EXEC sp_tblUsers_CRUD @Action='Insert', @userName='Sneha Kulkarni', @Email='sneha@gmail.com', @Password='Pass@123', @Mobile='9876543104', @Gender='Female', @BirthDate='1991-12-05', @LocalAddress='Edappally, Kochi', @Qualification='Diploma in Engineering', @Location='Edappally', @ProfileImage='sneha.jpg';

EXEC sp_tblUsers_CRUD @Action='Insert', @userName='Suresh Gupta', @Email='suresh@gmail.com', @Password='Pass@123', @Mobile='9876543105', @Gender='Male', @BirthDate='1988-05-22', @LocalAddress='Maninagar, Ahmedabad', @Qualification='Bachelor of Technology (BTech)', @Location='Maninagar', @ProfileImage='suresh.jpg';

EXEC sp_tblUsers_CRUD @Action='Insert', @userName='Nikita Singh', @Email='nikita@gmail.com', @Password='Pass@123', @Mobile='9876543106', @Gender='Female', @BirthDate='1993-11-30', @LocalAddress='Malviya Nagar, Jaipur', @Qualification='Master of Arts (MA)', @Location='Malviya Nagar', @ProfileImage='nikita.jpg';

EXEC sp_tblUsers_CRUD @Action='Insert', @userName='Rajeev Kumar', @Email='rajeev@gmail.com', @Password='Pass@123', @Mobile='9876543107', @Gender='Male', @BirthDate='1990-09-18', @LocalAddress='Golden Temple Road, Amritsar', @Qualification='Master of Science (MSc)', @Location='Golden Temple Road', @ProfileImage='rajeev.jpg';

EXEC sp_tblUsers_CRUD @Action='Insert', @userName='Meera Nair', @Email='meera@gmail.com', @Password='Pass@123', @Mobile='9876543108', @Gender='Female', @BirthDate='1992-06-12', @LocalAddress='Cyber City, Gurugram', @Qualification='Master of Commerce (MCom)', @Location='Cyber City', @ProfileImage='meera.jpg';

EXEC sp_tblUsers_CRUD @Action='Insert', @userName='Deepak Verma', @Email='deepak@gmail.com', @Password='Pass@123', @Mobile='9876543109', @Gender='Male', @BirthDate='1987-04-25', @LocalAddress='Vijay Nagar, Indore', @Qualification='Master of Technology (MTech)', @Location='Vijay Nagar', @ProfileImage='deepak.jpg';

EXEC sp_tblUsers_CRUD @Action='Insert', @userName='Anjali Mehta', @Email='anjali@gmail.com', @Password='Pass@123', @Mobile='9876543110', @Gender='Female', @BirthDate='1991-08-17', @LocalAddress='Pandri Market, Raipur', @Qualification='Master of Computer Applications (MCA)', @Location='Pandri Market', @ProfileImage='anjali.jpg';

EXEC sp_tblUsers_CRUD @Action='Insert', @userName='Vikas Agarwal', @Email='vikas@gmail.com', @Password='Pass@123', @Mobile='9876543111', @Gender='Male', @BirthDate='1989-02-28', @LocalAddress='Saheed Nagar, Bhubaneswar', @Qualification='PhD (Doctorate)', @Location='Saheed Nagar', @ProfileImage='vikas.jpg';

EXEC sp_tblUsers_CRUD @Action='Insert', @userName='Ritika Jain', @Email='ritika@gmail.com', @Password='Pass@123', @Mobile='9876543112', @Gender='Female', @BirthDate='1993-03-14', @LocalAddress='Salt Lake, Kolkata', @Qualification='Professional Certification (AWS, Azure, etc.)', @Location='Salt Lake', @ProfileImage='ritika.jpg';

EXEC sp_tblUsers_CRUD @Action='Insert', @userName='Aditya Rao', @Email='aditya@gmail.com', @Password='Pass@123', @Mobile='9876543113', @Gender='Male', @BirthDate='1990-12-07', @LocalAddress='Rajendra Nagar, Patna', @Qualification='Bachelor of Arts (BA)', @Location='Rajendra Nagar', @ProfileImage='aditya.jpg';

EXEC sp_tblUsers_CRUD @Action='Insert', @userName='Pooja Kamat', @Email='pooja@gmail.com', @Password='Pass@123', @Mobile='9876543114', @Gender='Female', @BirthDate='1992-05-21', @LocalAddress='Kanke Road, Ranchi', @Qualification='Bachelor of Science (BSc)', @Location='Kanke Road', @ProfileImage='pooja.jpg';

EXEC sp_tblUsers_CRUD @Action='Insert', @userName='Harsh Shah', @Email='harsh@gmail.com', @Password='Pass@123', @Mobile='9876543115', @Gender='Male', @BirthDate='1988-10-30', @LocalAddress='Hazratganj, Lucknow', @Qualification='Diploma in Engineering', @Location='Hazratganj', @ProfileImage='harsh.jpg';

CREATE PROCEDURE sp_tblUsers_Fetch
(
    @UserId INT = NULL,
    @Qualification VARCHAR(30) = NULL,
    @Location VARCHAR(100) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT  
        u.userId,
        u.userName,
        u.gender,
        u.birthDate,
        u.email,
        u.mobile,
        u.qualification,
        u.location,
        u.localAddress,
        u.profileImage,
        u.password,
        u.joiningDateTime,
        u.flag,
        u.insertedDate,
        u.updatedDate,
        u.deleteDateTime,
        u.restoreDateTime
    FROM tblUsers u
    WHERE 
        (@UserId IS NULL OR u.userId = @UserId) AND
        (@Qualification IS NULL OR u.qualification = @Qualification) AND
        (@Location IS NULL OR u.location = @Location);
END;
GO
EXEC  sp_tblUsers_Fetch;

CREATE TABLE tblUserRole
(
    urId             INT IDENTITY(1,1) PRIMARY KEY,
    userId           INT FOREIGN KEY REFERENCES tblUsers(userId),
    roleId           INT FOREIGN KEY REFERENCES tblRoles(roleId),

    flag             BIT DEFAULT 1,
    insertedDate     DATETIME DEFAULT GETDATE(),
    updatedDate      DATETIME NULL,
    deleteDateTime   DATETIME NULL,
    restoreDateTime  DATETIME NULL
);

CREATE PROCEDURE sp_tblUserRole_CRUD
(
    @Action VARCHAR(20),
    @UrId INT = NULL,
    @UserId INT = NULL,
    @RoleId INT = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @Action = 'INSERT'
    BEGIN
        INSERT INTO tblUserRole (userId, roleId, flag, insertedDate)
        VALUES (@UserId, @RoleId, 1, GETDATE());
    END

    IF @Action = 'UPDATE'
    BEGIN
        UPDATE tblUserRole
        SET userId = @UserId,
            roleId = @RoleId,
            updatedDate = GETDATE()
        WHERE urId = @UrId;
    END

    IF @Action = 'DELETE'
    BEGIN
        UPDATE tblUserRole
        SET flag = 0,
            deleteDateTime = GETDATE()
        WHERE urId = @UrId;
    END

    IF @Action = 'RESTORE'
    BEGIN
        UPDATE tblUserRole
        SET flag = 1,
            deleteDateTime = NULL,
            restoreDateTime = GETDATE()
        WHERE urId = @UrId;
    END
END;
GO
EXEC sp_tblUserRole_CRUD @Action='Insert', @userId=1, @roleId=1;
EXEC sp_tblUserRole_CRUD @Action='Insert', @userId=2, @roleId=2;
EXEC sp_tblUserRole_CRUD @Action='Insert', @userId=3, @roleId=3;
EXEC sp_tblUserRole_CRUD @Action='Insert', @userId=4, @roleId=2;
EXEC sp_tblUserRole_CRUD @Action='Insert', @userId=5, @roleId=1;
EXEC sp_tblUserRole_CRUD @Action='Insert', @userId=6, @roleId=3;
EXEC sp_tblUserRole_CRUD @Action='Insert', @userId=7, @roleId=2;
EXEC sp_tblUserRole_CRUD @Action='Insert', @userId=8, @roleId=1;
EXEC sp_tblUserRole_CRUD @Action='Insert', @userId=9, @roleId=3;
EXEC sp_tblUserRole_CRUD @Action='Insert', @userId=10, @roleId=2;
EXEC sp_tblUserRole_CRUD @Action='Insert', @userId=11, @roleId=1;
EXEC sp_tblUserRole_CRUD @Action='Insert', @userId=12, @roleId=3;
EXEC sp_tblUserRole_CRUD @Action='Insert', @userId=13, @roleId=2;
EXEC sp_tblUserRole_CRUD @Action='Insert', @userId=14, @roleId=1;
EXEC sp_tblUserRole_CRUD @Action='Insert', @userId=15, @roleId=3;

CREATE PROCEDURE sp_tblUserRole_Fetch
(
    @UrId INT = NULL,      
    @UserId INT = NULL,     
    @RoleId INT = NULL    
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        ur.urId,
        ur.userId,
        u.userName,
        ur.roleId,
        r.roleName,
        ur.flag,
        ur.insertedDate,
        ur.updatedDate,
        ur.deleteDateTime,
        ur.restoreDateTime
    FROM tblUserRole ur
    JOIN tblUsers u ON ur.userId = u.userId
    JOIN tblRoles r ON ur.roleId = r.roleId
    WHERE 
        ur.flag = 1 AND                   
        (@UrId IS NULL OR ur.urId = @UrId) AND
        (@UserId IS NULL OR ur.userId = @UserId) AND
        (@RoleId IS NULL OR ur.roleId = @RoleId)
    ORDER BY ur.urId;
END;
GO
EXEC sp_tblUserRole_Fetch;

CREATE TABLE tblCategory
(
    categoryId       INT IDENTITY(1,1) PRIMARY KEY,
    categoryName     VARCHAR(25),

    flag             BIT DEFAULT 1,
    insertedDate     DATETIME DEFAULT GETDATE(),
    updatedDate      DATETIME NULL,
    deleteDateTime   DATETIME NULL,
    restoreDateTime  DATETIME NULL
);

CREATE OR ALTER PROCEDURE ps_tblCategory
(
    @Action          VARCHAR(20),
    @categoryId      INT = NULL,
    @categoryName    VARCHAR(25) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @Action = 'Insert'
    BEGIN
        INSERT INTO tblCategory (CategoryName, insertedDate)
        VALUES (@categoryName, GETDATE()); -- Flag defaults to 1
    END


    IF @Action = 'Update'
    BEGIN
        UPDATE tblCategory
        SET CategoryName = @categoryName,
            updatedDate = GETDATE()
        WHERE CategoryId = @categoryId;
    END

    IF @Action = 'Delete'
    BEGIN
        UPDATE tblCategory
        SET Flag = 0,
            deleteDateTime = GETDATE()
        WHERE CategoryId = @categoryId;
    END

 
    IF @Action = 'Restore'
    BEGIN
        UPDATE tblCategory
        SET Flag = 1,
            restoreDateTime = GETDATE()
        WHERE CategoryId = @categoryId;
    END
END;
GO


EXEC ps_tblCategory @Action='Insert', @CategoryName='Science';
EXEC ps_tblCategory @Action='Insert', @CategoryName='Mathematics';
EXEC ps_tblCategory @Action='Insert', @CategoryName='History';
EXEC ps_tblCategory @Action='Insert', @CategoryName='Geography';
EXEC ps_tblCategory @Action='Insert', @CategoryName='Technology';
EXEC ps_tblCategory  @Action='Insert', @CategoryName='Arts';
EXEC ps_tblCategory @Action='Insert', @CategoryName='Sports';
EXEC ps_tblCategory  @Action='Insert', @CategoryName='Economics';
EXEC ps_tblCategory  @Action='Insert', @CategoryName='Literature';
EXEC ps_tblCategory @Action='Insert', @CategoryName='Physics';
EXEC ps_tblCategory @Action='Insert', @CategoryName='Chemistry';
EXEC ps_tblCategory @Action='Insert', @CategoryName='Biology';
EXEC ps_tblCategory @Action='Insert', @CategoryName='Programming';
EXEC ps_tblCategory  @Action='Insert', @CategoryName='Music';
EXEC ps_tblCategory @Action='Insert', @CategoryName='Philosophy';

CREATE OR ALTER PROCEDURE sp_fetch_tblcategories
(
    @CategoryId INT = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @CategoryId IS NULL
        SELECT CategoryId, CategoryName
        FROM tblCategory
        WHERE Flag = 1;
    ELSE
        SELECT CategoryId, CategoryName
        FROM tblCategory
        WHERE Flag = 1 AND CategoryId = @CategoryId;
END;
GO

EXEC sp_fetch_tblcategories;

CREATE TABLE tblPosts
(
    postId           INT IDENTITY(1,1) PRIMARY KEY,
    userId           INT FOREIGN KEY REFERENCES tblUsers(userId),
    categoryId       INT FOREIGN KEY REFERENCES tblCategory(categoryId),
    postTitle        VARCHAR(50),
    postDescription  VARCHAR(MAX),

    flag              BIT DEFAULT 1,
    insertedDate      DATETIME DEFAULT GETDATE(),
    updatedDate       DATETIME NULL,
    deleteDateTime    DATETIME NULL,
    restoreDateTime   DATETIME NULL
);
CREATE or alter PROCEDURE ps_tblPosts_CRUD
(
    @Action            VARCHAR(20),
    @postId            INT = NULL,
    @userId            INT = NULL,
    @categoryId        INT = NULL,
    @postTitle         VARCHAR(50) = NULL,
    @postDescription   VARCHAR(MAX) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    
    IF(@Action = 'INSERT')
    BEGIN
        INSERT INTO tblPosts
        (
            userId, categoryId, postTitle, postDescription
        )
        VALUES
        (
            @userId, @categoryId, @postTitle, @postDescription
        );
    END

    IF(@Action = 'UPDATE')
    BEGIN
        UPDATE tblPosts
        SET 
            userId = @userId,
            categoryId = @categoryId,
            postTitle = @postTitle,
            postDescription = @postDescription,
            updatedDate = GETDATE()
        WHERE postId = @postId;
    END

    
    IF(@Action = 'DELETE')
    BEGIN
        UPDATE tblPosts
        SET 
            flag = 0,
            deleteDateTime = GETDATE()
        WHERE postId = @postId;
    END

    
    IF(@Action = 'RESTORE')
    BEGIN
        UPDATE tblPosts
        SET 
            flag = 1,
            deleteDateTime = NULL,
            restoreDateTime = GETDATE()
        WHERE postId = @postId;
    END

  
END;
GO

EXEC ps_tblPosts_CRUD @Action='Insert', @PostTitle='Introduction to Physics', @PostDescription='Basics of Physics for beginners', @CategoryId=31, @UserId=1;
EXEC ps_tblPosts_CRUD @Action='Insert', @PostTitle='Calculus Tricks', @PostDescription='Advanced tips for solving calculus problems', @CategoryId=32, @UserId=2;
EXEC ps_tblPosts_CRUD @Action='Insert', @PostTitle='History of India', @PostDescription='Major events in Indian history', @CategoryId=33, @UserId=3;
EXEC ps_tblPosts_CRUD @Action='Insert', @PostTitle='World Geography', @PostDescription='Learning countries and capitals', @CategoryId=34, @UserId=4;
EXEC ps_tblPosts_CRUD @Action='Insert', @PostTitle='Latest Tech Trends', @PostDescription='AI, IoT, and Blockchain updates', @CategoryId=35, @UserId=5;
EXEC ps_tblPosts_CRUD @Action='Insert', @PostTitle='Painting Techniques', @PostDescription='Watercolor and Acrylic methods', @CategoryId=36, @UserId=6;
EXEC ps_tblPosts_CRUD @Action='Insert', @PostTitle='Football Strategies', @PostDescription='Tips for football players', @CategoryId=37, @UserId=7;
EXEC ps_tblPosts_CRUD @Action='Insert', @PostTitle='Economic Policies', @PostDescription='Understanding modern economic policies', @CategoryId=38, @UserId=8;
EXEC ps_tblPosts_CRUD @Action='Insert', @PostTitle='Famous Novels', @PostDescription='Review of classic literature', @CategoryId=39, @UserId=9;
EXEC ps_tblPosts_CRUD @Action='Insert', @PostTitle='Quantum Mechanics', @PostDescription='Introduction to quantum physics', @CategoryId=40, @UserId=10;
EXEC ps_tblPosts_CRUD @Action='Insert', @PostTitle='Organic Chemistry Basics', @PostDescription='Chemical reactions explained', @CategoryId=41, @UserId=11;
EXEC ps_tblPosts_CRUD @Action='Insert', @PostTitle='Human Biology', @PostDescription='Understanding human anatomy', @CategoryId=42, @UserId=12;
EXEC ps_tblPosts_CRUD @Action='Insert', @PostTitle='Python Programming', @PostDescription='Beginner to advanced Python', @CategoryId=43, @UserId=13;
EXEC ps_tblPosts_CRUD @Action='Insert', @PostTitle='Classical Music', @PostDescription='Learning about composers', @CategoryId=44, @UserId=14;
EXEC ps_tblPosts_CRUD @Action='Insert', @PostTitle='Philosophy 101', @PostDescription='Basic philosophical concepts', @CategoryId=45, @UserId=15;
Go
SELECT * FROM tblPosts;



CREATE or alter PROCEDURE ps_tblPosts_Fetch
(
    @postId INT = NULL,
    @userId INT = NULL,      
    @categoryId INT = NULL   
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.postId,
        p.postTitle,
        p.postDescription,
        p.insertedDate AS postInsertedDate,

        c.categoryId,
        c.categoryName,

        u.userId,
        u.userName,
        u.email,
        u.mobile,
        u.profileImage
    FROM tblPosts p
    INNER JOIN tblCategory c
        ON p.categoryId = c.categoryId
    INNER JOIN tblUsers u
        ON p.userId = u.userId
    WHERE 
        p.flag = 1 AND
        c.flag = 1 AND
        u.flag = 1 AND
        (@postId IS NULL OR p.postId = @postId) AND
        (@userId IS NULL OR u.userId = @userId) AND
        (@categoryId IS NULL OR c.categoryId = @categoryId);
END;


EXEC ps_tblPosts_Fetch ;

CREATE TABLE tblPostUploads
(
    uploadId         INT IDENTITY(1,1) PRIMARY KEY,
    postId           INT FOREIGN KEY REFERENCES tblPosts(postId),
    uploadFile       VARCHAR(200),

    flag             BIT DEFAULT 1,
    insertedDate     DATETIME DEFAULT GETDATE(),
    updatedDate      DATETIME NULL,
    deleteDateTime   DATETIME NULL,
    restoreDateTime  DATETIME NULL
);
CREATE PROCEDURE ps_tblPostUploads_CRUD
(
    @Action          VARCHAR(20),
    @uploadId        INT = NULL,
    @postId          INT = NULL,
    @uploadFile      VARCHAR(500) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    IF(@Action = 'INSERT')
    BEGIN
        INSERT INTO tblPostUploads
        (
            postId, uploadFile
        )
        VALUES
        (
            @postId, @uploadFile
        );
    END

    
    IF(@Action = 'UPDATE')
    BEGIN
        UPDATE tblPostUploads
        SET 
            postId = @postId,
            uploadFile = @uploadFile,
            updatedDate = GETDATE()
        WHERE uploadId = @uploadId;
    END

    
    IF(@Action = 'DELETE')
    BEGIN
        UPDATE tblPostUploads
        SET 
            flag = 0,
            deleteDateTime = GETDATE()
        WHERE uploadId = @uploadId;
    END

   
    IF(@Action = 'RESTORE')
    BEGIN
        UPDATE tblPostUploads
        SET 
            flag = 1,
            deleteDateTime = NULL,
            restoreDateTime = GETDATE()
        WHERE uploadId = @uploadId;
    END
END;
GO

EXEC ps_tblPostUploads_CRUD @Action='Insert', @PostId=1, @UploadFile='physics_intro.pdf';
EXEC ps_tblPostUploads_CRUD @Action='Insert', @PostId=2, @UploadFile='calculus_tips.pdf';
EXEC ps_tblPostUploads_CRUD @Action='Insert', @PostId=3, @UploadFile='india_history.docx';
EXEC ps_tblPostUploads_CRUD @Action='Insert', @PostId=4, @UploadFile='world_geography_map.jpg';
EXEC ps_tblPostUploads_CRUD @Action='Insert', @PostId=5, @UploadFile='tech_trends.pdf';
EXEC ps_tblPostUploads_CRUD @Action='Insert', @PostId=6, @UploadFile='painting_techniques.mp4';
EXEC ps_tblPostUploads_CRUD @Action='Insert', @PostId=7, @UploadFile='football_strategies.docx';
EXEC ps_tblPostUploads_CRUD @Action='Insert', @PostId=8, @UploadFile='economic_policies.pdf';
EXEC ps_tblPostUploads_CRUD @Action='Insert', @PostId=9, @UploadFile='novels_review.pdf';
EXEC ps_tblPostUploads_CRUD @Action='Insert', @PostId=10, @UploadFile='quantum_mechanics.pdf';
EXEC ps_tblPostUploads_CRUD @Action='Insert', @PostId=11, @UploadFile='organic_chemistry.pdf';
EXEC ps_tblPostUploads_CRUD @Action='Insert', @PostId=12, @UploadFile='human_biology.docx';
EXEC ps_tblPostUploads_CRUD @Action='Insert', @PostId=13, @UploadFile='python_tutorial.mp4';
EXEC ps_tblPostUploads_CRUD @Action='Insert', @PostId=14, @UploadFile='classical_music.mp3';
EXEC ps_tblPostUploads_CRUD @Action='Insert', @PostId=15, @UploadFile='philosophy_101.pdf';
SELECT * 
FROM tblPostUploads;

CREATE PROCEDURE ps_tblPostUploads_Fetch
(
    @postId INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        u.uploadId,
        u.uploadFile,
        u.insertedDate,
        u.updatedDate
    FROM tblPostUploads u
    INNER JOIN tblPosts p
        ON u.postId = p.postId
    WHERE 
        u.postId = @postId
        AND u.flag = 1
        AND p.flag = 1;
END;
GO
EXEC ps_tblPostUploads_Fetch @PostId=1;

ALTER TABLE tblPostLikes
ADD deleteDateTime DATETIME NULL;
ALTER TABLE tblPostLikes
ADD restoreDateTime DATETIME NULL;


    CREATE TABLE tblPostLikes
(
    likeId INT IDENTITY(1,1) PRIMARY KEY,
    postId INT NOT NULL,
    userId INT NOT NULL,
    flag BIT DEFAULT 1, 
    insertedDate DATETIME DEFAULT GETDATE(),
    updatedDate DATETIME NULL,
     

    CONSTRAINT FK_PostLikes_Post FOREIGN KEY(postId) REFERENCES tblPosts(postId),
    CONSTRAINT FK_PostLikes_User FOREIGN KEY(userId) REFERENCES tblUsers(userId)
);
CREATE OR ALTER PROCEDURE sp_tblPostLikes_CRUD
(
    @Action   VARCHAR(20),
    @likeId   INT = NULL,
    @postId   INT = NULL,
    @userId   INT = NULL
)
AS
BEGIN
    SET NOCOUNT ON;


    IF @Action = 'INSERT'
    BEGIN
        INSERT INTO tblPostLikes (postId, userId, flag, insertedDate)
        VALUES (@postId, @userId, 1, GETDATE());
    END

 
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE tblPostLikes
        SET 
            postId = @postId,
            userId = @userId,
            updatedDate = GETDATE()
        WHERE likeId = @likeId;
    END

    ELSE IF @Action = 'DELETE'
    BEGIN
        UPDATE tblPostLikes
        SET 
            flag = 0,
            deleteDateTime = GETDATE()
        WHERE likeId = @likeId;
    END


    ELSE IF @Action = 'RESTORE'
    BEGIN
        UPDATE tblPostLikes
        SET 
            flag = 1,
            restoreDateTime = GETDATE()
           WHERE likeId = @likeId;
    END
END;
GO
EXEC sp_tblPostLikes_CRUD @Action='Insert', @PostId=1, @UserId=2;
EXEC sp_tblPostLikes_CRUD @Action='Insert', @PostId=1, @UserId=3;
EXEC sp_tblPostLikes_CRUD @Action='Insert', @PostId=2, @UserId=1;
EXEC sp_tblPostLikes_CRUD @Action='Insert', @PostId=2, @UserId=4;
EXEC sp_tblPostLikes_CRUD @Action='Insert', @PostId=3, @UserId=5;
EXEC sp_tblPostLikes_CRUD @Action='Insert', @PostId=3, @UserId=6;
EXEC sp_tblPostLikes_CRUD @Action='Insert', @PostId=4, @UserId=7;
EXEC sp_tblPostLikes_CRUD @Action='Insert', @PostId=4, @UserId=8;
EXEC sp_tblPostLikes_CRUD @Action='Insert', @PostId=5, @UserId=9;
EXEC sp_tblPostLikes_CRUD @Action='Insert', @PostId=5, @UserId=10;
EXEC sp_tblPostLikes_CRUD @Action='Insert', @PostId=6, @UserId=11;
EXEC sp_tblPostLikes_CRUD @Action='Insert', @PostId=6, @UserId=12;
EXEC sp_tblPostLikes_CRUD @Action='Insert', @PostId=7, @UserId=13;
EXEC sp_tblPostLikes_CRUD @Action='Insert', @PostId=7, @UserId=14;
EXEC sp_tblPostLikes_CRUD @Action='Insert', @PostId=8, @UserId=15;

CREATE OR ALTER PROCEDURE ps_tblPostLikes_Fetch
(
    @LikeId INT = NULL,
    @PostId INT = NULL,
    @UserId INT = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        pl.LikeId,
        pl.insertedDate AS LikeTime,  
        1 AS IsLike,                 

        p.PostId,
        p.PostTitle,

        u.UserId,
        u.UserName,
        u.Email,
        u.ProfileImage
    FROM tblPostLikes pl
    INNER JOIN tblPosts p ON pl.PostId = p.PostId
    INNER JOIN tblUsers u ON pl.UserId = u.UserId
    WHERE 
        pl.flag = 1 AND   
        (@LikeId IS NULL OR pl.LikeId = @LikeId) AND
        (@PostId IS NULL OR p.PostId = @PostId) AND
        (@UserId IS NULL OR u.UserId = @UserId);
END;
GO
EXEC ps_tblPostLikes_Fetch;


CREATE TABLE tblComments
(
    commentId        INT IDENTITY(1,1) PRIMARY KEY,
    postId           INT FOREIGN KEY REFERENCES tblPosts(postId),
    userId           INT FOREIGN KEY REFERENCES tblUsers(userId),
    commentText      VARCHAR(MAX),
    commentTime      DATETIME,

    flag             BIT DEFAULT 1,
    insertedDate     DATETIME DEFAULT GETDATE(),
    updatedDate      DATETIME NULL,
    deleteDateTime   DATETIME NULL,
    restoreDateTime  DATETIME NULL
);

CREATE PROCEDURE ps_tblComments_CRUD
(
    @Action       VARCHAR(10),   
    @commentId    INT = NULL,
    @postId       INT = NULL,
    @userId       INT = NULL,
    @commentText  VARCHAR(MAX) = NULL,
    @commentTime  DATETIME = NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    IF(@Action = 'INSERT')
    BEGIN
        INSERT INTO tblComments (postId, userId, commentText, commentTime)
        VALUES (@postId, @userId, @commentText, @commentTime);
    END
    ELSE IF(@Action = 'UPDATE')
    BEGIN
        UPDATE tblComments
        SET commentText = @commentText,
            commentTime = @commentTime,
            updatedDate = GETDATE()
        WHERE commentId = @commentId;
    END
    ELSE IF(@Action = 'DELETE')
    BEGIN
        UPDATE tblComments
        SET flag = 0,
            deleteDateTime = GETDATE()
        WHERE commentId = @commentId;
    END
    ELSE IF(@Action = 'RESTORE')
    BEGIN
        UPDATE tblComments
        SET flag = 1,
            restoreDateTime = GETDATE()
        WHERE commentId = @commentId;
    END
  END;
GO
EXEC ps_tblComments_CRUD @Action='Insert', @PostId=1, @UserId=2, @CommentText='Great explanation on Physics!';
EXEC ps_tblComments_CRUD @Action='Insert', @PostId=1, @UserId=3, @CommentText='Thanks for sharing this post.';
EXEC ps_tblComments_CRUD @Action='Insert', @PostId=2, @UserId=1, @CommentText='Very helpful calculus tips.';
EXEC ps_tblComments_CRUD @Action='Insert', @PostId=2, @UserId=4, @CommentText='Can you explain integration in detail?';
EXEC ps_tblComments_CRUD @Action='Insert', @PostId=3, @UserId=5, @CommentText='Interesting insights on Indian history.';
EXEC ps_tblComments_CRUD @Action='Insert', @PostId=3, @UserId=6, @CommentText='Nice post, learned a lot!';
EXEC ps_tblComments_CRUD @Action='Insert', @PostId=4, @UserId=7, @CommentText='Maps are very clear and easy to follow.';
EXEC ps_tblComments_CRUD @Action='Insert', @PostId=4, @UserId=8, @CommentText='Helpful geography tips!';
EXEC ps_tblComments_CRUD @Action='Insert', @PostId=5, @UserId=9, @CommentText='Tech trends explained well.';
EXEC ps_tblComments_CRUD @Action='Insert', @PostId=5, @UserId=10, @CommentText='Great article on AI and IoT.';
EXEC ps_tblComments_CRUD @Action='Insert', @PostId=6, @UserId=11, @CommentText='Painting tutorial is very detailed.';
EXEC ps_tblComments_CRUD @Action='Insert', @PostId=6, @UserId=12, @CommentText='Loved the techniques shared!';
EXEC ps_tblComments_CRUD @Action='Insert', @PostId=7, @UserId=13, @CommentText='Good football strategies post.';
EXEC ps_tblComments_CRUD @Action='Insert', @PostId=7, @UserId=14, @CommentText='Very helpful!';
EXEC ps_tblComments_CRUD @Action='Insert', @PostId=8, @UserId=15, @CommentText='Economic policies explained clearly.';


CREATE or alter PROCEDURE ps_tblComments_Fetch
(
    @CommentId INT = NULL,
    @PostId INT = NULL,
    @UserId INT = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        c.CommentId,
        c.CommentText,
        c.insertedDate AS CommentTime,
        c.updatedDate,
        c.PostId,
        p.PostTitle,
        c.UserId,
        u.UserName,
        u.Email,
        u.ProfileImage
    FROM tblComments c
    INNER JOIN tblPosts p ON c.PostId = p.PostId
    INNER JOIN tblUsers u ON c.UserId = u.UserId
    WHERE 
        c.flag = 1 AND       
        p.flag = 1 AND        
        u.flag = 1 AND      
        (@CommentId IS NULL OR c.CommentId = @CommentId) AND
        (@PostId IS NULL OR c.PostId = @PostId) AND
        (@UserId IS NULL OR c.UserId = @UserId)
    ORDER BY c.CommentId;
END;
GO


EXEC ps_tblComments_Fetch;


  CREATE TABLE tblCommentReply
(
    replyId          INT IDENTITY(1,1) PRIMARY KEY,
    commentId        INT FOREIGN KEY REFERENCES tblComments(commentId),
    userId           INT FOREIGN KEY REFERENCES tblUsers(userId),
    replyText        VARCHAR(MAX),
    replyTime        DATETIME,

    flag             BIT DEFAULT 1,
    insertedDate     DATETIME DEFAULT GETDATE(),
    updatedDate      DATETIME NULL,
    deleteDateTime   DATETIME NULL,
    restoreDateTime  DATETIME NULL
);

CREATE PROCEDURE ps_tblCommentReply_CRUD
(
    @Action       VARCHAR(10),     
    @replyId      INT = NULL,
    @commentId    INT = NULL,
    @userId       INT = NULL,
    @replyText    VARCHAR(MAX) = NULL,
    @replyTime    DATETIME = NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    IF(@Action = 'INSERT')
    BEGIN
        INSERT INTO tblCommentReply (commentId, userId, replyText, replyTime)
        VALUES (@commentId, @userId, @replyText, @replyTime);
    END
    ELSE IF(@Action = 'UPDATE')
    BEGIN
        UPDATE tblCommentReply
        SET replyText = @replyText,
            replyTime = @replyTime,
            updatedDate = GETDATE()
        WHERE replyId = @replyId;
    END
    ELSE IF(@Action = 'DELETE')
    BEGIN
        UPDATE tblCommentReply
        SET flag = 0,
            deleteDateTime = GETDATE()
        WHERE replyId = @replyId;
    END
    ELSE IF(@Action = 'RESTORE')
    BEGIN
        UPDATE tblCommentReply
        SET flag = 1,
            restoreDateTime = GETDATE()
        WHERE replyId = @replyId;
    END
END
Go
EXEC ps_tblCommentReply_CRUD @Action='Insert', @CommentId=1, @UserId=3, @ReplyText='I agree with your point!';
EXEC ps_tblCommentReply_CRUD @Action='Insert', @CommentId=1, @UserId=4, @ReplyText='Thanks for sharing!';
EXEC ps_tblCommentReply_CRUD @Action='Insert', @CommentId=2, @UserId=2, @ReplyText='Can you explain more?';
EXEC ps_tblCommentReply_CRUD @Action='Insert', @CommentId=2, @UserId=5, @ReplyText='Nice post!';
EXEC ps_tblCommentReply_CRUD @Action='Insert', @CommentId=3, @UserId=1, @ReplyText='Very informative.';
EXEC ps_tblCommentReply_CRUD @Action='Insert', @CommentId=3, @UserId=6, @ReplyText='Learned a lot, thanks!';
EXEC ps_tblCommentReply_CRUD @Action='Insert', @CommentId=4, @UserId=7, @ReplyText='Helpful explanation.';
EXEC ps_tblCommentReply_CRUD @Action='Insert', @CommentId=4, @UserId=8, @ReplyText='Good examples!';
EXEC ps_tblCommentReply_CRUD @Action='Insert', @CommentId=5, @UserId=9, @ReplyText='Excellent post!';
EXEC ps_tblCommentReply_CRUD @Action='Insert', @CommentId=5, @UserId=10, @ReplyText='Thanks for the details.';
EXEC ps_tblCommentReply_CRUD @Action='Insert', @CommentId=6, @UserId=11, @ReplyText='Very clear explanation.';
EXEC ps_tblCommentReply_CRUD @Action='Insert', @CommentId=6, @UserId=12, @ReplyText='Helpful for understanding.';
EXEC ps_tblCommentReply_CRUD @Action='Insert', @CommentId=7, @UserId=13, @ReplyText='Good tips!';
EXEC ps_tblCommentReply_CRUD @Action='Insert', @CommentId=7, @UserId=14, @ReplyText='Nice insight!';
EXEC ps_tblCommentReply_CRUD @Action='Insert', @CommentId=8, @UserId=15, @ReplyText='Very useful information.';

CREATE PROCEDURE ps_tblCommentReply_Fetch
(
    @ReplyId INT = NULL,
    @CommentId INT = NULL,
    @UserId INT = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        r.ReplyId,
        r.ReplyText,
        r.insertedDate AS ReplyTime,
        r.updatedDate,
        r.CommentId,
        c.CommentText,
        r.UserId,
        u.UserName,
        u.Email,
        u.ProfileImage
    FROM tblCommentReply r
    INNER JOIN tblComments c ON r.CommentId = c.CommentId
    INNER JOIN tblUsers u ON r.UserId = u.UserId
    WHERE 
        r.flag = 1 AND       
        c.flag = 1 AND      
        u.flag = 1 AND       
        (@ReplyId IS NULL OR r.ReplyId = @ReplyId) AND
        (@CommentId IS NULL OR r.CommentId = @CommentId) AND
        (@UserId IS NULL OR r.UserId = @UserId)
    ORDER BY r.ReplyId;
END;
GO
EXEC ps_tblCommentReply_Fetch;



