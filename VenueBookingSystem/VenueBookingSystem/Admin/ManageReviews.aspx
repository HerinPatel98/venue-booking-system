<%@ Page Title="Moderate Feedbacks" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageReviews.aspx.cs" Inherits="VenueBookingSystem.Admin.ManageReviews" %>

<asp:Content ContentPlaceHolderID="BreadcrumbContent" runat="server">
    <a href="Dashboard.aspx" class="text-decoration-none" style="color: #00796b;">Admin Dashboard</a> / 
    <span class="fw-bold" style="color: #004d40;">Moderate Feedbacks</span>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 style="color: #263238;">Customer Reviews Moderation</h2>
            <asp:Label ID="lblStatusMessage" runat="server" CssClass="text-success fw-bold"></asp:Label>
        </div>

        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <asp:GridView ID="gvReviews" runat="server" CssClass="table table-hover align-middle mb-0" 
                    AutoGenerateColumns="False" OnRowCommand="gvReviews_RowCommand" GridLines="None">
                    <HeaderStyle CssClass="bg-dark text-white" />
                    <Columns>
                        <asp:BoundField DataField="FeedbackDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
                        <asp:BoundField DataField="FullName" HeaderText="Customer" />
                        <asp:BoundField DataField="VenueName" HeaderText="Venue" />
                        <asp:TemplateField HeaderText="Rating">
                            <ItemTemplate>
                                <span class="text-warning fw-bold"><%# Eval("Rating") %> ⭐</span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Comment" HeaderText="Review" />
                        
                        <%-- Dynamic Status Badge --%>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class='badge <%# 
                                    Eval("Status").ToString() == "Approved" ? "bg-success" : 
                                    Eval("Status").ToString() == "Rejected" ? "bg-danger" : 
                                    "bg-warning text-dark" %>'>
                                    <%# Eval("Status") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <%-- Action Buttons --%>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <div class="d-flex gap-2">
                                    <asp:Button ID="btnApprove" runat="server" Text="Approve" 
                                        CommandName="ApproveReview" CommandArgument='<%# Eval("FeedbackId") %>' 
                                        CssClass="btn btn-sm btn-success" 
                                        Visible='<%# Eval("Status").ToString() != "Approved" %>' />
                                        
                                    <asp:Button ID="btnReject" runat="server" Text="Reject" 
                                        CommandName="RejectReview" CommandArgument='<%# Eval("FeedbackId") %>' 
                                        CssClass="btn btn-sm btn-danger" 
                                        Visible='<%# Eval("Status").ToString() != "Rejected" %>' />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="p-4 text-center text-muted">No reviews found in the system.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>