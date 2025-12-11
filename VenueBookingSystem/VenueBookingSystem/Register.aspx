<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="VenueBookingSystem.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-lg p-4" style="background-color: #ffffff;">
                    <div class="card-body">
                        <h2 class="card-title text-center mb-4" style="color: #00796b;">Create a New Account</h2>
                        
                        <asp:Label ID="lblMessage" runat="server" CssClass="alert w-100 mb-3" Visible="false" />

                        <div class="mb-3">
                            <label for="txtEmail" class="form-label">Email Address (Username)</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required." ForeColor="Red" Display="Dynamic" />
                        </div>

                         <div class="mb-3">
                            <label for="txtFullName" class="form-label">Full Name</label>
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox>
                             <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFullName" ErrorMessage="Full Name is required." ForeColor="Red" Display="Dynamic" />
                        </div>
                        
                        <div class="mb-3">
                            <label for="txtPassword" class="form-label">Password</label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            <%-- The Regex Validator we designed earlier --%>

                            
                            <%--ValidationExpression="^(?=.*[A-Z])(?=.*[0-9])(?=.*[#$^+=!*()@%&]).{8,}$"--%>
                            <asp:RegularExpressionValidator 
                                runat="server" 
                                ControlToValidate="txtPassword"
                                ValidationExpression="^(?=.*[A-Z])(?=.*[0-9]).{4,}$"
                                ErrorMessage="Password must be 4+ chars, with 1 uppercase, 1 number."
                                ForeColor="Red"
                                Display="Dynamic"
                            />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required." ForeColor="Red" Display="Dynamic" />
                        </div>
                        <div class="mb-3">
                            <label for="txtPhoneNumber" class="form-label">Phone Number (Optional)</label>
                            <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control" TextMode="Phone"></asp:TextBox>
                        </div>
                        <%-- The Register Button --%>
                        <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" CssClass="btn btn-primary w-100" />

                        <hr />
                        
                        <p class="text-center mt-3">
                            Already have an account? <a href="Login.aspx" style="color: #00796b;">Log In Here</a>
                        </p>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
