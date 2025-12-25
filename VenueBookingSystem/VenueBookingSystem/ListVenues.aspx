<%@ Page Title="Browse Venues" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListVenues.aspx.cs" Inherits="VenueBookingSystem.ListVenues" %>
<asp:Content ID="ContentListHead" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .venue-img {
            height: 200px; /* Made slightly smaller for a better sidebar card look */
            width: 100%; 
            object-fit: cover; 
        }
    </style>
</asp:Content>
<asp:Content ID="ContentListBody" ContentPlaceHolderID="MainContent" runat="server">
     <div class="container-fluid mt-4">
        <h1 style="color: #00796b;">Available Venues</h1>
        <p class="lead text-muted">Browse and filter our selection of venues across major cities.</p>
        <hr />
        <div class="row">
            
            <!-- Left Column: Sidebar Filters (col-md-3) -->
            <div class="col-md-3">
                <div class="card shadow-sm mb-4">
                    <div class="card-header" style="background-color: #e0f2f1;">
                        <strong>Filter Venues</strong>
                    </div>
                    <div class="card-body">
                         <%-- Date Picker Input --%>
                         <h6 class="card-title" style="color: #00796b;">Booking Date</h6>
                         <asp:TextBox ID="txtBookingDate" runat="server" CssClass="form-control mb-3" TextMode="Date"></asp:TextBox>
                        
                        <%-- City Checkboxes --%>
                        <h6 class="card-title" style="color: #00796b;">City</h6>
                        <asp:CheckBoxList ID="cblCity" runat="server" CssClass="list-unstyled mb-3">
                            <%-- Dynamically cities will get added here --%>
                        </asp:CheckBoxList>

                        <%-- Venue Type Checkboxes --%>
                        <h6 class="card-title" style="color: #00796b;">Venue Type</h6>
                        <asp:CheckBoxList ID="cblVenueType" runat="server" CssClass="list-unstyled mb-3">
                            <%-- Dynamically Venue types will add here --%>
                        </asp:CheckBoxList>

                        <%-- Capacity Input --%>
                         <h6 class="card-title" style="color: #00796b;">Minimum Capacity</h6>
                         <asp:TextBox ID="txtCapacity" runat="server" CssClass="form-control mb-3" TextMode="Number" placeholder="Min guests"></asp:TextBox>

                        <%-- The Filter Button (needed to trigger postback in Web Forms) --%>
                        <asp:Button ID="btnApplyFilters" runat="server" Text="Apply Filters" OnClick="btnApplyFilters_Click" CssClass="btn btn-primary w-100" />
                    </div>
                </div>
            </div>

            <!-- Right Column: Venue List Results (col-md-9) -->
            <div class="col-md-9">
                <asp:Repeater ID="RepeaterVenues" runat="server">
                    <ItemTemplate>
                        <!-- Reusing the card design from Default.aspx -->
                        <div class="card shadow-sm border-0 mb-4">
                            <div class="row g-0">
                                <div class="col-md-4">
                                    <img src='<%# Eval("ImageUrl") %>' class="img-fluid rounded-start venue-img" alt='<%# Eval("Name") %>' />
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h4 class="card-title"><%# Eval("Name") %></h4>
                                        <p class="card-text"><%# Eval("Description") %></p>
                                        <ul class="list-inline mb-2">
                                            <li class="list-inline-item"><strong>City:</strong> <%# Eval("City") %></li>
                                            <li class="list-inline-item">| <strong>Capacity:</strong> <%# Eval("Capacity") %> guests</li>
                                            <li class="list-inline-item">| <strong>Type:</strong> <%# Eval("VenueType") %></li>
                                        </ul>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <h5 class="text-primary">₹<%# Eval("BasePrice", "{0:N0}") %></h5>
                                            <a href='VenueDetails.aspx?VenueId=<%# Eval("VenueId") %>' class="btn btn-primary">Book Now</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:Label ID="lblNoVenues" runat="server" Text="No venues found matching your criteria." Visible="false" CssClass="alert alert-info"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>
