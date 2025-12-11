// PasswordHasher.cs (Ensure this file is saved in the root of your project)

using System;
using System.Security.Cryptography;
using System.Text;

namespace VenueBookingSystem
{
    public static class PasswordHasher
    {
        // Method to securely hash a plain text password using SHA256
        public static string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                // Convert the password string to a byte array
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));

                // Convert the byte array into a hexadecimal string representation (NVARCHAR format)
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }

        // Method to verify an entered password against a stored hash string
        public static bool VerifyPassword(string enteredPassword, string storedHash)
        {
            // Hash the entered password using the same algorithm
            string enteredPasswordHash = HashPassword(enteredPassword);

            // Compare the two hash strings to see if they match
            return StringComparer.OrdinalIgnoreCase.Equals(enteredPasswordHash, storedHash);
        }
    }
}

