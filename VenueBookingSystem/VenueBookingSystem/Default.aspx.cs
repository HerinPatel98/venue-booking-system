using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VenueBookingSystem
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BindTopRatedVenues();
            BindReview();
        }

        private void BindReview()
        {
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;
            string query = @"SELECT TOP 3 
	            f.Comment AS comment, u.City AS city
            FROM 
	            Feedbacks f, Users u
            WHERE
	            f.UserId = u.UserId
            ORDER BY
	            Rating
            DESC";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    RepeaterReviews.DataSource = dt;
                    RepeaterReviews.DataBind();
                }
            }
        }

        private void BindTopRatedVenues()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;

            // SQL Logic: Join Venues with Average of Feedbacks, Take TOP 3
            string query = @"
        SELECT TOP 3 
            V.VenueId, V.Name, V.ImageUrl, V.City, V.BasePrice,
            ISNULL(AVG(CAST(F.Rating AS DECIMAL(10,2))), 0) AS AvgRating,
            COUNT(F.FeedbackId) AS ReviewCount
        FROM Venues V
        LEFT JOIN Feedbacks F ON V.VenueId = F.VenueId
        WHERE V.IsAvailable = 1
        GROUP BY V.VenueId, V.Name, V.ImageUrl, V.City, V.BasePrice
        ORDER BY AvgRating DESC, ReviewCount DESC";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Bind to your Repeater or DataList
                    RepeaterTopVenues.DataSource = dt;
                    RepeaterTopVenues.DataBind();
                }
            }
        }
    }
}