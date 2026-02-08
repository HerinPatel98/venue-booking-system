using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace VenueBookingSystem.Admin
{
    public partial class ManageBookings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
                Response.Redirect("~/Login.aspx");

            LoadBookings();
        }

        private void LoadBookings()
        {
            string conn = ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;
            using (SqlConnection sqlConn = new SqlConnection(conn))
            {
                string query = @"SELECT B.*, U.FullName, V.Name as VenueName 
                                 FROM Bookings B 
                                 JOIN Users U ON B.UserId = U.UserId 
                                 JOIN Venues V ON B.VenueId = V.VenueId 
                                 ORDER BY B.RequestedDate DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, sqlConn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvAllBookings.DataSource = dt;
                gvAllBookings.DataBind();
            }
        }

        protected void gvAllBookings_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (string.IsNullOrEmpty(e.CommandArgument.ToString()))
                return;

            try
            {
                int bId = Convert.ToInt32(e.CommandArgument);
                string statusUpdate = "";
                string column = "BookingStatus";

                if (e.CommandName == "Confirm")
                    statusUpdate = "Confirmed";
                else if (e.CommandName == "Reject")
                    statusUpdate = "Cancelled";
                else if (e.CommandName == "MarkPaid")
                {
                    statusUpdate = "Paid";
                    column = "PaymentStatus";
                }

                if (!string.IsNullOrEmpty(statusUpdate))
                {
                    bool success = UpdateDatabase(bId, column, statusUpdate);
                    if (success)
                    {
                        LoadBookings();
                        lblAdminMsg.Text = "Status updated successfully!";
                        lblAdminMsg.CssClass = "badge bg-success p-2";
                        lblAdminMsg.Visible = true;
                    }
                    else
                    {
                        lblAdminMsg.Text = "Failed to update status.";
                        lblAdminMsg.CssClass = "badge bg-danger p-2";
                        lblAdminMsg.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                lblAdminMsg.Text = $"Error: {ex.Message}";
                lblAdminMsg.CssClass = "badge bg-danger p-2";
                lblAdminMsg.Visible = true;
                System.Diagnostics.Debug.WriteLine($"RowCommand Error: {ex.Message}");
            }
        }

        private bool UpdateDatabase(int id, string col, string val)
        {
            string conn = ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(conn))
                {
                    string query = $"UPDATE Bookings SET {col} = @val WHERE BookingId = @id";
                    SqlCommand cmd = new SqlCommand(query, sqlConn);
                    cmd.Parameters.AddWithValue("@val", val);
                    cmd.Parameters.AddWithValue("@id", id);

                    sqlConn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    System.Diagnostics.Debug.WriteLine($"Update result: {rowsAffected} rows affected");
                    return rowsAffected > 0;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Database Error: {ex.Message}");
                throw;
            }
            finally
            {
                LoadBookings();
            }
        }

        protected string GetStatusClass(string status)
        {
            status = status.ToLower();
            if (status == "confirmed")
                return "bg-success";

            if (status == "pending")
                return "bg-warning text-dark";

            if (status == "cancelled")
                return "bg-danger";

            return "";
        }
    }
}
