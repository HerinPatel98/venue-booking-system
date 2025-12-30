<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="VenueBookingSystem.Admin.Dashboard" %>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <div class="container-fluid mt-4">
        <h2 class="mb-4" style="color: #263238;">Admin Control Center <small class="text-muted">| Golden Petal Venues</small></h2>
        
        <!-- KPI Row -->
        <div class="row g-4 mb-5">
            <!-- Total Revenue Card -->
            <div class="col-md-3">
                <div class="card shadow-sm admin-card-gold h-100">
                    <div class="card-body">
                        <div class="stat-label">Total Revenue</div>
                        <div class="stat-number">₹<asp:Label ID="lblTotalRevenue" runat="server" Text="0"></asp:Label></div>
                    </div>
                </div>
            </div>

            <!-- Pending Bookings Card -->
            <div class="col-md-3">
                <div class="card shadow-sm admin-card-teal h-100 border-start border-5 border-warning">
                    <div class="card-body">
                        <div class="stat-label">Pending Requests</div>
                        <div class="stat-number"><asp:Label ID="lblPendingBookings" runat="server" Text="0"></asp:Label></div>
                    </div>
                </div>
            </div>

            <!-- Total Venues Card -->
            <div class="col-md-3">
                <div class="card shadow-sm admin-card-teal h-100">
                    <div class="card-body">
                        <div class="stat-label">Active Venues</div>
                        <div class="stat-number"><asp:Label ID="lblTotalVenues" runat="server" Text="0"></asp:Label></div>
                    </div>
                </div>
            </div>

            <!-- Total Users Card -->
            <div class="col-md-3">
                <div class="card shadow-sm admin-card-teal h-100">
                    <div class="card-body">
                        <div class="stat-label">Registered Users</div>
                        <div class="stat-number"><asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Action Section -->
        <div class="row">
            <div class="col-md-12">
                <div class="card shadow-sm border-0 bg-dark text-white p-4">
                    <h4>Operations Quick Links</h4>
                    <div class="d-flex gap-3 mt-3">
                        <a href="ManageBookings.aspx" class="btn btn-warning text-dark fw-bold">Review Pending Bookings</a>
                        <a href="ManageVenues.aspx" class="btn btn-outline-light">Update Venue Pricing</a>
                        <a href="ManageReviews.aspx" class="btn btn-outline-light">Moderate Feedbacks</a>
                    </div>
                </div>
            </div>
        </div>
         <div class="row mt-5">
             <!-- Left Column: Recent Pending Bookings -->
             <div class="col-md-12">
                 <div class="card shadow-sm border-0 h-100">
                     <div class="card-header bg-white py-3">
                         <h5 class="mb-0" style="color: #263238;">Latest Pending Requests</h5>
                     </div>
                     <div class="card-body p-0">
                         <asp:GridView ID="gvRecentBookings" runat="server" CssClass="table table-hover mb-0" GridLines="None" AutoGenerateColumns="False">
                             <Columns>
                                 <asp:BoundField DataField="FullName" HeaderText="Customer" />
                                 <asp:BoundField DataField="VenueName" HeaderText="Venue" />
                                 <asp:BoundField DataField="BookingDate" HeaderText="Event Date" DataFormatString="{0:dd MMM yyyy}" />
                                 <asp:TemplateField HeaderText="Action">
                                     <ItemTemplate>
                                         <a href="ManageBookings.aspx" class="btn btn-sm btn-outline-teal">Review</a>
                                     </ItemTemplate>
                                 </asp:TemplateField>
                             </Columns>
                             <EmptyDataTemplate>
                                 <div class="p-4 text-center text-muted">No pending requests at the moment.</div>
                             </EmptyDataTemplate>
                         </asp:GridView>
                     </div>
                 </div>
             </div>
         </div>
    </div>
</asp:Content>
