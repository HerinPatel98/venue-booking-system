<%@ Page Title="User Login Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="VenueBookingSystem.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-lg p-4" style="background-color: #ffffff;">
                    <div class="card-body">
                        <h2 class="card-title text-center mb-4" style="color: #00796b;">Log In to Your Account</h2>


                        <div class="mb-3">
                            <label for="txtEmail" class="form-label">Email Address (Username)</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label for="txtPassword" class="form-label">Password</label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        </div>

                        <%-- The Login Button --%>
                        <asp:Button ID="btnLogin" runat="server" Text="Log In" OnClick="btnLogin_Click" CssClass="btn btn-primary w-100" />

                        <hr />
                        <asp:Label ID="lblErrorMessage" runat="server" CssClass="w-100 mt-3 text-center" ForeColor="Red" Visible="false" />
                        <p class="text-center mt-3">
                            Don't have an account? <a href="Register.aspx" style="color: #00796b;">Sign Up Now</a>
                            <%-- Add link for forgot password here later if needed --%>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
