CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(MAX) NOT NULL,
    Role NVARCHAR(20) NOT NULL CHECK (Role IN ('Admin', 'User')),
    FullName NVARCHAR(100) NOT NULL,
    PhoneNumber NVARCHAR(20) NULL,
    City NVARCHAR(20) NULL
);

CREATE TABLE [dbo].[Venues] (
    [VenueId]      INT             IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (100)  NOT NULL,
    [Description]  NVARCHAR (MAX)  NOT NULL,
    [VenueType]    NVARCHAR (50)   NOT NULL,
    [Capacity]     INT             NOT NULL,
    [BasePrice]    DECIMAL (10, 2) NOT NULL,
    [City]         NVARCHAR (100)  NOT NULL,
    [ContactEmail] NVARCHAR (100)  NULL,
    [ContactPhone] NVARCHAR (20)   NULL,
    [IsAvailable]  BIT             DEFAULT ((1)) NOT NULL,
    [ImageUrl]     NVARCHAR (100)  NULL,
    PRIMARY KEY CLUSTERED ([VenueId] ASC)
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

CREATE TABLE [dbo].[Feedbacks] (
    [FeedbackId]   INT            IDENTITY (1, 1) NOT NULL,
    [VenueId]      INT            NOT NULL,
    [UserId]       INT            NOT NULL,
    [BookingId]    INT            NOT NULL, -- NEW COLUMN
    [Rating]       INT            NOT NULL,
    [Comment]      NVARCHAR (MAX) NOT NULL,
    [FeedbackDate] DATETIME       DEFAULT GETDATE() NOT NULL,
    PRIMARY KEY CLUSTERED ([FeedbackId] ASC),
    CONSTRAINT [FK_Feedbacks_Venues] FOREIGN KEY ([VenueId]) REFERENCES [dbo].[Venues] ([VenueId]),
    CONSTRAINT [FK_Feedbacks_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [FK_Feedbacks_Bookings] FOREIGN KEY ([BookingId]) REFERENCES [dbo].[Bookings] ([BookingId]),
    CONSTRAINT [CK_Feedbacks_Rating] CHECK ([Rating]>=(1) AND [Rating]<=(5))
);