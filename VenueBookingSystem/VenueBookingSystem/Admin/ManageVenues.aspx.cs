using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace VenueBookingSystem.Admin
{
    public partial class ManageVenues : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
                Response.Redirect("~/Login.aspx");

            if (!IsPostBack)
                LoadVenues();
        }

        private void LoadVenues()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Venues ORDER BY Name", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvManageVenues.DataSource = dt;
                gvManageVenues.DataBind();
            }
        }

        protected void gvManageVenues_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int venueId = Convert.ToInt32(gvManageVenues.DataKeys[e.RowIndex].Value);
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // Note: In real-world apps, we usually set IsAvailable=0 instead of hard deleting
                string query = "DELETE FROM Venues WHERE VenueId = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", venueId);
                conn.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                    LoadVenues();
                }
                catch
                {
                    // Show error if venue has existing bookings
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Cannot delete venue with existing booking history.');", true);
                }
            }
        }
    }
}
