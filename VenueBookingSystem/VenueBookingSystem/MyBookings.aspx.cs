using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace VenueBookingSystem
{
    public partial class MyBookings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 2026 Security: Ensure user is logged in
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadUserBookings();
            }
        }

        private void LoadUserBookings()
        {
            string connString = ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;
            int currentUserId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // JOIN Bookings with Venues to show the Venue Name instead of an ID
                string query = @"SELECT B.BookingId, V.Name as VenueName, B.BookingDate, 
                                 B.BookingStatus, B.TotalCost 
                                 FROM Bookings B 
                                 JOIN Venues V ON B.VenueId = V.VenueId 
                                 WHERE B.UserId = @uid 
                                 ORDER BY B.BookingDate DESC";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@uid", currentUserId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvUserBookings.DataSource = dt;
                gvUserBookings.DataBind();
            }
        }

        protected void gvUserBookings_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // Simple CRUD: Handle the "Cancel" action
            if (e.CommandName == "CancelBooking")
            {
                int bookingId = Convert.ToInt32(e.CommandArgument);
                UpdateBookingStatus(bookingId, "Cancelled");
            }
        }

        private void UpdateBookingStatus(int bId, string status)
        {
            string connString = ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Update status to Cancelled (Simple Delete-alternative for history)
                string query = "UPDATE Bookings SET BookingStatus = @status WHERE BookingId = @bid";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@status", status);
                cmd.Parameters.AddWithValue("@bid", bId);

                conn.Open();
                cmd.ExecuteNonQuery();

                // Refresh the table
                LoadUserBookings();

                // Optional: Browser alert for success
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Booking has been cancelled successfully.');", true);
            }
        }
    }
}
