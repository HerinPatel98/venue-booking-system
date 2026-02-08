<%@ Page Title="My Bookings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyBookings.aspx.cs" Inherits="VenueBookingSystem.MyBookings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ContentPlaceHolderID="BreadcrumbContent" runat="server">
    <a id="lnkManageVenues" runat="server" href="/UserDashboard.aspx" class="text-decoration-none" style="color: #00796b;">My Dashboard</a>
    <span class="mx-2 text-muted">/</span>
    <span class="fw-bold" style="color: #004d40;">My Bookings</span>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white py-3">
            <h4 class="mb-0" style="color: #00796b;">My Event Bookings</h4>
        </div>
        <div class="card-body p-0">
            <asp:GridView ID="gvUserBookings" runat="server" CssClass="table table-hover mb-0" 
                AutoGenerateColumns="False" GridLines="None" OnRowCommand="gvUserBookings_RowCommand">
                <Columns>
                    <asp:BoundField DataField="VenueName" HeaderText="Venue" />
                    <asp:BoundField DataField="BookingDate" HeaderText="Event Date" DataFormatString="{0:dd MMM yyyy}" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <!-- Visual Badges for 2026 Design -->
                            <span class='badge <%# Eval("BookingStatus").ToString() == "Confirmed" ? "bg-success" : "bg-warning text-dark" %>'>
                                <%# Eval("BookingStatus") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="TotalCost" HeaderText="Price" DataFormatString="₹{0:N0}" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelBooking" 
                                CommandArgument='<%# Eval("BookingId") %>' CssClass="btn btn-sm btn-outline-danger"
                                Visible='<%# Eval("BookingStatus").ToString() == "Pending" %>'>Cancel</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="p-5 text-center text-muted">You haven't made any bookings yet. <a href="ListVenues.aspx">Start browsing!</a></div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</div>

</asp:Content>
