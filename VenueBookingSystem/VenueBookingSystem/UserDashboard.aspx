<%@ Page Title="User Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserDashboard.aspx.cs" Inherits="VenueBookingSystem.UserDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ContentPlaceHolderID="BreadcrumbContent" runat="server">
    <span class="fw-bold" style="color: #004d40;">My Dashboard</span>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <asp:PlaceHolder ID="phSuccessMessage" runat="server" Visible="false">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <span id="lblSuccessText" runat="server"><strong>Success!</strong> Your booking request has been sent to the Admin for approval.</span>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </asp:PlaceHolder>

     <div class="card shadow-sm mb-4" style="background-color: #e0f2f1; border-color: #009688;">
        <div class="card-body">
            <div class="row align-items-center">
                <div class="col-md-9">
                    <h2 class="card-title fw-bold" style="color: #00796b;">
                        Welcome back, <asp:Label ID="lblFullName" runat="server" Text="User"></asp:Label>!
                    </h2>
                    <p class="card-text text-muted">Manage your events, view status, and find new venues.</p>
                </div>
                <div class="col-md-3 text-end">
                    <a href="ListVenues.aspx" class="btn btn-primary btn-lg shadow-sm" style="background-color: #009688; border: none;">+ New Booking</a>
                </div>
            </div>
        </div>
    </div>

     <!-- Dedicated Section to Attract User to Browse Venues -->
    <div class="card shadow-lg mb-4 p-3" style="background-color: #ffffff;">
    <h3 class="text-center mb-4 mx-auto" style="color: #00796b;">Explore Venue Highlights</h3>

    <div id="venueCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="4500">
        <div class="carousel-inner">

            <!-- Carousel Item 1 -->
            <div class="carousel-item active">
                <!-- Added 'carousel-image-container' wrapper for the hover effect -->
                <a href="ListVenues.aspx" class="d-block w-50 carousel-image-container">
                    <img src="Images/resort1.jpg" class="d-block w-100 venue-carousel-img" alt="Grand Ballroom">
                    <!-- Custom Overlay Text -->
                    <div class="carousel-custom-overlay">
                        <h5>Browse More Venues</h5>
                    </div>
                </a>
            </div>

            <!-- Carousel Item 2 -->
            <div class="carousel-item">
                <a href="ListVenues.aspx" class="d-block w-50 carousel-image-container">
                    <img src="Images/resort2.jpg" class="d-block w-100 venue-carousel-img" alt="Garden Plot">
                    <div class="carousel-custom-overlay">
                        <h5>Browse More Venues</h5>
                    </div>
                </a>
            </div>

                <!-- Carousel Item 3 -->
                <div class="carousel-item align-items-center">
                    <a href="ListVenues.aspx" class="d-block w-50 carousel-image-container">
                        <img src="Images/gp1.jpg" class="d-block w-100 venue-carousel-img" alt="Terrace Hall">
                        <div class="carousel-custom-overlay">
                            <h5>Browse More Venues</h5>
                        </div>
                    </a>
                </div>
            

            <!-- Carousel Item 4 -->
            <div class="carousel-item align-items-center">
                <a href="ListVenues.aspx" class="d-block w-50 carousel-image-container">
                    <img src="Images/resort4.jpg" class="d-block w-100 venue-carousel-img" alt="Luxe Resort">
                    <div class="carousel-custom-overlay">
                        <h5>Browse More Venues</h5>
                    </div>
                </a>
            </div>
        </div>
    </div>
</div>

    <div class="row">
        <div class="col-md-4">
            <div class="card shadow-sm mb-4">
                <div class="card-header" style="background-color: #ffffff;">
                    Quick Actions
                </div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item"><a href="ListVenues.aspx" style="color: #00796b;">Browse Venues & Book</a></li>
                    <li class="list-group-item"><a href="MyBookings.aspx" style="color: #00796b;">Manage My Bookings</a></li>
                    <li class="list-group-item"><a href="ChangePassword.aspx" style="color: #00796b;">Change Password</a></li>
                </ul>
            </div>
        </div>

        <div class="col-md-8">
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0 text-muted">Recent Activity</h5>
                </div>
                <div class="card-body p-0">
                    
                    <asp:GridView ID="gvRecentBookings" runat="server" 
                        CssClass="table table-hover mb-0 align-middle" 
                        AutoGenerateColumns="False" 
                        GridLines="None" 
                        OnRowCommand="gvRecentBookings_RowCommand"
                        DataKeyNames="BookingId"
                        EnableViewState="true">
                        
                        <Columns>
                            <asp:BoundField DataField="VenueName" HeaderText="Venue" />
                            <asp:BoundField DataField="BookingDate" HeaderText="Date" DataFormatString="{0:dd MMM}" />
                            
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='badge <%# GetStatusClass(Eval("BookingStatus").ToString()) %>'>
                                        <%# Eval("BookingStatus") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <div class="d-flex align-items-center">
                                        <%-- Case 1: Booking is Confirmed but NOT yet reviewed --%>
                                        <asp:LinkButton ID="btnRate" runat="server"
                                            CommandName="RateVenue"
                                            CommandArgument='<%# Container.DataItemIndex %>'
                                            CssClass="btn btn-sm btn-outline-warning text-dark me-2"
                                            Visible='<%# Eval("BookingStatus").ToString() == "Confirmed" && Convert.ToInt32(Eval("ReviewCount")) == 0 %>'>
                                            <i class="bi bi-star-fill"></i> Rate
                                        </asp:LinkButton>

                                        <%-- Case 2: Booking is Confirmed AND already reviewed --%>
                                        <asp:Label ID="lblReviewed" runat="server"
                                            CssClass="badge bg-light text-success border border-success"
                                            Visible='<%# Eval("BookingStatus").ToString() == "Confirmed" && Convert.ToInt32(Eval("ReviewCount")) > 0 %>'
                                            Text="<i class='bi bi-check-circle'></i> Reviewed" />

                                        <%-- Case 3: Booking is Pending or Cancelled (No action needed) --%>
                                        <asp:Label ID="lblNoAction" runat="server"
                                            Text="-" CssClass="text-muted ms-3"
                                            Visible='<%# Eval("BookingStatus").ToString() != "Confirmed" %>' />
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>

                        <EmptyDataTemplate>
                            <div class="p-4 text-center text-muted">
                                No recent activity. <a href="ListVenues.aspx">Book a venue now!</a>
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>

                </div>
                <div class="card-footer bg-white text-end">
                     <a href="MyBookings.aspx" class="text-decoration-none small">View Full History &rarr;</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>