<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="VenueBookingSystem.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5 mb-5">
        <div class="row g-5">
            <!-- Left Side: Inquiry Form -->
            <div class="col-md-6">
                <div class="card shadow-sm border-0 p-4">
                    <h2 class="mb-4" style="color: #00796b;">Get in Touch</h2>
                    <p class="text-muted mb-4">Have questions about a venue or booking? Send us a message and we'll get back to you within 24 hours.</p>

                    <asp:Label ID="lblStatus" runat="server" CssClass="alert alert-success d-block mb-3" Visible="false"></asp:Label>

                    <div class="mb-3">
                        <label class="form-label">Your Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter your name"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="name@example.com"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Message</label>
                        <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="How can we help?"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnSend" runat="server" Text="Send Message" OnClick="btnSend_Click" CssClass="btn btn-primary btn-lg w-100" />
                </div>
            </div>

            <!-- Right Side: Contact Info & Map -->
            <%-- <div class="col-md-6">
                <div class="mb-4">
                    <h4 style="color: #00796b;">Contact Information</h4>
                    <p class="mb-1"><i class="bi bi-geo-alt-fill me-2" style="color: #009688;"></i> 123 Venue Street, Rajkot, Gujarat 360001</p>
                    <p class="mb-1"><i class="bi bi-telephone-fill me-2" style="color: #009688;"></i> +91 98765 43210</p>
                    <p class="mb-1"><i class="bi bi-envelope-fill me-2" style="color: #009688;"></i> support@venuebookpro.com</p>
                </div>--%>

            <!-- Google Maps Embed -->
           <div class="col-md-6">
    <div class="card shadow-sm border-0 h-100" style="border-left: 5px solid #009688 !important;">
        <div class="card-body p-4 p-md-5">
            <h4 class="mb-4" style="color: #00796b;">Our Office Location</h4>

            <!-- A large, stylized building symbol using pure CSS and Unicode -->
            <div class="text-center mb-5">
                <div style="font-size: 8rem; color: #009688; line-height: 1;">🏢</div>
                <p class="text-muted mt-2">VenueBook Pro Headquarters</p>
            </div>
            
            <h4 style="color: #00796b; border-bottom: 2px solid #e0f2f1; padding-bottom: 10px;">Contact Details</h4>
            
            <div class="mt-4">
                <div class="mb-4">
                    <span style="font-size: 1.5rem; margin-right: 10px;">📍</span>
                    <strong>Address:</strong>
                    <p class="ms-4 ps-2 text-muted">123 Venue Street, Rajkot, Gujarat 360001</p>
                </div>

                <div class="mb-4">
                    <span style="font-size: 1.5rem; margin-right: 10px;">📞</span>
                    <strong>Phone:</strong>
                    <p class="ms-4 ps-2 text-muted">+91 98765 43210</p>
                </div>

                <div class="mb-4">
                    <span style="font-size: 1.5rem; margin-right: 10px;">✉️</span>
                    <strong>Email:</strong>
                    <p class="ms-4 ps-2 text-muted">support@venuebookpro.com</p>
                </div>
            </div>
        </div>
    </div>
</div>
        </div>
    </div>
    </div>
</asp:Content>
