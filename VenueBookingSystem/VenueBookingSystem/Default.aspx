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
                                <p class="card-text fst-italic mb-2">
                                    "Great selection of venues. The interface is clean and functional, exactly what a busy event planner needs!"
                                </p>
                                <footer class="blockquote-footer mt-4">
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
                            <img src="Images/hall1.png" class="card-img-top venue-img" alt="Venue Image">

                            <div class="card-body">
                                <h5 class="card-title">The Grand Prix Hall</h5>
                                <p class="card-text text-muted">A luxurious ballroom perfect for large weddings and events.</p>

                                <ul class="list-group list-group-flush mb-3">
                                    <li class="list-group-item"><strong>City:</strong> Rajkot</li>
                                    <li class="list-group-item"><strong>Capacity:</strong> 300 Guests</li>
                                    <li class="list-group-item"><strong>Type:</strong> Banquet Hall</li>
                                </ul>

                                <div class="d-flex justify-content-between align-items-center">
                                    <h4 class="text-primary"></h4>
                                    <a href="VenueDetails.aspx?VenueId=1" class="btn btn-primary">View Details</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End of a single venue card -->

                    <!-- Example of a second venue card -->
                    <div class="col-md-4 mb-4">
                        <div class="card h-100 shadow-sm border-0">
                            <img src="Images/gp2.jpg" class="card-img-top venue-img" alt="Venue Image">
                            <div class="card-body">
                                <h5 class="card-title">Green Garden Plot</h5>
                                <p class="card-text text-muted">A large open-air garden plot ideal for grand outdoor functions.</p>
                                <ul class="list-group list-group-flush mb-3">
                                    <li class="list-group-item"><strong>City:</strong> Rajkot</li>
                                    <li class="list-group-item"><strong>Capacity:</strong> 1000 Guests</li>
                                    <li class="list-group-item"><strong>Type:</strong> Garden Plot</li>
                                </ul>
                                <div class="d-flex justify-content-between align-items-center">
                                    <h4 class="text-primary"><%--₹25,000--%></h4>
                                    <a href="VenueDetails.aspx?VenueId=2" class="btn btn-primary">View Details</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Example of a third venue card -->
                    <div class="col-md-4 mb-4">
                        <div class="card h-100 shadow-sm border-0">
                            <img src="Images/palace1.jpg" class="venue-img" alt="Palace1">
                            <div class="card-body">
                                <h5 class="card-title">Urban Terrace Hall</h5>
                                <p class="card-text text-muted">A modern, smaller hall with an open terrace concept. Gives your guest perfect 360 view</p>
                                <ul class="list-group list-group-flush mb-3">
                                    <li class="list-group-item"><strong>City:</strong> Ahmedabad</li>
                                    <li class="list-group-item"><strong>Capacity:</strong> 150 Guests</li>
                                    <li class="list-group-item"><strong>Type:</strong> Terrace Hall</li>
                                </ul>
                                <div class="d-flex justify-content-between align-items-center">
                                    <h4 class="text-primary"><%--₹8,000--%></h4>
                                    <a href="VenueDetails.aspx?VenueId=3" class="btn btn-primary">View Details</a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>
        <section class="auth-prompts py-5">
            <div class="container">
                <div class="row g-4">

                    <!-- Login Card (Primary Action - uses the calming teal color) -->
                    <div class="col-md-6">
                        <div class="card h-100 shadow-sm border-primary" style="background-color: #e0f2f1;">
                            <div class="card-body p-5">
                                <h3 class="card-title mb-3" style="color: #00796b;">Already a User?</h3>
                                <p class="card-text">Log in to view your dashboard, manage bookings, and make new requests.</p>
                                <a href="Login.aspx" class="btn btn-primary btn-lg mt-3">Log In</a>
                            </div>
                        </div>
                    </div>

                    <!-- Register Card (Secondary Action - uses a neutral white) -->
                    <div class="col-md-6">
                        <div class="card h-100 shadow-sm border-0 bg-white">
                            <div class="card-body p-5">
                                <h3 class="card-title mb-3" style="color: #333;">New to the System?</h3>
                                <p class="card-text">Register for free today to start planning your perfect event.</p>
                                <a href="Register.aspx" class="btn btn-outline-secondary btn-lg mt-3">Create Account</a>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>

        <section class="faq-section py-5">
            <div class="container">
                <h2 class="text-center mb-5" style="color: #00796b;">Frequently Asked Questions</h2>

                <!-- Bootstrap Accordion Component -->
                <div class="accordion" id="faqAccordion">

                    <!-- FAQ Item 1 -->
                    <div class="accordion-item shadow-sm mb-3">
                        <h2 class="accordion-header" id="headingOne">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                How do I book a venue?
                            </button>
                        </h2>
                        <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                To book a venue, simply register for an account, browse the available venues on our **[Browse Venues](ListVenues.aspx)** page, and submit a booking request for your desired date. Our admin team will review and confirm your request shortly.
                            </div>
                        </div>
                    </div>

                    <!-- FAQ Item 2 -->
                    <div class="accordion-item shadow-sm mb-3">
                        <h2 class="accordion-header" id="headingTwo">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                               What types of events do you provide services for?
                            </button>
                        </h2>
                        <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                            We specialize in venue bookings for a wide range of events, including social gatherings such as weddings, birthday parties, and anniversaries, as well as corporate events like business meetings and conferences.   
                            </div>
                        </div>
                    </div>

                    <!-- FAQ Item 3 -->
                    <div class="accordion-item shadow-sm mb-3">
                        <h2 class="accordion-header" id="headingThree">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                Can I cancel a booking?
                            </button>
                        </h2>
                        <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                Yes, you can request a cancellation through your User Dashboard. Please refer to our terms and conditions for details regarding cancellation policies and refunds (Changes or cancellations can be carried out in accordance with the venue's terms and conditions.).
                            </div>
                        </div>
                    </div>

                    <!-- FAQ Item 4 -->
                    <div class="accordion-item shadow-sm mb-3">
                        <h2 class="accordion-header" id="headingFour">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                               What advantages do I gain from making a booking through your portal?
                            </button>
                        </h2>
                        <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                            We can assist you in securing the most favorable negotiated rates for venues. Our portal serves as a comprehensive solution for all your event-related bookings. Our dedicated team is ready to help you not only in booking the ideal venue but also in coordinating additional services such as catering, artists, and event themes.    
                            </div>
                        </div>
                    </div>

                </div>
                <!-- End of Accordion -->

            </div>
        </section>
    </main>

</asp:Content>
