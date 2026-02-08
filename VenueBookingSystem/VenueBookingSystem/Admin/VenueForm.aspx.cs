using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VenueBookingSystem.Admin
{
    public partial class VenueForm : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IsUserLoggedIn"] == null ||
                Session["UserRole"] == null ||
                Session["UserRole"].ToString() != "Admin")
            {
                Response.Redirect("~/Login.aspx");
            }
            Session.Timeout = 60;

            if (!IsPostBack)
            {
                PopulateImageDropdown();

                if (Request.QueryString["VenueId"] != null && int.TryParse(Request.QueryString["VenueId"], out int venueId))
                {
                    hfVenueId.Value = venueId.ToString();
                    LoadVenueData(venueId);
                    btnSave.Text = "Update Venue";
                    litTitle.Text = "Edit Venue Details";
                }
                else
                {
                    hfVenueId.Value = "";
                    btnSave.Text = "Add Venue";
                }
            }
        }

        private void PopulateImageDropdown()
        {
            string folderPath = Server.MapPath("~/Images");
            if (Directory.Exists(folderPath))
            {
                string[] files = Directory.GetFiles(folderPath, "*.*");
                ddlImages.Items.Clear();
                ddlImages.Items.Add(new ListItem("-- Select Image --", ""));
                foreach (string file in files)
                {
                    string fileName = Path.GetFileName(file);
                    ddlImages.Items.Add(new ListItem(fileName, "Images/" + fileName));
                }
            }
        }

        private void LoadVenueData(int id)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Venues WHERE VenueId = @Id", conn);
                cmd.Parameters.AddWithValue("@Id", id);
                conn.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    txtName.Text = rdr["Name"].ToString();
                    txtDescription.Text = rdr["Description"].ToString();
                    ddlVenueType.SelectedValue = rdr["VenueType"].ToString(); // Assumes ddl has these values
                    txtCapacity.Text = rdr["Capacity"].ToString();
                    txtBasePrice.Text = rdr["BasePrice"].ToString();
                    txtCity.Text = rdr["City"].ToString();
                    txtEmail.Text = rdr["ContactEmail"].ToString();
                    txtPhone.Text = rdr["ContactPhone"].ToString();
                   
                    // Convert the bool from DB to "1" or "0" to match dropdown values
                    ddlIsAvailable.SelectedValue = Convert.ToBoolean(rdr["IsAvailable"]) ? "1" : "0";

                    if (ddlImages.Items.FindByValue(rdr["ImageUrl"].ToString()) != null)
                        ddlImages.SelectedValue = rdr["ImageUrl"].ToString();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("sp_UpsertVenue", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                int venueId = string.IsNullOrEmpty(hfVenueId.Value) ? 0 : Convert.ToInt32(hfVenueId.Value);

                cmd.Parameters.AddWithValue("@VenueId", venueId);
                cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@VenueType", ddlVenueType.SelectedValue);
                cmd.Parameters.AddWithValue("@Capacity", txtCapacity.Text.Trim());
                cmd.Parameters.AddWithValue("@BasePrice", txtBasePrice.Text.Trim());
                cmd.Parameters.AddWithValue("@City", txtCity.Text.Trim());
                cmd.Parameters.AddWithValue("@ContactEmail", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@ContactPhone", txtPhone.Text.Trim());
                cmd.Parameters.AddWithValue("@ImageUrl", ddlImages.SelectedValue);

                // Use ddlIsAvailable.SelectedValue directly (it will be passed as 1 or 0 to the BIT column)
                cmd.Parameters.AddWithValue("@IsAvailable", ddlIsAvailable.SelectedValue);

                try
                {
                    conn.Open();
                    int rows = cmd.ExecuteNonQuery();
                    Response.Write("Rows inserted!: " + rows);
                    Response.Redirect("ManageVenues.aspx?msg=success");
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
            }
        }
    }
}