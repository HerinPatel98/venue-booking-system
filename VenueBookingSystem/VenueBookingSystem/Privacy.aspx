<%@ Page Title="Privacy Policy" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Privacy.aspx.cs" Inherits="VenueBookingSystem.Privacy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5 mb-5">
        <div class="card shadow-sm border-0" style="background-color: #f0f7f7;">
            <div class="card-body p-5">
                <h1 class="mb-4" style="color: #00796b; font-weight: bold;">Privacy Policy</h1>
                <p class="text-muted">Effective Date: 2025-2026</p>
                <hr />

                <div class="alert alert-info border-0 shadow-sm">
                    <strong>Note:</strong> We value your privacy. Your data is used exclusively for event management purposes.
                </div>

                <section class="mt-4">
                    <h4 style="color: #009688;">Data Collection</h4>
                    <p>We collect minimal information required for booking, including your Name, Email Address, and Phone Number. We do not store plain-text passwords; all passwords are encrypted using SHA256 hashing.</p>
                </section>

                <section class="mt-4">
                    <h4 style="color: #009688;">How We Use Your Information</h4>
                    <ul>
                        <li>To process your venue booking requests.</li>
                        <li>To allow administrators to contact you regarding your event.</li>
                        <li>To maintain a history of your past bookings and feedbacks.</li>
                    </ul>
                </section>

                <section class="mt-4">
                    <h4 style="color: #009688;">Data Security</h4>
                    <p>Our database is hosted locally within a secure environment. We implement session-based authentication to ensure that only authorized users can access personal dashboards.</p>
                </section>

                <section class="mt-4">
                    <h4 style="color: #009688;">Cookies</h4>
                    <p>We use essential cookies to keep you logged in during your session. These cookies do not track your activity on other websites.</p>
                </section>

                <div class="mt-5 text-center">
                    <a href="Default.aspx" class="btn btn-primary">I Understand</a>
                </div>
            </div>
        </div>
    </div>
    <div class="mt-4 pt-3 border-top text-end">
        <span class="text-muted me-2">Need to review the rules of booking?</span>
        <a href="Terms.aspx" class="btn btn-outline-primary btn-sm">View Terms & Conditions &raquo;</a>
    </div>
</asp:Content>
