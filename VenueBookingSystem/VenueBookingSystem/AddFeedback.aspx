<%@ Page Title="Rate Venue" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddFeedback.aspx.cs" Inherits="VenueBookingSystem.AddFeedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ContentPlaceHolderID="BreadcrumbContent" runat="server">
    <a href="UserDashboard.aspx" class="text-decoration-none" style="color: #00796b;">Dashboard</a>
    <span class="mx-2 text-muted">/</span>
    <span class="fw-bold" style="color: #004d40;">Write Review</span>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white py-3">
                        <h4 class="mb-0 text-center" style="color: #00796b;">Rate Your Experience</h4>
                    </div>
                    <div class="card-body p-4">
                        
                        <div class="text-center mb-4">
                            <h5 class="text-muted small">You recently visited</h5>
                            <h3 class="fw-bold" style="color: #004d40;">
                                <asp:Label ID="lblVenueName" runat="server"></asp:Label>
                            </h3>
                            <span class="badge bg-light text-dark border">
                                Event Date: <asp:Label ID="lblDate" runat="server"></asp:Label>
                            </span>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Select Rating</label>
                            <asp:DropDownList ID="ddlRating" runat="server" CssClass="form-select">
                                <asp:ListItem Value="5">⭐⭐⭐⭐⭐ (Excellent)</asp:ListItem>
                                <asp:ListItem Value="4">⭐⭐⭐⭐ (Good)</asp:ListItem>
                                <asp:ListItem Value="3">⭐⭐⭐ (Average)</asp:ListItem>
                                <asp:ListItem Value="2">⭐⭐ (Poor)</asp:ListItem>
                                <asp:ListItem Value="1">⭐ (Terrible)</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">Your Review</label>
                          <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Rows="4" 
    CssClass="form-control" placeholder="Share your experience..."></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvComment" runat="server" ControlToValidate="txtComment" 
                                ErrorMessage="Please write a comment." CssClass="text-danger small" Display="Dynamic" />
                        </div>

                        <div class="d-grid">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit Feedback" 
                                OnClick="btnSubmit_Click" CssClass="btn btn-primary btn-lg" 
                                style="background-color: #009688; border: none;" />
                        </div>

                         <div class="mt-3">
                             <asp:Label ID="lblError" runat="server" Visible="false" CssClass="alert alert-danger d-block"></asp:Label>
                         </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>