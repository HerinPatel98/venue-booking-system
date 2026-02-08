using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace VenueBookingSystem
{
    public partial class MyBookings : System.Web.UI.Page
    {
        string ConnString = ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            // FORCE LOAD EVERY TIME
            // This fixes the "Disappearing Grid" issue by ensuring data is always bound
            // before any events fire.
            LoadUserBookings();
        }

        private void LoadUserBookings()
        {
            try
            {
                int currentUserId = Convert.ToInt32(Session["UserId"]);

                using (SqlConnection conn = new SqlConnection(ConnString))
                {
                    string query = @"SELECT B.BookingId, V.Name as VenueName, B.BookingDate, 
                                     B.BookingStatus, B.TotalCost 
                                     FROM Bookings B 
                                     JOIN Venues V ON B.VenueId = V.VenueId 
                                     WHERE B.UserId = @uid 
                                     ORDER BY B.BookingDate DESC";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@uid", currentUserId);

                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvUserBookings.DataSource = dt;
                    gvUserBookings.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblDebug.Text = "LOAD ERROR: " + ex.Message;
            }
        }

        protected void gvUserBookings_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // Clear previous messages
            lblDebug.Text = "";

            if (e.CommandName == "CancelBooking")
            {
                try
                {
                    // DEBUG: Show exactly what we are trying to cancel
                    string arg = e.CommandArgument.ToString();
                    lblDebug.Text = "Attempting to cancel Booking ID: " + arg;

                    int bookingId = Convert.ToInt32(arg);
                    bool success = UpdateBookingStatus(bookingId, "Cancelled");

                    if (success)
                    {
                        lblDebug.Text = "SUCCESS: Booking cancelled.";
                        lblDebug.ForeColor = System.Drawing.Color.Green;

                        // Reload to show the new "Cancelled" status
                        LoadUserBookings();
                    }
                    else
                    {
                        lblDebug.Text = "FAILURE: Could not cancel. It might not be 'Pending' anymore.";
                    }
                }
                catch (Exception ex)
                {
                    lblDebug.Text = "COMMAND ERROR: " + ex.Message;
                }
            }
        }

        private bool UpdateBookingStatus(int bId, string status)
        {
            using (SqlConnection conn = new SqlConnection(ConnString))
            {
                string query = @"UPDATE Bookings 
                                SET BookingStatus = @status 
                                WHERE BookingId = @bid 
                                AND BookingStatus = 'Pending'"; // STRICT CHECK

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@status", status);
                cmd.Parameters.AddWithValue("@bid", bId);

                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                return rows > 0;
            }
        }
    }
}