using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VenueBookingSystem
{
    public partial class UserDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Manual security check using Session variables
            if (Session["IsUserLoggedIn"] == null || !(bool)Session["IsUserLoggedIn"] || Session["UserRole"].ToString() != "User")
            {
                // Redirect unauthorized users to the login page
                Response.Redirect("~/Login.aspx");
            }

            // 2. Display the full name in the welcome label
            if (Session["FullName"] != null)
            {
                lblFullName.Text = Session["FullName"].ToString();
            }
        }
    }
}