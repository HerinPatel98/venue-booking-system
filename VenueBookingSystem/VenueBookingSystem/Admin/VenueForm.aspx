<%@ Page Title="Add Venue" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VenueForm.aspx.cs" Inherits="VenueBookingSystem.Admin.VenueForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ContentPlaceHolderID="BreadcrumbContent" runat="server">
    <a id="lnkManageVenues" runat="server" href="~/Admin/ManageVenues.aspx" class="text-decoration-none" style="color: #00796b;">Venues</a>
    <span class="mx-2 text-muted">/</span>
    <span class="fw-bold" style="color: #004d40;">Venue Form</span>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-8">
                <div class="card shadow-sm border-0">
                    <!-- Header -->
                    <div class="card-header bg-white border-0 pt-4 text-center">
                        <h2 style="color: #00796b; font-weight: bold;">
                            <asp:Literal ID="litTitle" runat="server" Text="Add New Venue"></asp:Literal>
                        </h2>
                        <p class="text-muted">Fill in the details below to manage venue information.</p>
                        <hr class="mx-auto" style="width: 60px; height: 3px; background-color: #009688; border:none;" />
                    </div>

                    <div class="card-body p-4">
                        <%-- Hidden Field to track Edit vs Insert --%>
                        <asp:HiddenField ID="hfVenueId" runat="server" />

                        <div class="row g-3">
                            <!-- Venue Name -->
                            <div class="col-md-12">
                                <label class="form-label fw-bold">Venue Name</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="e.g. The Royal Palm Ballroom"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="txtName" runat="server" ErrorMessage="Name is required" ForeColor="Red" Display="Dynamic" />
                            </div>

                            <!-- Description -->
                            <div class="col-md-12">
                                <label class="form-label fw-bold">Description</label>
                                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Describe the venue features..."></asp:TextBox>
                            </div>

                            <!-- Venue Type & City -->
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Venue Type</label>
                                <asp:DropDownList ID="ddlVenueType" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="-- Select Type --" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Banquet Hall" Value="Banquet Hall"></asp:ListItem>
                                    <asp:ListItem Text="Garden Plot" Value="Garden Plot"></asp:ListItem>
                                    <asp:ListItem Text="Terrace Hall" Value="Terrace Hall"></asp:ListItem>
                                    <asp:ListItem Text="Hotel Ballroom" Value="Hotel Ballroom"></asp:ListItem>
                                    <asp:ListItem Text="Resort" Value="Resort"></asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-bold">City</label>
                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="e.g. Rajkot"></asp:TextBox>
                            </div>

                            <!-- Capacity & Price -->
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Capacity (Guests)</label>
                                <asp:TextBox ID="txtCapacity" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-bold">Base Price (₹)</label>
                                <asp:TextBox ID="txtBasePrice" runat="server" CssClass="form-control" placeholder="0.00"></asp:TextBox>
                            </div>

                            <!-- Contact Info -->
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Contact Email</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="admin@venue.com"></asp:TextBox>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-bold">Contact Phone</label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="e.g. 9876543210"></asp:TextBox>
                            </div>

                            <div class="col-md-12">
                                <label class="form-label fw-bold">Availability Status</label>
                                <asp:DropDownList ID="ddlIsAvailable" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Available (Show to Users)" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Not Available (Hide from Users)" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                                <small class="text-muted">Setting this to 'Not Available' prevents users from seeing or booking this venue.</small>
                            </div>

                            <!-- Image Picker Section -->
                            <div class="col-md-12">
                                <label class="form-label fw-bold">Choose From Existing Images</label>
                                <asp:DropDownList ID="ddlImages" runat="server" CssClass="form-select" onchange="updateImagePreview(this);">
                                    <%-- Populated dynamically from C# --%>
                                </asp:DropDownList>
                                
                                <div class="mt-3 text-center bg-light p-3 rounded border border-dashed">
                                    <p class="small text-muted mb-2">Image Preview</p>
                                    <img id="imgPreview" src="#" alt="No Image Selected" class="img-thumbnail" 
                                         style="max-height: 200px; display: none; border-radius: 8px;" />
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="col-md-12 mt-4 pt-3 border-top d-flex gap-2">
                                <asp:Button ID="btnSave" runat="server" Text="Save Venue" OnClick="btnSave_Click" CssClass="btn btn-primary px-5 fw-bold" />
                                <a href="ManageVenues.aspx" class="btn btn-outline-secondary px-4">Back to List</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Client-side script for instant image preview -->
    <script type="text/javascript">
        function updateImagePreview(ddl) {
            var img = document.getElementById('imgPreview');
            if (ddl.value && ddl.value !== "") {
                // Convert relative path ~/ to browser path
                var browserPath = ddl.value.replace('~/', '../');
                console.info(browserPath)
                img.src = "../" + browserPath;
                img.style.display = 'inline-block';
            } else {
                img.style.display = 'none';
            }
        }

        // Run preview check on page load for Edit Mode
        window.onload = function () {
            var ddl = document.getElementById('<%= ddlImages.ClientID %>');
            updateImagePreview(ddl);
        };
    </script>
</asp:Content>
