<%@ Page Title="Book Your Spot" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VenueDetails.aspx.cs" Inherits="VenueBookingSystem.VenueDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-3 mb-5">
        <!-- Breadcrumb Navigation -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb bg-transparent p-0">
                <li class="breadcrumb-item"><a href="Default.aspx" class="text-decoration-none">Home</a></li>
                <li class="breadcrumb-item"><a href="ListVenues.aspx" class="text-decoration-none">Venues</a></li>
                <li class="breadcrumb-item active">Details</li>
            </ol>
        </nav>

        <div class="row g-4 mt-2">
            <!-- LEFT COLUMN: Image & Info -->
            <div class="col-md-8">
                <div class="card border-0 shadow-sm p-4">
                    <div class="row">
                        <!-- Image Area (Normal size to prevent pixelation) -->
                        <div class="col-md-5 mb-3">
                            <asp:Image ID="imgVenue" runat="server" CssClass="img-fluid rounded shadow-sm border" 
                                style="max-height: 300px; width: auto; display: block;" />
                        </div>
                        <!-- Quick Title & Rating -->
                        <div class="col-md-7">
                            <h1 class="fw-bold" style="color: #00796b;"><asp:Label ID="lblVenueName" runat="server"></asp:Label></h1>
                            <div class="mb-2">
                                <span class="badge bg-light shadow-sm text-dark p-2">⭐ <asp:Label ID="lblAvgRating" runat="server" Text="0.0"></asp:Label></span>
                                <span class="text-muted ms-2">(<asp:Label ID="lblReviewCount" runat="server" Text="0"></asp:Label> Reviews)</span>
                            </div>
                            <p class="text-muted mt-3">📍 <asp:Label ID="lblCity" runat="server"></asp:Label> | 👥 Max Capacity: <asp:Label ID="lblCapacity" runat="server"></asp:Label> Guests</p>
                        </div>
                    </div>

                    <hr />

                    <!-- Detailed Description -->
                    <h5 class="fw-bold mt-3" style="color: #00796b;">About this Venue</h5>
                    <p class="text-secondary lead" style="font-size: 1rem;"><asp:Label ID="lblDescription" runat="server"></asp:Label></p>
                    
                    <hr />

                    <!-- AMENITIES SECTION (Add-ons) -->
                    <h5 class="fw-bold mb-3" style="color: #00796b;">Additional Amenities</h5>
                    <div class="row bg-light p-3 rounded border">
                        <div class="col-md-6">
                            <asp:CheckBox ID="chkCatering" runat="server" Text=" &nbsp; Catering Service (₹500/guest)" CssClass="form-check-label mb-2 d-block" AutoPostBack="true" OnCheckedChanged="CalculateTotal" />
                            <asp:CheckBox ID="chkDecoration" runat="server" Text=" &nbsp; Theme Decoration (₹5,000)" CssClass="form-check-label mb-2 d-block" AutoPostBack="true" OnCheckedChanged="CalculateTotal" />
                        </div>
                        <div class="col-md-6">
                            <asp:CheckBox ID="chkDJ" runat="server" Text=" &nbsp; Sound System & DJ (₹3,000)" CssClass="form-check-label mb-2 d-block" AutoPostBack="true" OnCheckedChanged="CalculateTotal" />
                            <asp:CheckBox ID="chkPhotography" runat="server" Text=" &nbsp; Photography (₹7,000)" CssClass="form-check-label mb-2 d-block" AutoPostBack="true" OnCheckedChanged="CalculateTotal" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- RIGHT COLUMN: Sticky Booking Sidebar -->
            <div class="col-md-4">
                <div class="card shadow border-0 sticky-top" style="top: 100px; border-top: 5px solid #009688 !important;">
                    <div class="card-body p-4">
                        <h4 class="mb-4 fw-bold" style="color: #00796b;">Reserve Now</h4>
                        
                        <!-- Date Selection -->
                        <div class="mb-4">
                            <label class="form-label text-muted small fw-bold">EVENT DATE</label>
                            <asp:TextBox ID="txtBookingDate" runat="server" CssClass="form-control form-control-lg" TextMode="Date"></asp:TextBox>
                        </div>

                        <!-- Price Breakdown -->
                        <div class="d-flex justify-content-between mb-2">
                            <span>Base Venue Price</span>
                            <span class="fw-bold">₹<asp:Label ID="lblBasePriceDisplay" runat="server" Text="0"></asp:Label></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2 text-success small">
                            <span>Total Amenities</span>
                            <span>+ ₹<asp:Label ID="lblAmenitiesPrice" runat="server" Text="0"></asp:Label></span>
                        </div>
                        <hr />
                        <div class="d-flex justify-content-between mb-4">
                            <h5 class="fw-bold">Total (Est.)</h5>
                            <h5 class="fw-bold text-primary">₹<asp:Label ID="lblTotalPrice" runat="server" Text="0"></asp:Label></h5>
                        </div>

                        <asp:Button ID="btnRequestBooking" runat="server" Text="Request to Book" 
                            OnClick="btnRequestBooking_Click" CssClass="btn btn-primary btn-lg w-100 py-3 shadow-sm fw-bold" />
                        
                        <p class="text-muted small text-center mt-3 mb-0">
                            No immediate payment required. Admin will review and confirm availability.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
