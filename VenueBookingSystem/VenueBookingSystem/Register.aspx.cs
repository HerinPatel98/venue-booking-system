using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VenueBookingSystem
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;
            string fullName = txtFullName.Text.Trim();
            string phoneNumber = txtPhoneNumber.Text.Trim();
            string city = txtCity.Text.Trim();
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    // 1. Use C# to hash the password securely and get a string result
                    string hashedPassword = PasswordHasher.HashPassword(password);

                    // 2. Insert the resulting STRING into the NVARCHAR(MAX) column
                    string query = @"INSERT INTO Users (Email, PasswordHash, Role, FullName, PhoneNumber, City) 
                                     VALUES (@Email, @PasswordHash, @Role, @FullName, @PhoneNumber, @City)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@PasswordHash", hashedPassword); // Pass the C# generated hash string
                        cmd.Parameters.AddWithValue("@Role", "User");      // CRITICAL: Automatically assign the 'User' role
                        cmd.Parameters.AddWithValue("@FullName", fullName);
                        cmd.Parameters.AddWithValue("@City", city);
                        cmd.Parameters.AddWithValue("@PhoneNumber", string.IsNullOrEmpty(phoneNumber) ? (object)DBNull.Value : phoneNumber);

                        conn.Open();
                        cmd.ExecuteNonQuery();

                        lblMessage.Text = "Registration successful! You can now log in.";
                        lblMessage.CssClass = "alert alert-success w-100 mb-3";
                        lblMessage.Visible = true;
                        // Clear form fields
                        txtEmail.Text = "";
                        txtFullName.Text = "";
                        txtPhoneNumber.Text = "";
                    }
                }
            }
            catch (SqlException ex)
            {
                // Handle the unique constraint error if the email is already registered
                if (ex.Message.Contains("UNIQUE"))
                {
                    lblMessage.Text = "That email address is already registered.";
                    lblMessage.CssClass = "alert alert-warning w-100 mb-3";
                }
                else
                {
                    lblMessage.Text = "An error occurred during registration.";
                    // Log the detailed error to a file if possible
                }
                lblMessage.Visible = true;
            }
        }
    }
}