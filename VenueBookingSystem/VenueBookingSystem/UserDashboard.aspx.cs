using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;

namespace VenueBookingSystem
{
    public partial class UserDashboard : System.Web.UI.Page
    {
        string ConnString => ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            // CRITICAL FIX: Load data EVERY time.
            // If we wrap this in !IsPostBack, the GridView is empty when the button click event tries to fire.
            LoadRecentBookings();

            if (!IsPostBack)
            {
                // Handle Success Messages
                if (Request.QueryString["feedback"] == "success")
                {
                    phSuccessMessage.Visible = true;
                    var lbl = phSuccessMessage.FindControl("lblSuccessText") as System.Web.UI.HtmlControls.HtmlGenericControl;
                    if (lbl != null)
                        lbl.InnerHtml = "<strong>Thank you!</strong> Your review has been submitted.";
                }
                else if (Request.QueryString["status"] == "success")
                {
                    phSuccessMessage.Visible = true;
                }
            }
        }

        private void LoadRecentBookings()
        {
            using (SqlConnection conn = new SqlConnection(ConnString))
            {
                // We add a subquery to count reviews for EACH booking ID
                string query = @"SELECT TOP 3 B.BookingId, V.Name as VenueName, B.BookingDate, B.BookingStatus,
                         (SELECT COUNT(*) FROM Feedbacks F WHERE F.BookingId = B.BookingId) as ReviewCount
                         FROM Bookings B 
                         JOIN Venues V ON B.VenueId = V.VenueId 
                         WHERE B.UserId = @uid 
                         ORDER BY B.BookingDate DESC";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@uid", Convert.ToInt32(Session["UserId"]));

                try
                {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvRecentBookings.DataSource = dt;
                    gvRecentBookings.DataBind();
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Dashboard Error: " + ex.Message);
                }
            }
        }

        protected void gvRecentBookings_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "RateVenue")
            {
                try
                {
                    // 1. Get the Row Index
                    int rowIndex = Convert.ToInt32(e.CommandArgument);

                    // 2. Get the Booking ID from DataKeys (Safe method)
                    // This retrieves the ID stored in DataKeyNames="BookingId" for that specific row
                    int bookingId = Convert.ToInt32(gvRecentBookings.DataKeys[rowIndex].Value);

                    // 3. Redirect
                    Response.Redirect($"~/AddFeedback.aspx?bid={bookingId}");
                }
                catch (Exception ex)
                {
                    // If something fails (like bad index), log it
                    System.Diagnostics.Debug.WriteLine("RowCommand Error: " + ex.Message);
                }
            }
        }

        // Helper for status colors
        protected string GetStatusClass(string status)
        {
            if (status == "Confirmed")
                return "bg-success";
            if (status == "Pending")
                return "bg-warning text-dark";
            return "bg-secondary";
        }
    }
}