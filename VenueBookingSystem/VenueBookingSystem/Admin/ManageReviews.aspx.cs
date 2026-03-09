using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace VenueBookingSystem.Admin
{
    public partial class ManageReviews : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadAllReviews();
            }
        }

        private void LoadAllReviews()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Joins tables and uses a CASE statement to sort 'Pending' items to the very top
                string query = @"
                    SELECT F.FeedbackId, U.FullName, V.Name AS VenueName, F.Rating, F.Comment, F.Status, F.FeedbackDate 
                    FROM Feedbacks F
                    INNER JOIN Users U ON F.UserId = U.UserId
                    INNER JOIN Venues V ON F.VenueId = V.VenueId
                    ORDER BY 
                        CASE WHEN F.Status = 'Pending' THEN 1 ELSE 2 END, 
                        F.FeedbackDate DESC";

                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvReviews.DataSource = dt;
                gvReviews.DataBind();
            }
        }

        protected void gvReviews_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // Only process our specific commands
            if (e.CommandName == "ApproveReview" || e.CommandName == "RejectReview")
            {
                int feedbackId = Convert.ToInt32(e.CommandArgument);
                string newStatus = e.CommandName == "ApproveReview" ? "Approved" : "Rejected";

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = "UPDATE Feedbacks SET Status = @status WHERE FeedbackId = @id";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@status", newStatus);
                    cmd.Parameters.AddWithValue("@id", feedbackId);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    lblStatusMessage.Text = $"Review has been {newStatus.ToLower()} successfully.";

                    // Refresh the grid to show the updated badges and buttons
                    LoadAllReviews();
                }
            }
        }
    }
}