<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserDashboard.aspx.cs" Inherits="VenueBookingSystem.UserDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <!-- Welcome Section using a card component with integrated buttons -->
    <div class="card shadow-sm mb-4" style="background-color: #e0f2f1; border-color: #009688;">
        <div class="card-body">
            <div class="row align-items-center">
                
                <!-- Welcome Text Column (takes up 9 of 12 columns on medium/large screens) -->
                <div class="col-md-9">
                    <h1 class="card-title" style="color: #009688;">Welcome Back, <asp:Label ID="lblFullName" runat="server" ForeColor="#0096889c" Text="User"></asp:Label>!</h1>
                    <p class="card-text">Manage your profile and review your upcoming event bookings.</p>
                </div>
                
                <!-- Buttons Column (takes up 3 of 12 columns, aligns text to end/right) -->
                <div class="col-md-3 text-md-end">
                    <!-- My Bookings Button -->
                    <a href="MyBookings.aspx" class="btn btn-primary w-100 mb-2">My Bookings</a>
                    
                    <!-- Log Out Button -->
                    <a href="Logout.aspx" class="btn btn-outline-secondary w-100">Log Out</a>
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
                            <img src="Images/resort3.jpg" class="d-block w-100 venue-carousel-img" alt="Terrace Hall">
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

    <!-- Navigation Links and other sections will go below here -->
    <div class="row">
        
        <!-- Quick Links (Left Column) -->
        <div class="col-md-4">
            <div class="card shadow-sm mb-4">
                <div class="card-header" style="background-color: #ffffff;">
                    Quick Actions
                </div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item"><a href="ListVenues.aspx" style="color: #00796b;">Browse Venues & Book</a></li>
                    <li class="list-group-item"><a href="UserDetails.aspx" style="color: #00796b;">Edit Profile Details</a></li>
                    <li class="list-group-item"><a href="ChangePassword.aspx" style="color: #00796b;">Change Password</a></li>
                </ul>
            </div>
        </div>

        <!-- Upcoming Bookings (Right Column) -->
        <div class="col-md-8">
            <div class="card shadow-sm mb-4">
                <div class="card-header" style="background-color: #ffffff;">
                    Your Latest Bookings
                </div>
                <div class="card-body">
                    <%-- We will use C# here later to populate this section dynamically --%>
                    <p class="card-text text-muted">*Dynamic booking data will appear here once you implement the MyBookings C# logic.*</p>
                    <a href="MyBookings.aspx" class="btn btn-outline-primary">View All Bookings</a>
                </div>
            </div>
        </div>
    </div>
    
</asp:Content>
