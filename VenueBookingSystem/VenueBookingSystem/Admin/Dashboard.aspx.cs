using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace VenueBookingSystem.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadKpiCards();
                LoadRecentBookings(); // We will define this next
            }
        }

        private void LoadKpiCards()
        {
            string connString = ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // 1. Total Revenue (Sum of TotalCost for Confirmed bookings)
                string revQuery = "SELECT ISNULL(SUM(TotalCost), 0) FROM Bookings WHERE BookingStatus = 'Confirmed' AND PaymentStatus = 'Paid'";
                SqlCommand cmdRev = new SqlCommand(revQuery, conn);
                lblTotalRevenue.Text = Convert.ToDecimal(cmdRev.ExecuteScalar()).ToString("N0");

                // 2. Pending Requests (Count of Pending bookings)
                string pendQuery = "SELECT COUNT(*) FROM Bookings WHERE BookingStatus = 'Pending'";
                SqlCommand cmdPend = new SqlCommand(pendQuery, conn);
                lblPendingBookings.Text = cmdPend.ExecuteScalar().ToString();

                // 3. Active Venues (Count of Available venues)
                string venueQuery = "SELECT COUNT(*) FROM Venues WHERE IsAvailable = 1";
                SqlCommand cmdVenue = new SqlCommand(venueQuery, conn);
                lblTotalVenues.Text = cmdVenue.ExecuteScalar().ToString();

                // 4. Registered Users (Total count excluding Admin)
                string userQuery = "SELECT COUNT(*) FROM Users WHERE Role = 'User'";
                SqlCommand cmdUser = new SqlCommand(userQuery, conn);
                lblTotalUsers.Text = cmdUser.ExecuteScalar().ToString();
            }
        }

        private void LoadRecentBookings()
        {
            string connString = ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // 2025 Standard: Get Top 5 Pending Bookings with User and Venue details
                string query = @"
                    SELECT TOP 5 
                        U.FullName, 
                        V.Name as VenueName, 
                        B.BookingDate 
                    FROM Bookings B
                    JOIN Users U ON B.UserId = U.UserId
                    JOIN Venues V ON B.VenueId = V.VenueId
                    WHERE B.BookingStatus = 'Pending'
                    ORDER BY B.RequestedDate DESC";

                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                System.Data.DataTable dt = new System.Data.DataTable();
                da.Fill(dt);

                gvRecentBookings.DataSource = dt;
                gvRecentBookings.DataBind();
            }
        }
    }
}