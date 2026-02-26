using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace VenueBookingSystem
{
    public partial class AddFeedback : System.Web.UI.Page
    {
        string ConnString => ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;

        int _bookingId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (Request.QueryString["bid"] != null)
            {
                _bookingId = Convert.ToInt32(Request.QueryString["bid"]);
            }
            else
            {
                Response.Redirect("~/UserDashboard.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // 1. SECURITY: Check if this booking is already reviewed
                if (CheckIfAlreadyReviewed(_bookingId))
                {
                    // Redirect with a special message
                    Response.Redirect("~/UserDashboard.aspx?status=already_reviewed");
                    return;
                }

                LoadVenueInfo();
            }
        }

        private bool CheckIfAlreadyReviewed(int bookingId)
        {
            using (SqlConnection conn = new SqlConnection(ConnString))
            {
                string query = "SELECT COUNT(*) FROM Feedbacks WHERE BookingId = @bid";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@bid", bookingId);

                conn.Open();
                int count = (int)cmd.ExecuteScalar();
                return count > 0; // Returns True if review exists
            }
        }

        private void LoadVenueInfo()
        {
            using (SqlConnection conn = new SqlConnection(ConnString))
            {
                // Verify booking belongs to user
                string query = @"SELECT V.VenueId, V.Name, B.BookingDate 
                                 FROM Bookings B 
                                 JOIN Venues V ON B.VenueId = V.VenueId 
                                 WHERE B.BookingId = @bid AND B.UserId = @uid";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@bid", _bookingId);
                cmd.Parameters.AddWithValue("@uid", Convert.ToInt32(Session["UserId"]));

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        lblVenueName.Text = reader["Name"].ToString();
                        lblDate.Text = Convert.ToDateTime(reader["BookingDate"]).ToString("dd MMM yyyy");
                        ViewState["TargetVenueId"] = reader["VenueId"];
                    }
                    else
                    {
                        Response.Redirect("~/UserDashboard.aspx");
                    }
                }
                catch (Exception ex)
                {
                    lblError.Visible = true;
                    lblError.Text = "Error: " + ex.Message;
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                int venueId = Convert.ToInt32(ViewState["TargetVenueId"]);
                int userId = Convert.ToInt32(Session["UserId"]);
                int rating = Convert.ToInt32(ddlRating.SelectedValue);
                string comment = txtComment.Text.Trim();

                using (SqlConnection conn = new SqlConnection(ConnString))
                {
                    // UPDATED QUERY: Now includes BookingId
                    string query = @"INSERT INTO Feedbacks (VenueId, UserId, BookingId, Rating, Comment) 
                                     VALUES (@vid, @uid, @bid, @rate, @com)";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@vid", venueId);
                    cmd.Parameters.AddWithValue("@uid", userId);
                    cmd.Parameters.AddWithValue("@bid", _bookingId); // Saved here
                    cmd.Parameters.AddWithValue("@rate", rating);
                    cmd.Parameters.AddWithValue("@com", comment);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    Response.Redirect("~/UserDashboard.aspx?feedback=success");
                }
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "Database Error: " + ex.Message;
            }
        }
    }
}