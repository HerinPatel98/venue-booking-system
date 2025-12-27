<%@ Page Title="Terms & Conditions" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Terms.aspx.cs" Inherits="VenueBookingSystem.Terms" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5 mb-5">
        <div class="card shadow-sm border-0">
            <div class="card-body p-5">
                <h1 class="mb-4" style="color: #00796b; font-weight: bold;">Terms and Conditions</h1>
                <p class="text-muted">Last Updated: December 2025</p>
                <hr />

                <section class="mt-4">
                    <h4 style="color: #009688;">1. Acceptance of Terms</h4>
                    <p>By accessing and using VenueBook Pro, you agree to comply with and be bound by the following terms and conditions. If you do not agree, please refrain from using our services.</p>
                </section>

                <section class="mt-4">
                    <h4 style="color: #009688;">2. Booking & Requests</h4>
                    <p>All venue bookings made through this platform are considered "Requests" until confirmed by the System Administrator. A request does not guarantee venue availability until the status is updated to "Confirmed."</p>
                </section>

                <section class="mt-4">
                    <h4 style="color: #009688;">3. User Obligations</h4>
                    <ul>
                        <li>Users must provide accurate personal information during registration.</li>
                        <li>Users are responsible for maintaining the confidentiality of their login credentials.</li>
                        <li>Any fraudulent activity will lead to immediate account termination.</li>
                    </ul>
                </section>

                <section class="mt-4">
                    <h4 style="color: #009688;">4. Payments & Refunds</h4>
                    <p>VenueBook Pro acts as a management platform. Payments are handled manually between the user and the venue administrator. Refund policies are subject to the specific venue's rules at the time of cancellation.</p>
                </section>

                <section class="mt-4">
                    <h4 style="color: #009688;">5. Limitation of Liability</h4>
                    <p>The system administrators are not liable for any disputes, damages, or losses resulting from the use of the listed venues.</p>
                </section>

                <div class="mt-5 text-center">
                    <a href="Default.aspx" class="btn btn-primary">Return to Home</a>
                </div>
            </div>
        </div>
    </div>
    <div class="mt-4 pt-3 border-top text-end">
        <span class="text-muted me-2">Want to know how we protect your data?</span>
        <a href="Privacy.aspx" class="btn btn-outline-primary btn-sm">Read Privacy Policy &raquo;</a>
    </div>
</asp:Content>
