<%@ Page Title="Admin - Manage Venues" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageVenues.aspx.cs" Inherits="VenueBookingSystem.Admin.ManageVenues" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ContentPlaceHolderID="BreadcrumbContent" runat="server">
    <span class="text-muted">Admin</span>
    <span class="mx-2 text-muted">/</span>
    <span class="fw-bold" style="color: #004d40;">Manage Venues</span>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 style="color: #263238;">Manage Venues</h2>
            <a href="VenueForm.aspx" class="btn btn-warning fw-bold">+ Add New Venue</a>
        </div>

        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <asp:GridView ID="gvManageVenues" runat="server" CssClass="table table-hover align-middle mb-0" 
                    AutoGenerateColumns="False" DataKeyNames="VenueId" GridLines="None" OnRowDeleting="gvManageVenues_RowDeleting" CellPadding="4" ForeColor="#333333">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:TemplateField HeaderText="Image">
                            <ItemTemplate>
                                <img src='../<%# Eval("ImageUrl") %>' style="width: 60px; height: 40px; object-fit: contain;" class="rounded border" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Name" HeaderText="Venue Name" />
                        <asp:BoundField DataField="City" HeaderText="City" />
                        <asp:BoundField DataField="VenueType" HeaderText="Type" />
                        <asp:BoundField DataField="Capacity" HeaderText="Capacity" />
                        <asp:BoundField DataField="BasePrice" HeaderText="Price" DataFormatString="₹{0:N0}" />
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class='badge <%# Eval("IsAvailable").ToString() == "True" ? "bg-success" : "bg-danger" %>'>
                                    <%# Eval("IsAvailable").ToString() == "True" ? "Active" : "Hidden" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <a href='VenueForm.aspx?VenueId=<%# Eval("VenueId") %>' class="btn btn-sm btn-outline-primary">Edit</a>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" 
                                    OnClientClick="return confirm('Are you sure you want to delete this venue?');" 
                                    CssClass="btn btn-sm btn-outline-danger">Delete</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <%-- Following coding is auto generated from design view. --%>
                    <EditRowStyle BackColor="#7C6F57" />
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
