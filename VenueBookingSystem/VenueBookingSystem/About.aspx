<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="VenueBookingSystem.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   <div class="container mt-5 mb-5">
        <!-- Hero Section -->
        <div class="row align-items-center mb-5 p-4 rounded shadow-sm" style="background-color: #e0f2f1;">
            <div class="col-md-6">
                <h1 class="display-4 fw-bold" style="color: #00796b;">Our Story</h1>
                <p class="lead">Simplifying event planning for the modern world.</p>
                <p>Founded in 2025, <strong>VenueBook Pro</strong> was born out of a simple need: making the process of finding and booking event spaces in Rajkot and Ahmedabad as seamless as possible. We connect people with the perfect spaces for their most important life moments.</p>
            </div>
            <div class="col-md-6 text-center">
                <img src="Images/palace1.jpg" class="img-fluid rounded shadow" alt="Our Vision">
            </div>
        </div>

        <!-- Mission & Values Section -->
        <div class="row text-center g-4">
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm p-3">
                    <div class="card-body">
                        <div class="h1 mb-3" style="color: #009688;">🎯</div>
                        <h4 style="color: #00796b;">Our Mission</h4>
                        <p class="text-muted">To provide a transparent, efficient, and user-friendly platform for venue management and event coordination.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm p-3">
                    <div class="card-body">
                        <div class="h1 mb-3" style="color: #009688;">🤝</div>
                        <h4 style="color: #00796b;">Reliability</h4>
                        <p class="text-muted">We ensure every booking is verified and every venue is represented with accurate details and real user reviews.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm p-3">
                    <div class="card-body">
                        <div class="h1 mb-3" style="color: #009688;">✨</div>
                        <h4 style="color: #00796b;">Innovation</h4>
                        <p class="text-muted">Using modern technology to bring you real-time availability and a smooth interface for your planning needs.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Call to Action -->
        <div class="mt-5 pt-5 text-center">
            <h3 style="color: #00796b;">Ready to find your perfect space?</h3>
            <div class="mt-4">
                <a href="ListVenues.aspx" class="btn btn-primary btn-lg me-2">Browse Venues</a>
                <a href="Contact.aspx" class="btn btn-outline-secondary btn-lg">Get in Touch</a>
            </div>
        </div>
    </div>
</asp:Content>
