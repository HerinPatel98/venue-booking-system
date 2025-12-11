CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(MAX) NOT NULL,
    Role NVARCHAR(20) NOT NULL CHECK (Role IN ('Admin', 'User')),
    FullName NVARCHAR(100) NOT NULL,
    PhoneNumber NVARCHAR(20) NULL
);

CREATE TABLE Venues (
    VenueId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    VenueType NVARCHAR(50) NOT NULL,
    Capacity INT NOT NULL,
    BasePrice DECIMAL(10, 2) NOT NULL,
    City NVARCHAR(100) NOT NULL,
    ContactEmail NVARCHAR(100) NULL,
    ContactPhone NVARCHAR(20) NULL,
    IsAvailable BIT NOT NULL DEFAULT 1
);

CREATE TABLE Bookings (
    BookingId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL CONSTRAINT FK_Bookings_UserId FOREIGN KEY (UserId) REFERENCES Users(UserId),
    VenueId INT NOT NULL CONSTRAINT FK_Bookings_VenueId FOREIGN KEY (VenueId) REFERENCES Venues(VenueId),
    BookingDate DATE NOT NULL,
    BookingStatus NVARCHAR(20) NOT NULL CHECK (BookingStatus IN ('Pending', 'Confirmed', 'Cancelled')),
    PaymentStatus NVARCHAR(20) NOT NULL CHECK (PaymentStatus IN ('Unpaid', 'Paid')),
    TotalCost DECIMAL(10, 2) NOT NULL,
    RequestedDate DATETIME NOT NULL DEFAULT GETDATE()
);
