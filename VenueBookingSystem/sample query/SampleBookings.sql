INSERT INTO Bookings (UserId, VenueId, BookingDate, BookingStatus, PaymentStatus, TotalCost, RequestedDate)
VALUES 
(
    3,                                     -- Assuming UserId 1 exists
    1,                                     -- Assuming VenueId 1 (Grand Ballroom) exists
    '2025-12-25',                          -- The date of the event
    'Confirmed',                           -- Status: Confirmed
    'Paid',                                -- Payment Status: Paid
    18000.00,                              -- The final cost
    GETDATE()                              -- Timestamp when the request was made (now)
);

INSERT INTO Bookings (UserId, VenueId, BookingDate, BookingStatus, PaymentStatus, TotalCost, RequestedDate)
VALUES 
(
    5,                                     -- Assuming UserId 1 exists
    3,                                     -- Assuming VenueId 3 (Urban Terrace Hall) exists
    '2026-01-15',                          -- The date of the event
    'Pending',                             -- Status: Pending approval
    'Unpaid',                              -- Payment Status: Unpaid
    8500.00,                               -- The final cost
    GETDATE()                              -- Timestamp when the request was made (now)
);


-- Inserting sample bookings for the new users
-- Columns: [UserId], [VenueId], [BookingDate], [BookingStatus], [PaymentStatus], [TotalCost], [RequestedDate]

INSERT INTO [dbo].[Bookings] ([UserId], [VenueId], [BookingDate], [BookingStatus], [PaymentStatus], [TotalCost], [RequestedDate])
VALUES 
-- Raj Sharma (UserId likely 12) books The Grand Ballroom (Venue 1)
((SELECT UserId FROM Users WHERE Email = 'raj.sharma@example.com'), 1, '2026-02-14', 'Confirmed', 'Paid', 45000.00, GETDATE()),

-- Priya Patel (UserId likely 13) books Hotel Harmony (Venue 5)
((SELECT UserId FROM Users WHERE Email = 'priya.patel@example.com'), 5, '2026-02-20', 'Confirmed', 'Paid', 35000.00, GETDATE()),

-- Amit Verma (UserId likely 14) books The Party Lounge (Venue 4)
((SELECT UserId FROM Users WHERE Email = 'amit.verma@example.com'), 4, '2026-03-01', 'Confirmed', 'Paid', 25000.00, GETDATE()),

-- Sneha Reddy (UserId likely 15) books Urban Terrace Hall (Venue 3)
((SELECT UserId FROM Users WHERE Email = 'sneha.reddy@example.com'), 3, '2026-03-10', 'Confirmed', 'Paid', 15000.00, GETDATE()),

-- Vijay Nair (UserId likely 16) books The Blue Forest Resort (Venue 9)
((SELECT UserId FROM Users WHERE Email = 'vijay.nair@example.com'), 9, '2026-03-25', 'Confirmed', 'Paid', 65000.00, GETDATE());

-- Verification Query to see your new bookings
SELECT B.BookingId, U.FullName, V.Name AS VenueName, B.BookingDate, B.BookingStatus, B.PaymentStatus
FROM Bookings B
JOIN Users U ON B.UserId = U.UserId
JOIN Venues V ON B.VenueId = V.VenueId
WHERE B.BookingDate >= '2026-02-01'
ORDER BY B.BookingDate ASC;