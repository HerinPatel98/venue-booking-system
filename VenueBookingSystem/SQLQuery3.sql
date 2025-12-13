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
