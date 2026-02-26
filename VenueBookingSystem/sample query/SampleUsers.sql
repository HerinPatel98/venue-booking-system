INSERT INTO [dbo].[Users] ([Email], [PasswordHash], [Role], [FullName], [PhoneNumber], [City])
VALUES 
(N'raj.sharma@example.com', N'raj.sharma', N'User', N'Raj Sharma', N'9876543210', N'Mumbai'),
(N'priya.patel@example.com', N'priya.patel', N'User', N'Priya Patel', N'9123456789', N'Ahmedabad'),
(N'amit.verma@example.com', N'amit.verma', N'User', N'Amit Verma', N'8877665544', N'Delhi'),
(N'sneha.reddy@example.com', N'sneha.reddy', N'User', N'Sneha Reddy', N'7766554433', N'Hyderabad'),
(N'vijay.nair@example.com', N'vijay.nair', N'User', N'Vijay Nair', N'9988776655', N'Bangalore');

-- Verification Query
SELECT UserId, Email, FullName, Role, City FROM Users ORDER BY UserId DESC;