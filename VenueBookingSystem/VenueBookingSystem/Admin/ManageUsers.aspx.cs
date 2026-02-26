using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;

namespace VenueBookingSystem.Admin
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        // Connection String shorthand
        private string ConnString => ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Security Check: Only Admins Allowed
            if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            // 2. Data Loading
            // We load this EVERY time (even on PostBack) to ensure the GridView 
            // has data when events like 'Delete' fire. This prevents "Empty Grid" bugs.
            LoadUsers();
        }

        private void LoadUsers()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConnString))
                {
                    // Select all users, ordered by Newest first
                    string query = "SELECT UserId, FullName, Email, Role, City, PhoneNumber FROM Users ORDER BY Role Asc, Fullname Asc";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        conn.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvUsers.DataSource = dt;
                        gvUsers.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading users: " + ex.Message, false);
            }
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // Clear previous messages
            lblMsg.Visible = false;

            if (e.CommandName == "DeleteUser")
            {
                try
                {
                    // 1. Get the Row Index from the CommandArgument
                    int rowIndex = Convert.ToInt32(e.CommandArgument);

                    // 2. Retrieve the UserId from the DataKeys property using the index
                    // This is much safer than passing the ID directly in the button
                    int userIdToDelete = Convert.ToInt32(gvUsers.DataKeys[rowIndex].Value);

                    // 3. Prevent deleting yourself (Double check)
                    if (userIdToDelete == Convert.ToInt32(Session["UserId"]))
                    {
                        ShowMessage("You cannot delete your own account while logged in.", false);
                        return;
                    }

                    // 4. Perform Delete
                    bool success = DeleteUserById(userIdToDelete);

                    if (success)
                    {
                        ShowMessage("User deleted successfully.", true);
                        LoadUsers(); // Refresh the grid
                    }
                    else
                    {
                        ShowMessage("Delete failed. User may not exist.", false);
                    }
                }
                catch (SqlException sqlEx)
                {
                    // Check for Foreign Key Constraint (Error 547)
                    // This happens if the user has Bookings or Feedback in the database
                    if (sqlEx.Number == 547)
                    {
                        ShowMessage("Cannot delete this user because they have existing Bookings or Feedback. Delete their records first.", false);
                    }
                    else
                    {
                        ShowMessage("Database Error: " + sqlEx.Message, false);
                    }
                }
                catch (Exception ex)
                {
                    ShowMessage("System Error: " + ex.Message, false);
                }
            }
        }

        private bool DeleteUserById(int userId)
        {
            using (SqlConnection conn = new SqlConnection(ConnString))
            {
                // Simple Delete Query
                string query = "DELETE FROM Users WHERE UserId = @uid";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@uid", userId);
                    conn.Open();
                    int rows = cmd.ExecuteNonQuery();
                    return rows > 0;
                }
            }
        }

        // Helper for UI Badges
        protected string GetRoleBadgeClass(string role)
        {
            if (string.IsNullOrEmpty(role))
                return "bg-secondary";

            return role.ToLower() == "admin" ? "bg-warning text-dark" : "bg-info";
        }

        // Helper to show on-screen messages
        private void ShowMessage(string message, bool isSuccess)
        {
            lblMsg.Visible = true;
            lblMsg.Text = message;
            lblMsg.CssClass = isSuccess ? "alert alert-success" : "alert alert-danger";
        }
    }
}