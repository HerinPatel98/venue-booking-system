using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VenueBookingSystem
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSend_Click(object sender, EventArgs e)
        {
            // Simulating message submission
            lblStatus.Text = "Thank you! Your message has been sent successfully.";
            lblStatus.Visible = true;

            // Clear fields
            txtName.Text = "";
            txtEmail.Text = "";
            txtMessage.Text = "";
        }

    }
}