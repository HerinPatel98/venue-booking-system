using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VenueBookingSystem
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear all session variables created during login
            Session.Clear();
            Session.Abandon();

            // Optional, use if you manage cookies for remember me features
            //FormsAuthentication.SignOut();

            // Redirect the user back to the common Index/Landing Page (Default.aspx)
            Response.Redirect("~/Default.aspx");
        }
    }
}