using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace VenueBookingSystem
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IsUserLoggedIn"] != null && (bool)Session["IsUserLoggedIn"] == true)
            {
                //this.DataBind();

                // If logged in: Hide Login/Register, Show Dashboard/Logout
                navLogin.Visible = false;
                navRegister.Visible = false;

                navLogout.Visible = true;
                navDashboard.Visible = true;

                navSwitchUser.Visible = true;

                // Check for admin role
                if (Session["UserRole"] != null && Session["UserRole"].ToString() == "Admin")
                {
                    navAdmin.Visible = true; // Show the admin panel link
                    navSwitchUser.Visible = true;
                }

                if (Session["IsUserLoggedIn"] != null && (bool)Session["IsUserLoggedIn"] == true)
                {
                    string role = Session["UserRole"]?.ToString();
                    if (role == "Admin")
                    {
                        phAdminSidebar.Visible = true; // Show sidebar
                        //navAbout.Visible = false;
                    }
                }
            }
            else
            {
                // If logged out: Show Login/Register, Hide Dashboards/Logout
                navLogin.Visible = true;
                navRegister.Visible = true;

                navLogout.Visible = false;
                navDashboard.Visible = false;
                navAdmin.Visible = false;

                navSwitchUser.Visible = false;
            }
        }

        protected void btnSwitchUser_Click(object sender, EventArgs e)
        {
            // 1. Clear the specific User Session variables [cite: 19]
            Session["UserId"] = null;
            Session["UserRole"] = null;
            Session["IsUserLoggedIn"] = false;

            // 2. Clear all other session data to prevent data leakage between users
            Session.Abandon();
            Session.Clear();

            // 3. Redirect to login with a 'switch' flag to provide a better UI experience
            Response.Redirect("~/Login.aspx?action=switch");
        }
    }
}