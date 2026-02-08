<%@ Page Title="Admin - Manage Bookings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageBookings.aspx.cs" Inherits="VenueBookingSystem.Admin.ManageBookings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ContentPlaceHolderID="BreadcrumbContent" runat="server">
    <a id="lnkManageVenues" runat="server" href="~/Admin/ManageBookings.aspx" class="text-decoration-none" style="color: #00796b;">Manage Bookings</a>
    <span class="mx-2 text-muted">/</span>
    <span class="fw-bold" style="color: #004d40;">Booking Details</span>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid mt-4">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                <h4 class="mb-0" style="color: #263238;">Manage All Booking Requests</h4>
                <asp:Label ID="lblAdminMsg" runat="server" CssClass="badge bg-info p-2" Visible="false"></asp:Label>
            </div>
            <div class="card-body p-0">
                <asp:GridView ID="gvAllBookings" runat="server" CssClass="table table-hover align-middle mb-0" 
                    AutoGenerateColumns="False" GridLines="None" 
                    OnRowCommand="gvAllBookings_RowCommand" CellPadding="4" ForeColor="#333333"
                    ClientIDMode="AutoID" EnableViewState="true">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="BookingId" HeaderText="ID" />
                        <asp:BoundField DataField="FullName" HeaderText="Customer" />
                        <asp:BoundField DataField="VenueName" HeaderText="Venue" />
                        <asp:BoundField DataField="BookingDate" HeaderText="Event Date" DataFormatString="{0:dd MMM yyyy}" />
                        
                        <asp:TemplateField HeaderText="Booking Status">
                            <ItemTemplate>
                                <span class='badge <%# GetStatusClass(Eval("BookingStatus").ToString()) %>'>
                                    <%# Eval("BookingStatus") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Payment Status">
                            <ItemTemplate>
                                <span class='badge <%# Eval("PaymentStatus").ToString() == "Paid" ? "bg-success" : "bg-secondary" %>'>
                                    <%# Eval("PaymentStatus") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="TotalCost" HeaderText="Total" DataFormatString="₹{0:N0}" />

                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <div class="btn-group">
                                    <asp:LinkButton ID="btnConfirm" runat="server" CommandName="Confirm" 
                                        CommandArgument='<%# Eval("BookingId") %>' 
                                        CssClass="btn btn-sm btn-success" 
                                        CausesValidation="false" ClientIDMode="AutoID"
                                        Visible='<%# Eval("BookingStatus").ToString().ToLower() == "pending" %>'>
                                        Confirm
                                    </asp:LinkButton>

                                     <asp:LinkButton ID="btnCancel" runat="server" CommandName="Reject" 
                                        CommandArgument='<%# Eval("BookingId") %>' 
                                        CssClass="btn btn-sm btn-danger" 
                                        CausesValidation="false" ClientIDMode="AutoID"
                                        Visible='<%# Eval("BookingStatus").ToString().ToLower() == "pending" %>'>Reject</asp:LinkButton>

                                    <asp:LinkButton ID="btnPaid" runat="server" CommandName="MarkPaid" 
                                        CommandArgument='<%# Eval("BookingId") %>' 
                                        CssClass="btn btn-sm btn-primary" 
                                        CausesValidation="false" ClientIDMode="AutoID"
                                        Visible='<%# Eval("PaymentStatus").ToString().ToLower() == "unpaid" && Eval("BookingStatus").ToString().ToLower() == "confirmed" %>'>Mark Paid</asp:LinkButton>
                                                                             
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <%-- Following coding is auto-generated by design view --%>
                    <EditRowStyle BackColor="#7C6F57" />
                    <EmptyDataTemplate>
                        <div class="p-5 text-center text-muted">No booking records found.</div>
                    </EmptyDataTemplate>
                    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#E3EAEB" />
                    <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F8FAFA" />
                    <SortedAscendingHeaderStyle BackColor="#246B61" />
                    <SortedDescendingCellStyle BackColor="#D4DFE1" />
                    <SortedDescendingHeaderStyle BackColor="#15524A" />
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

