using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace VenueBookingSystem
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            // Use the connection string from your main web.config file
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;

            // This flag tracks if login is successful
            bool isAuthenticated = false;
            string userRole = "";
            string fullName = "";
            string city = "";
            int userId = 0;

            // 1. Check database for user credentials using ADO.NET
            using (SqlConnection conn = new SqlConnection(connectionString))
            {

                string query = "SELECT UserId, PasswordHash, Role, FullName, City FROM Users WHERE Email = @Email";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string storedHash = reader["PasswordHash"].ToString();
                            // If a row is returned, it means both Email and Password are correct
                            if (PasswordHasher.VerifyPassword(password, storedHash))
                            {
                                isAuthenticated = true;
                                userId = Convert.ToInt32(reader["UserId"]);
                                userRole = reader["Role"].ToString();
                                fullName = reader["FullName"].ToString();
                                city = reader["City"].ToString().Trim();
                            }
                        }
                    }
                }
            }


            // 3. Handle login outcome
            if (isAuthenticated)
            {
                // Set the Session variables we agreed upon for site-wide use
                Session["IsUserLoggedIn"] = true;
                Session["UserId"] = userId;
                Session["CurrentUsername"] = email;
                Session["UserRole"] = userRole;
                Session["FullName"] = fullName;
                Session["UserCity"] = city;

                // Redirect based on the user's role
                if (userRole == "Admin")
                {
                    Response.Redirect("~/Admin/Dashboard.aspx");
                }
                else // Role is "User"
                {
                    Response.Redirect("~/UserDashboard.aspx");
                }
            }
            else
            {
                // Show error message
                lblErrorMessage.Text = "Invalid login attempt. Please check your email and password.";
                lblErrorMessage.Visible = true;
            }
        }
    }
}