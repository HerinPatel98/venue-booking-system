using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VenueBookingSystem
{
    public partial class VenueDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        { 
            // Sets the minimum selectable date to Today (format: YYYY-MM-DD)
            txtBookingDate.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-dd");
            
            
            if (!IsPostBack)
            {
                // Optional: Set default value to today so it's not empty
                txtBookingDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

                string vId = Request.QueryString["VenueId"];
                string date = Request.QueryString["date"];

                if (!string.IsNullOrEmpty(date))
                {
                    txtBookingDate.Text = date;
                }

                if (!string.IsNullOrEmpty(vId))
                {
                    LoadVenue(vId);
                }
               
                CalculateTotal(null, null); // Initial math
            }
        }

        private void LoadVenue(string id)
        {
            string conn = ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;
            using (SqlConnection sqlConn = new SqlConnection(conn))
            {
                string query = "SELECT V.*, (SELECT ISNULL(AVG(CAST(Rating AS DECIMAL(10,2))), 0) FROM Feedbacks WHERE VenueId = V.VenueId) as AvgRating, " +
                               "(SELECT COUNT(*) FROM Feedbacks WHERE VenueId = V.VenueId) as ReviewCount " +
                               "FROM Venues V WHERE V.VenueId = @id";

                SqlCommand cmd = new SqlCommand(query, sqlConn);
                cmd.Parameters.AddWithValue("@id", id);
                sqlConn.Open();

                SqlDataReader r = cmd.ExecuteReader();

                if (r.Read())
                {
                    lblVenueName.Text = r["Name"].ToString();
                    lblDescription.Text = r["Description"].ToString();
                    lblBasePriceDisplay.Text = Convert.ToDecimal(r["BasePrice"]).ToString("N0");
                    ViewState["BasePrice"] = r["BasePrice"]; // Save for math
                    lblCity.Text = r["City"].ToString();
                    lblCapacity.Text = r["Capacity"].ToString();
                    imgVenue.ImageUrl = r["ImageUrl"].ToString();
                    lblAvgRating.Text = Convert.ToDecimal(r["AvgRating"]).ToString("F1");
                    lblReviewCount.Text = r["ReviewCount"].ToString();
                }
            }
        }

        protected void CalculateTotal(object sender, EventArgs e)
        {
            decimal basePrice = ViewState["BasePrice"] != null ? Convert.ToDecimal(ViewState["BasePrice"]) : 0;
             // int capacity = ViewState["Capacity"] != null ? Convert.ToInt32(ViewState["Capacity"]) : 0;
            decimal amenities = 0;

            if (chkCatering.Checked)
                amenities += (basePrice * 25/100);
            if (chkDecoration.Checked)
                amenities += 5000;
            if (chkDJ.Checked)
                amenities += 3000;
            if (chkPhotography.Checked)
                amenities += 7000;

            lblAmenitiesPrice.Text = amenities.ToString("N0");
            lblTotalPrice.Text = (basePrice + amenities).ToString("N0");
        }

        protected void btnRequestBooking_Click(object sender, EventArgs e)
        {
            // 1. Security Check: Redirect to login if not logged in
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx?msg=Please login to book a venue");
                return;
            }

            string venueId = Request.QueryString["VenueId"];
            string bookingDate = txtBookingDate.Text;

            int userId = Convert.ToInt32(Session["UserId"]);
            decimal totalCost = Convert.ToDecimal(lblTotalPrice.Text.Replace(",", ""));

            // 2. Simple Date Validation
            //if (string.IsNullOrEmpty(bookingDate) || DateTime.Parse(bookingDate) < DateTime.Now)
            //{
            //    // You could add an error label here
            //    return;
            //}

            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // 3. Final Availability Check (Last line of defense)
                string checkQuery = "SELECT COUNT(*) FROM Bookings WHERE VenueId = @vid AND BookingDate = @bdate AND BookingStatus = 'Confirmed'";
                SqlCommand checkCmd = new SqlCommand(checkQuery, conn);

                checkCmd.Parameters.AddWithValue("@vid", venueId);
                checkCmd.Parameters.AddWithValue("@bdate", bookingDate);

                int existingBookings = (int)checkCmd.ExecuteScalar();

                if (existingBookings > 0)
                {
                    // Script to show a simple browser alert if already booked
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Sorry! This date was just taken. Please choose another.');", true);
                    return;
                }

                // 4. Insert the Booking Request
                string insertQuery = @"INSERT INTO Bookings (UserId, VenueId, BookingDate, BookingStatus, PaymentStatus, TotalCost, RequestedDate) 
                               VALUES (@uid, @vid, @bdate, 'Pending', 'Unpaid', @cost, GETDATE())";

                SqlCommand insertCmd = new SqlCommand(insertQuery, conn);
                insertCmd.Parameters.AddWithValue("@uid", userId);
                insertCmd.Parameters.AddWithValue("@vid", venueId);
                insertCmd.Parameters.AddWithValue("@bdate", bookingDate);
                insertCmd.Parameters.AddWithValue("@cost", totalCost);

                insertCmd.ExecuteNonQuery();

                // 5. Redirect to User Dashboard with a Success Message
                Response.Redirect("~/UserDashboard.aspx?status=success");
            }
        }
    }
}