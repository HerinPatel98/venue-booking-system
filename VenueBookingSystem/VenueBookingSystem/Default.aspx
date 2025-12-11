<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="VenueBookingSystem._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <section class="jumbotron text-center bg-white py-5 mb-4 shadow-sm">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 mx-auto">
                        <%-- Catchy Headline and Sub-text --%>
                        <h1 class="display-4 fw-bold">Find the Perfect Venue for Your Next Event</h1>
                        <p class="lead text-muted">Browse hundreds of banquet halls, garden plots, and terraces across 28 cities.</p>

                        <%-- Primary Call-to-Action Button --%>
                        <p>
                            <a href="ListVenues.aspx" class="btn btn-primary btn-lg my-2">Browse Venues Now &raquo;</a>
                        </p>
                    </div>
                </div>
            </div>
        </section>
        <section class="testimonials py-5">
    <div class="container">
        <h2 class="text-center mb-5" style="color: #00796b;">What Our Clients Say</h2>
        
        <div class="row">
            
            <!-- Start of a single testimonial card (Copy this col-md-4 block to add more) -->
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm border-0" style="background-color: #ffffff;">
                    <div class="card-body">
                        <p class="card-text fst-italic">
                            "The venue booking process was seamless! The Garden Plot was perfect for our needs, and the admin panel made it easy to get confirmation quickly."
                        </p>
                        <footer class="blockquote-footer mt-3">
                            A Happy User from <cite title="Source Title">Rajkot</cite>
                        </footer>
                    </div>
                </div>
            </div>
            <!-- End of a single testimonial card -->

             <!-- Example of a second card -->
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm border-0" style="background-color: #ffffff;">
                    <div class="card-body">
                        <p class="card-text fst-italic">
                            "Great selection of venues. The interface is clean and functional, exactly what a busy event planner needs!"
                        </p>
                        <footer class="blockquote-footer mt-3">
                            Event Planner <cite title="Source Title">Ahmedabad</cite>
                        </footer>
                    </div>
                </div>
            </div>

             <!-- Example of a third card -->
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm border-0" style="background-color: #ffffff;">
                    <div class="card-body">
                        <p class="card-text fst-italic">
                            "Highly recommended. The support team (admin) was responsive and professional when managing our payment status."
                        </p>
                        <footer class="blockquote-footer mt-3">
                            Corporate Client <cite title="Source Title">Rajkot</cite>
                        </footer>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>

        <section class="featured-venues py-5">
    <div class="container">
        <h2 class="text-center mb-5" style="color: #00796b;">Explore Our Top Venues</h2>

        <div class="row">

            <!-- Start of a single venue card (Copy the col-md-4 block for more venues) -->
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm border-0">
                    <!-- Placeholder for a venue image -->
                    <img src="via.placeholder.com" class="card-img-top" alt="Venue Image">
                    
                    <div class="card-body">
                        <h5 class="card-title">The Grand Ballroom</h5>
                        <p class="card-text text-muted">A luxurious ballroom perfect for large weddings and events.</p>
                        
                        <ul class="list-group list-group-flush mb-3">
                            <li class="list-group-item"><strong>City:</strong> Rajkot</li>
                            <li class="list-group-item"><strong>Capacity:</strong> 300 Guests</li>
                            <li class="list-group-item"><strong>Type:</strong> Banquet Hall</li>
                        </ul>
                        
                        <div class="d-flex justify-content-between align-items-center">
                            <h4 class="text-primary">₹15,000</h4>
                            <a href="VenueDetails.aspx?VenueId=1" class="btn btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End of a single venue card -->

             <!-- Example of a second venue card -->
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm border-0">
                    <img src="via.placeholder.com" class="card-img-top" alt="Venue Image">
                    <div class="card-body">
                        <h5 class="card-title">Green Garden Plot</h5>
                        <p class="card-text text-muted">A large open-air garden plot ideal for grand outdoor functions.</p>
                        <ul class="list-group list-group-flush mb-3">
                            <li class="list-group-item"><strong>City:</strong> Rajkot</li>
                            <li class="list-group-item"><strong>Capacity:</strong> 1000 Guests</li>
                            <li class="list-group-item"><strong>Type:</strong> Garden Plot</li>
                        </ul>
                        <div class="d-flex justify-content-between align-items-center">
                            <h4 class="text-primary">₹25,000</h4>
                            <a href="VenueDetails.aspx?VenueId=2" class="btn btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
            </div>

             <!-- Example of a third venue card -->
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm border-0">
                    <img src="via.placeholder.com" class="card-img-top" alt="Venue Image">
                    <div class="card-body">
                        <h5 class="card-title">Urban Terrace Hall</h5>
                        <p class="card-text text-muted">A modern, smaller hall with an open terrace concept.</p>
                         <ul class="list-group list-group-flush mb-3">
                            <li class="list-group-item"><strong>City:</strong> Ahmedabad</li>
                            <li class="list-group-item"><strong>Capacity:</strong> 150 Guests</li>
                            <li class="list-group-item"><strong>Type:</strong> Terrace Hall</li>
                        </ul>
                        <div class="d-flex justify-content-between align-items-center">
                            <h4 class="text-primary">₹8,000</h4>
                            <a href="VenueDetails.aspx?VenueId=3" class="btn btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>
        <!-- You can place other sections for featured venues or testimonials below this -->


    <div class="row">
        <section class="col-md-4" aria-labelledby="gettingStartedTitle">
            <h2 id="gettingStartedTitle">Getting started</h2>
            <p>
                ASP.NET Web Forms lets you build dynamic websites using a familiar drag-and-drop, event-driven model.
                A design surface and hundreds of controls and components let you rapidly build sophisticated, powerful UI-driven sites with data access.
            </p>
            <p>
                <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301948">Learn more &raquo;</a>
            </p>
        </section>
        <section class="col-md-4" aria-labelledby="librariesTitle">
            <h2 id="librariesTitle">Get more libraries</h2>
            <p>
                NuGet is a free Visual Studio extension that makes it easy to add, remove, and update libraries and tools in Visual Studio projects.
            </p>
            <p>
                <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301949">Learn more &raquo;</a>
            </p>
        </section>
        <section class="col-md-4" aria-labelledby="hostingTitle">
            <h2 id="hostingTitle">Web Hosting</h2>
            <p>
                You can easily find a web hosting company that offers the right mix of features and price for your applications.
            </p>
            <p>
                <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301950">Learn more &raquo;</a>
            </p>
        </section>
    </div>
    </main>

</asp:Content>
