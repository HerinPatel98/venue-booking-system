using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

namespace VenueBookingSystem
{
    public partial class ListVenues : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {  
            // Sets the minimum selectable date to Today (format: YYYY-MM-DD)
            txtBookingDate.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-dd");
        
            if (!IsPostBack)
            {    
                // Optional: Set default value to today so it's not empty
                txtBookingDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                //BindRepeater();
                PopulateVenueTypeCheckboxes();
                PopulateCityCheckboxes(); 
                
                if (Session["UserCity"] != null)
                {
                    string loggedInUserCity = Session["UserCity"].ToString().TrimEnd();

                    // 3. Try to find and check this city in our filter list
                    ListItem cityItem = cblCity.Items.FindByValue(loggedInUserCity);
                    if (cityItem != null)
                    {
                        cityItem.Selected = true; // Auto-check the user's home city
                        BindRepeater();
                    }
                }
            }

            if (Session["IsUserLoggedIn"] == null || !(bool)Session["IsUserLoggedIn"] )
            {
                // Redirect unauthorized users to the login page
                Response.Redirect("~/Login.aspx");
            }            
        }

        protected void btnApplyFilters_Click(object sender, EventArgs e)
        {
            BindRepeater();
        }

        private void BindRepeater()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;

            // Start building the base query
            StringBuilder queryBuilder = new StringBuilder("SELECT * FROM Venues WHERE IsAvailable = 1");
            List<SqlParameter> parameters = new List<SqlParameter>();

            // --- Apply Date Filter if specified ---
            if (DateTime.TryParse(txtBookingDate.Text, out DateTime selectedDate))
            {
                queryBuilder.Append(@"
                    AND NOT EXISTS (
                        SELECT 1 FROM Bookings B
                        WHERE B.VenueId = Venues.VenueId
                        AND B.BookingDate = @SelectedDate
                        AND B.BookingStatus = 'Confirmed'
                    )
                ");
                parameters.Add(new SqlParameter("@SelectedDate", selectedDate.Date));
            }

            // --- 1. Apply City Filters (Checkboxes) ---
            List<string> selectedCities = GetSelectedItems(cblCity);
            if (selectedCities.Count > 0)
            {
                queryBuilder.Append(" AND City IN (");
                for (int i = 0; i < selectedCities.Count; i++)
                {
                    string paramName = "@City" + i;
                    queryBuilder.Append(paramName);
                    if (i < selectedCities.Count - 1)
                        queryBuilder.Append(", ");
                    parameters.Add(new SqlParameter(paramName, selectedCities[i]));
                }
                queryBuilder.Append(")");
            }

            // --- 2. Apply Venue Type Filters (Checkboxes) ---
            List<string> selectedTypes = GetSelectedItems(cblVenueType);
            if (selectedTypes.Count > 0)
            {
                queryBuilder.Append(" AND VenueType IN (");
                for (int i = 0; i < selectedTypes.Count; i++)
                {
                    string paramName = "@Type" + i;
                    queryBuilder.Append(paramName);
                    if (i < selectedTypes.Count - 1)
                        queryBuilder.Append(", ");
                    parameters.Add(new SqlParameter(paramName, selectedTypes[i]));
                }
                queryBuilder.Append(")");
            }

            // --- 3. Apply Capacity Filter (TextBox) ---
            if (int.TryParse(txtCapacity.Text, out int minCapacity) && minCapacity > 0)
            {
                queryBuilder.Append(" AND Capacity >= @MinCapacity");
                parameters.Add(new SqlParameter("@MinCapacity", minCapacity));
            }

            // --- Finalize Query ---
            queryBuilder.Append(" ORDER BY City, Name");

            // Execute the query
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(queryBuilder.ToString(), conn))
                {
                    // Add all dynamically generated parameters to the command
                    cmd.Parameters.AddRange(parameters.ToArray());
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        RepeaterVenues.DataSource = dt;
                        RepeaterVenues.DataBind();
                        lblNoVenues.Visible = false;
                    }
                    else
                    {
                        RepeaterVenues.DataSource = null;
                        RepeaterVenues.DataBind();
                        lblNoVenues.Visible = true;
                    }
                }
            }
        }

        private void PopulateVenueTypeCheckboxes()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;
            string query = "SELECT DISTINCT VenueType FROM Venues ORDER BY VenueType";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    // Clear any existing VenueType
                    cblVenueType.Items.Clear();
                    while (reader.Read())
                    {
                        cblVenueType.Items.Add(new ListItem(reader["VenueType"].ToString(), reader["VenueType"].ToString()));
                    }
                }
            }
        }

        private void PopulateCityCheckboxes()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyBookingDBConnString"].ConnectionString;
            string query = "SELECT DISTINCT City FROM Venues WHERE IsAvailable = 1 ORDER BY City";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    // Clear any existing items first
                    cblCity.Items.Clear();

                    while (reader.Read())
                    {
                        // Add a new checkbox item for each unique city found
                        cblCity.Items.Add(new ListItem(reader["City"].ToString(), reader["City"].ToString()));
                    }
                }
            }
        }

        // Helper method to extract selected values from a CheckBoxList control
        private List<string> GetSelectedItems(CheckBoxList cbl)
        {
            List<string> selectedItems = new List<string>();
            foreach (ListItem item in cbl.Items)
            {
                if (item.Selected)
                {
                    selectedItems.Add(item.Value);
                }
            }
            return selectedItems;
        }

    }
}