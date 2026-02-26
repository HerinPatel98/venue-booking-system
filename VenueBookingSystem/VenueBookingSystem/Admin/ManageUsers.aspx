<%@ Page Title="Admin - Manage Users" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="VenueBookingSystem.Admin.ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ContentPlaceHolderID="BreadcrumbContent" runat="server">
    <a id="lnkDashboard" runat="server" href="~/Admin/Dashboard.aspx" class="text-decoration-none" style="color: #00796b;">Dashboard</a>
    <span class="mx-2 text-muted">/</span>
    <span class="fw-bold" style="color: #004d40;">Manage Users</span>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid mt-4">
        
        <div class="mb-3">
             <asp:Label ID="lblMsg" runat="server" Visible="false" CssClass="alert alert-info d-block"></asp:Label>
        </div>

        <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                <h4 class="mb-0" style="color: #263238;">Registered Users</h4>
                <div class="text-muted small">
                    <i class="fas fa-info-circle"></i> Admins cannot be deleted.
                </div>
            </div>
            
            <div class="card-body p-0">
                <asp:GridView ID="gvUsers" runat="server" 
                    CssClass="table table-hover mb-0 align-middle" 
                    AutoGenerateColumns="False" 
                    GridLines="None" 
                    OnRowCommand="gvUsers_RowCommand"
                    DataKeyNames="UserId"
                    ClientIDMode="AutoID"
                    EnableViewState="true">
                    
                    <Columns>
                        <%-- ID Column (Hidden or Visible depending on preference, usually good for debugging) --%>
                        <asp:BoundField DataField="UserId" HeaderText="ID" ItemStyle-Width="50px" />

                        <asp:BoundField DataField="FullName" HeaderText="Full Name" SortExpression="FullName" />
                        <asp:BoundField DataField="Email" HeaderText="Email Address" />
                        <asp:BoundField DataField="City" HeaderText="City" />
                        <asp:BoundField DataField="PhoneNumber" HeaderText="Phone" NullDisplayText="-" />

                        <%-- Role with Badge --%>
                        <asp:TemplateField HeaderText="Role">
                            <ItemTemplate>
                                <span class='badge <%# GetRoleBadgeClass(Eval("Role").ToString()) %>'>
                                    <%# Eval("Role") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <%-- Action Buttons --%>
                        <asp:TemplateField HeaderText="Actions" ItemStyle-Width="150px">
                            <ItemTemplate>
                                <%-- Delete Button: Only visible if the user is NOT the current logged-in admin --%>
                                <%-- Uses Container.DataItemIndex for robust CommandArgument passing --%>
                                <asp:LinkButton ID="btnDelete" runat="server" 
                                    CommandName="DeleteUser" 
                                    CommandArgument='<%# Container.DataItemIndex %>'
                                    CssClass="btn btn-sm btn-outline-danger"
                                    Visible='<%# Eval("Role").ToString() != "Admin" %>'
                                    OnClientClick="return confirm('WARNING: Deleting this user will remove them permanently.\n\nAre you sure?');">
                                    <i class="bi bi-trash"></i> Delete
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <EmptyDataTemplate>
                        <div class="p-5 text-center text-muted">
                            <h5>No users found.</h5>
                        </div>
                    </EmptyDataTemplate>

                    <HeaderStyle BackColor="#f0f7f7" Font-Bold="True" ForeColor="#004d40" BorderStyle="None" />
                    <RowStyle BackColor="#ffffff" BorderStyle="None" />
                    <AlternatingRowStyle BackColor="#fafafa" />
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>