# VENUE BOOKING SYSTEM - PROJECT DOCUMENTATION

**Last Updated:** February 8, 2026  
**Project Type:** ASP.NET WebForms (C#)  
**Framework Version:** .NET Framework 4.x  
**CSS Framework:** Bootstrap 5.2.3  
**JavaScript:** jQuery 3.7.0

---

## 1. PROJECT OVERVIEW

**Project Name:** Venue Booking System  
**Branding:** Golden Petal Venues (BookMyHall)  
**Purpose:** A web application enabling users to browse venues, make bookings, and provide feedback. Admins can manage venues, bookings, users, and revenue.

**Key Features:**
- User authentication (Login/Register)
- Browse and filter venues by city, type, and booking date
- Make venue bookings with amenity add-ons
- View and manage personal bookings
- Submit and view venue reviews/feedback
- Admin dashboard for venue and booking management
- Payment status tracking

---

## 2. COLOR THEME & DESIGN

**Primary Color Scheme:**
- Primary Teal: `#009688`
- Dark Teal: `#00796b` (used for headings, navbar brand)
- Darker Slate: `#004d40` (used for accents)
- Very Dark: `#263238` (used for admin heading)
- Light Teal Background: `#f0f7f7`
- Light Teal Cards: `#e0f2f1`
- White: `#ffffff` (card backgrounds, navbar)

**CSS Classes Used:**
- `.navbar-custom` - Custom navbar styling
- `.admin-card-gold` - Admin KPI cards (gold theme)
- `.admin-card-teal` - Admin KPI cards (teal theme)
- `.shadow-sm` - Subtle box shadows
- Bootstrap 5 utility classes for layout

**Theme File:** `VenueBookingSystem/Content/Site.css`

---

## 3. DATABASE SCHEMA

### 3.1 Users Table
```
Column Name      | Data Type          | Constraints
UserId           | INT                | PRIMARY KEY, IDENTITY(1,1)
Email            | NVARCHAR(100)      | NOT NULL, UNIQUE
PasswordHash     | NVARCHAR(MAX)      | NOT NULL
Role             | NVARCHAR(20)       | NOT NULL, CHECK: 'Admin' or 'User'
FullName         | NVARCHAR(100)      | NOT NULL
PhoneNumber      | NVARCHAR(20)       | NULLABLE
City             | NVARCHAR(20)       | NULLABLE
```

### 3.2 Venues Table
```
Column Name      | Data Type          | Constraints
VenueId          | INT                | PRIMARY KEY, IDENTITY(1,1)
Name             | NVARCHAR(100)      | NOT NULL
Description      | NVARCHAR(MAX)      | NOT NULL
VenueType        | NVARCHAR(50)       | NOT NULL
Capacity         | INT                | NOT NULL
BasePrice        | DECIMAL(10,2)      | NOT NULL
City             | NVARCHAR(100)      | NOT NULL
ContactEmail     | NVARCHAR(100)      | NULLABLE
ContactPhone     | NVARCHAR(20)       | NULLABLE
IsAvailable      | BIT                | NOT NULL, DEFAULT: 1
ImageUrl         | (Implied)          | Path to venue image
```

### 3.3 Bookings Table
```
Column Name      | Data Type          | Constraints
BookingId        | INT                | PRIMARY KEY, IDENTITY(1,1)
UserId           | INT                | NOT NULL, FK → Users(UserId)
VenueId          | INT                | NOT NULL, FK → Venues(VenueId)
BookingDate      | DATE               | NOT NULL
BookingStatus    | NVARCHAR(20)       | NOT NULL, CHECK: 'Pending', 'Confirmed', 'Cancelled'
PaymentStatus    | NVARCHAR(20)       | NOT NULL, CHECK: 'Unpaid', 'Paid'
TotalCost        | DECIMAL(10,2)      | NOT NULL
RequestedDate    | DATETIME           | NOT NULL, DEFAULT: GETDATE()
```

### 3.4 Feedbacks Table
```
Column Name      | Data Type          | Constraints
FeedbackId       | INT                | PRIMARY KEY, IDENTITY(1,1)
VenueId          | INT                | NOT NULL, FK → Venues(VenueId)
UserId           | INT                | NOT NULL, FK → Users(UserId)
Rating           | INT                | NOT NULL, CHECK: 1-5 stars
Comment          | NVARCHAR(MAX)      | NOT NULL
```

---

## 4. FILE HIERARCHY & PROJECT STRUCTURE

```
VenueBookingSystem/
├── VenueBookingSystem.sln                 # Solution file
├── packages/                              # NuGet packages
│   ├── bootstrap.5.2.3/
│   ├── jQuery.3.7.0/
│   ├── Newtonsoft.Json.13.0.3/
│   └── ... (other dependencies)
├── sample query/                          # SQL scripts
│   ├── AllTables.sql                     # Database schema
│   ├── SampleVenues.sql
│   ├── SampleBookings.sql
│   ├── SampleFeedback.sql
│   └── dbo.VenueProcedure.sql
└── VenueBookingSystem/                    # Main project folder
    ├── VenueBookingSystem.csproj          # Project file
    ├── Web.config                         # Web configuration
    ├── Global.asax                        # ASP.NET app handler (C#: Global.asax.cs)
    ├── Bundle.config                      # CSS/JS bundling config
    │
    ├── Master Pages:
    ├── Site.Master                        # Main master page (C#: Site.Master.cs)
    ├── Site.Mobile.Master                 # Mobile version master page
    │
    ├── USER PAGES (Root Level):
    ├── Default.aspx                       # Home page (testimonials, featured venues)
    ├── Login.aspx                         # User login (C#: Login.aspx.cs)
    ├── Register.aspx                      # User registration (C#: Register.aspx.cs)
    ├── Logout.aspx                        # User logout (C#: Logout.aspx.cs)
    ├── ListVenues.aspx                    # Browse/filter venues (C#: ListVenues.aspx.cs)
    ├── VenueDetails.aspx                  # Venue details & booking (C#: VenueDetails.aspx.cs)
    ├── UserDashboard.aspx                 # User profile & dashboard (C#: UserDashboard.aspx.cs)
    ├── MyBookings.aspx                    # User's bookings list (C#: MyBookings.aspx.cs)
    │
    ├── INFORMATIONAL PAGES:
    ├── About.aspx                         # About us page (C#: About.aspx.cs)
    ├── Contact.aspx                       # Contact page (C#: Contact.aspx.cs)
    ├── Privacy.aspx                       # Privacy policy (C#: Privacy.aspx.cs)
    ├── Terms.aspx                         # Terms & Conditions (C#: Terms.aspx.cs)
    │
    ├── UTILITY:
    ├── PasswordHasher.cs                  # Password hashing utility class
    ├── ViewSwitcher.ascx                  # Mobile/Desktop view switcher control
    │
    ├── Admin/ Folder:
    ├── Dashboard.aspx                     # Admin dashboard with KPIs (C#: Dashboard.aspx.cs)
    ├── ManageVenues.aspx                  # Manage venues grid (C#: ManageVenues.aspx.cs)
    ├── ManageBookings.aspx                # View all bookings (C#: ManageBookings.aspx.cs)
    ├── VenueForm.aspx                     # Add/Edit venue form (C#: VenueForm.aspx.cs)
    │
    ├── App_Start/ Folder:
    ├── BundleConfig.cs                    # CSS/JS bundle definitions
    ├── RouteConfig.cs                     # URL routing configuration
    │
    ├── Content/ Folder:
    ├── bootstrap.css                      # Bootstrap 5 CSS (and variants)
    ├── Site.css                           # Custom site styling
    │
    ├── Scripts/ Folder:
    │   ├── bootstrap.bundle.js
    │   ├── jquery.js
    │   └── modernizr.js                   # HTML5 feature detection
    │
    ├── Images/ Folder:
    │   └── (Venue images stored here)
    │
    ├── App_Data/ Folder:
    │   └── (Application data files)
    │
    ├── Properties/ Folder:
    │   └── AssemblyInfo.cs                # Assembly metadata
    │
    └── obj/, bin/ Folders:
        └── (Compiled binaries & intermediate files)
```

---

## 5. ASP.NET CONTROLS INVENTORY BY PAGE

### 5.1 Default.aspx (Home Page)
**Controls:**
- `RepeaterReviews` (ID: RepeaterReviews) - Displays testimonials/reviews
  - Bound to: Feedback data
  - Template Fields: comment, city
- Labels and Hyperlinks for CTA buttons
- Navigation links for Browse Venues

**Current Status:** ✅ PARTIALLY COMPLETE - Home page displays testimonials and featured venues section

---

### 5.2 Login.aspx
**Controls:**
- `txtEmail` (TextBox, TextMode="Email") - Email/username input
- `txtPassword` (TextBox, TextMode="Password") - Password input
- `btnLogin` (Button) - Login submit button
- `lblErrorMessage` (Label, ForeColor="Red") - Error display
- Hyperlink to Register.aspx

**Current Status:** ✅ COMPLETE - Login functionality working

---

### 5.3 Register.aspx
**Controls:**
- `txtEmail` (TextBox, TextMode="Email")
- `RequiredFieldValidator` for Email
- `txtFullName` (TextBox)
- `RequiredFieldValidator` for Full Name
- `txtPassword` (TextBox, TextMode="Password")
- `RegularExpressionValidator` - Pattern: `^(?=.*[A-Z|a-z])(?=.*[0-9]).{4,}$`
  - Requirements: 4+ chars, 1 uppercase, 1 number
- `RequiredFieldValidator` for Password
- `txtCity` (TextBox)
- `RequiredFieldValidator` for City
- `txtPhoneNumber` (TextBox, TextMode="Phone") - Optional

**Current Status:** ✅ COMPLETE - Registration with validation working

---

### 5.4 ListVenues.aspx (Browse Venues)
**Controls:**
- **Filters (Left Sidebar):**
  - `txtBookingDate` (TextBox, TextMode="Date", AutoPostBack="true")
  - `cblCity` (CheckBoxList) - Dynamically populated cities
  - `cblVenueType` (CheckBoxList) - Dynamically populated venue types
  - Price range slider (implied)
  - Capacity filter (implied)

- **Venue Grid:**
  - Repeater or GridView displaying filtered venues
  - Each venue card shows: Image, Name, City, Type, Capacity, Price
  - Click to details button

**Current Status:** ✅ PARTIALLY COMPLETE - Filter controls in place, need to verify data binding

---

### 5.5 VenueDetails.aspx (Book Venue)
**Controls:**
- `imgVenue` (Image) - Venue display image
- `lblVenueName` (Label)
- `lblAvgRating` (Label) - Average rating from reviews
- `lblReviewCount` (Label) - Number of reviews
- `lblCity` (Label)
- `lblCapacity` (Label)
- `lblDescription` (Label) - Full venue description

- **Amenities/Add-ons:**
  - `chkCatering` (CheckBox) - Catering service
  - `chkDecoration` (CheckBox) - Theme decoration (₹5,000)
  - `OnCheckedChanged` event: CalculateTotal()

- **Booking Form:**
  - Calendar/Date picker for booking date
  - Cost calculation fields
  - Submit booking button
  - Review section with feedback from other users

**Current Status:** ✅ PARTIALLY COMPLETE - Venue display working, need to verify booking logic

---

### 5.6 UserDashboard.aspx (User Profile/Dashboard)
**Controls:**
- User greeting (Username/Email)
- Statistics cards: Total Bookings, Upcoming Events, Saved Venues
- Quick links to My Bookings, Browse Venues
- Profile information display
- Edit profile button/form

**Current Status:** ⚠️ IN PROGRESS - Dashboard structure in place

---

### 5.7 MyBookings.aspx (User Bookings List)
**Controls:**
- `gvUserBookings` (GridView)
  - Columns:
    - `VenueName` (BoundField)
    - `BookingDate` (BoundField, DataFormatString="{0:dd MMM yyyy}")
    - `BookingStatus` (TemplateField with Badge)
      - Confirmed: bg-success (green)
      - Pending: bg-warning (yellow)
    - `TotalCost` (BoundField, DataFormatString="₹{0:N0}")
    - `Actions` (TemplateField)
      - `btnCancel` (LinkButton) - Visible only for Pending bookings
      - Confirmation dialog: "Are you sure you want to cancel this booking?"

- `EmptyDataTemplate` - "You haven't made any bookings yet."

**Current Status:** ✅ PARTIALLY COMPLETE - GridView structure in place, cancellation logic needed

---

### 5.8 About.aspx, Contact.aspx, Privacy.aspx, Terms.aspx
**Status:** ⚠️ PARTIAL - Static pages, informational content only

---

### 5.9 Admin/Dashboard.aspx (Admin Dashboard)
**Controls:**
- **KPI Cards (4 cards in a row):**
  - `lblTotalRevenue` (Label) - Shows ₹ symbol
    - CSS Class: `admin-card-gold`
  - `lblPendingBookings` (Label)
    - CSS Class: `admin-card-teal` with `border-start border-5 border-warning`
  - `lblTotalVenues` (Label)
    - CSS Class: `admin-card-teal`
  - `lblTotalUsers` (Label)
    - CSS Class: `admin-card-teal`

- Each card includes:
  - `.stat-label` - Card title
  - `.stat-number` - Large numeric value

**Current Status:** ⚠️ IN PROGRESS - Dashboard structure in place, data binding needed

---

### 5.10 Admin/ManageVenues.aspx
**Controls:**
- `gvManageVenues` (GridView)
  - DataKeyNames: "VenueId"
  - Columns:
    - Image (TemplateField) - 60px × 40px thumbnail
    - `Name` (BoundField)
    - `City` (BoundField)
    - `VenueType` (BoundField)
    - `Capacity` (BoundField)
    - `BasePrice` (BoundField, DataFormatString="₹{0:N0}")
    - Status (TemplateField with Badge)
      - Active: bg-success
      - Hidden: bg-danger
    - Actions (TemplateField)
      - Edit button (hyperlink to VenueForm.aspx)
      - Delete button (LinkButton with confirmation)

- Header Button: "+ Add New Venue" (Link to VenueForm.aspx)

**Current Status:** ✅ PARTIALLY COMPLETE - GridView layout done, CRUD operations needed

---

### 5.11 Admin/ManageBookings.aspx
**Controls:**
- Similar to MyBookings but for all bookings
- Additional columns: User email, Payment status
- Status filter/buttons to change booking status
- (Details not fully visible - similar structure expected)

**Current Status:** ⚠️ NOT STARTED - Structure needs to be implemented

---

### 5.12 Admin/VenueForm.aspx (Add/Edit Venue)
**Expected Controls:**
- `txtVenueName` (TextBox) - Venue name
- `txtDescription` (TextBox, TextMode="MultiLine") - Description
- Venue type dropdown/selection
- `txtCapacity` (TextBox, TextMode="Number") - Max capacity
- `txtBasePrice` (TextBox, TextMode="Number") - Base price
- `txtCity` (TextBox or DropDown) - City selection
- `txtContactEmail` (TextBox, TextMode="Email")
- `txtContactPhone` (TextBox, TextMode="Phone")
- `chkIsAvailable` (CheckBox) - Active status
- Image upload control
- Save button
- Cancel button

**Current Status:** ⚠️ IN PROGRESS - Form structure in place

---

## 6. USER VS ADMIN FILE SEPARATION

### 6.1 User-Facing Pages
**Location:** `/VenueBookingSystem/` (root web directory)

```
Default.aspx              → Home/Landing page
Login.aspx                → User login
Register.aspx             → User registration
ListVenues.aspx           → Browse venues
VenueDetails.aspx         → View venue & book
UserDashboard.aspx        → User profile/dashboard
MyBookings.aspx           → View personal bookings
About.aspx                → Company info
Contact.aspx              → Contact form
Privacy.aspx              → Privacy policy
Terms.aspx                → Terms & conditions
```

### 6.2 Admin Pages
**Location:** `/VenueBookingSystem/Admin/` (subdirectory)

```
Admin/Dashboard.aspx      → Admin overview (KPIs, stats)
Admin/ManageVenues.aspx   → List all venues, add/edit/delete
Admin/ManageBookings.aspx → List all bookings, change status
Admin/VenueForm.aspx      → Venue creation/editing form
```

### 6.3 Access Control
**Master File:** `Site.Master`

**Navigation Logic in Site.Master:**
- `navDashboard` - Visible ONLY if logged in (User role)
- `navAdmin` - Visible ONLY if logged in AND Role = "Admin"
- `navLogin` - Visible if NOT logged in
- `navRegister` - Visible if NOT logged in
- `navLogout` - Visible if logged in

**Breadcrumb Navigation:**
- Dynamically shows based on user role
- Admin redirects to ~/Admin/AdminDashboard.aspx
- Users redirect to ~/Default.aspx

### 6.4 Session Management
**Session Variables Used:**
- `Session["UserId"]` - Current user's ID (INT)
- `Session["UserEmail"]` - Current user's email (STRING)
- `Session["UserRole"]` - "Admin" or "User" (STRING)
- `Session["UserName"]` - Full name (STRING)

---

## 7. WORK COMPLETION STATUS

| Feature | Status | Notes |
|---------|--------|-------|
| **Database Schema** | ✅ COMPLETE | All 4 tables created with relationships |
| **User Authentication** | ✅ COMPLETE | Login & Register pages working |
| **Home Page** | ✅ PARTIAL | Testimonials and featured venues showing |
| **Browse Venues** | ⚠️ IN PROGRESS | Filters UI ready, need data binding |
| **Venue Details** | ⚠️ IN PROGRESS | Display working, booking logic pending |
| **Booking System** | ⚠️ IN PROGRESS | Form structure ready, backend logic pending |
| **My Bookings** | ⚠️ IN PROGRESS | GridView ready, cancellation logic pending |
| **User Dashboard** | ⚠️ IN PROGRESS | Basic structure, profile features needed |
| **Admin Dashboard** | ⚠️ IN PROGRESS | UI layout done, KPI calculations pending |
| **Manage Venues** | ⚠️ IN PROGRESS | GridView ready, CRUD operations pending |
| **Manage Bookings** | ❌ NOT STARTED | Needs implementation |
| **Venue Form (Add/Edit)** | ⚠️ IN PROGRESS | Form structure in place |
| **Feedback/Reviews** | ⚠️ IN PROGRESS | Display on venue details needs work |
| **Payment Status Tracking** | ⚠️ IN PROGRESS | Field exists, logic pending |
| **Logout Functionality** | ✅ COMPLETE | Session cleanup working |
| **Responsive Design** | ✅ COMPLETE | Bootstrap 5 applied throughout |
| **Styling/Theme** | ✅ COMPLETE | Teal color scheme applied |

---

## 8. KEY TECHNOLOGY STACK

| Component | Technology | Version |
|-----------|-----------|---------|
| **Framework** | ASP.NET WebForms | .NET Framework 4.x |
| **Language** | C# | - |
| **Database** | SQL Server | (T-SQL) |
| **UI Framework** | Bootstrap | 5.2.3 |
| **JavaScript** | jQuery | 3.7.0 |
| **JSON** | Newtonsoft.Json | 13.0.3 |
| **CSS Preprocessor** | N/A | (Custom CSS) |
| **Bundling** | ASP.NET Web Optimization | 1.1.3 |

---

## 9. IMPORTANT CLASSES & UTILITIES

### 9.1 PasswordHasher.cs
**Purpose:** Secure password hashing for user registration and login  
**Location:** `VenueBookingSystem/PasswordHasher.cs`  
**Methods:** (Hash, Verify - assumed)

### 9.2 Master Page Controls (Site.Master)
**Key ID's for Navigation Control:**
- `navDashboard` - User dashboard link (conditional visibility)
- `navAdmin` - Admin panel link (conditional visibility)
- `navLogin` - Login link
- `navRegister` - Register link
- `navLogout` - Logout link (red text color)
- `lnkHome` - Breadcrumb home link

---

## 10. NAVIGATION FLOW

```
┌─────────────────────────────────────────────────────────────────┐
│                    VISITOR (Not Logged In)                      │
├─────────────────────────────────────────────────────────────────┤
│  Default.aspx → Login.aspx ──────┐                              │
│                                    ├─→ Session Created           │
│  Default.aspx ← Register.aspx ────┘                              │
│        │                                                         │
│        └─→ ListVenues.aspx (Browse without login)               │
│               │                                                  │
│               └─→ VenueDetails.aspx (View only, can't book)     │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                  LOGGED IN USER (Role = "User")                 │
├─────────────────────────────────────────────────────────────────┤
│  Default.aspx                                                   │
│        │                                                        │
│        ├─→ UserDashboard.aspx ──┐                              │
│        │                          ├─→ MyBookings.aspx           │
│        │                          │      │                      │
│        │                          │      └─→ Cancel Booking     │
│        │                          │                              │
│        │                          └─→ Edit Profile              │
│        │                                                        │
│        └─→ ListVenues.aspx                                      │
│               │                                                  │
│               └─→ VenueDetails.aspx ──→ Book Venue              │
│                      │                                           │
│                      └─→ View Reviews & Submit Feedback         │
│                                                                 │
│  Logout.aspx ──→ Clear Session ──→ Default.aspx               │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                  LOGGED IN ADMIN (Role = "Admin")               │
├─────────────────────────────────────────────────────────────────┤
│  Admin/Dashboard.aspx (KPI Overview)                            │
│        │                                                        │
│        ├─→ Admin/ManageVenues.aspx                              │
│        │      │                                                 │
│        │      ├─→ Admin/VenueForm.aspx (Add New)               │
│        │      │                                                 │
│        │      └─→ Admin/VenueForm.aspx (Edit)                  │
│        │                                                        │
│        └─→ Admin/ManageBookings.aspx (View & Change Status)    │
│                                                                 │
│  Also has access to all user pages for testing                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 11. CONFIGURATION FILES

### 11.1 Web.config
**Purpose:** ASP.NET application configuration  
**Key Settings:**
- Database connection string (to be added/updated)
- Authentication mode
- Compilation settings
- Custom error pages

### 11.2 Bundle.config
**Purpose:** CSS/JavaScript bundling for performance  
**Managed By:** BundleConfig.cs in App_Start

### 11.3 VenueBookingSystem.csproj
**Purpose:** Project file with dependencies and build settings  
**Package Dependencies:**
- bootstrap 5.2.3
- jQuery 3.7.0
- Newtonsoft.Json 13.0.3
- Microsoft.AspNet.Web.Optimization 1.1.3

---

## 12. CODING STANDARDS & PATTERNS

### 12.1 Naming Conventions
- **ASP.NET Controls:** camelCase with type prefix
  - `txt` = TextBox (e.g., `txtEmail`)
  - `lbl` = Label (e.g., `lblTotalRevenue`)
  - `btn` = Button (e.g., `btnLogin`)
  - `chk` = CheckBox (e.g., `chkCatering`)
  - `cbl` = CheckBoxList (e.g., `cblCity`)
  - `gv` = GridView (e.g., `gvUserBookings`)
  - `img` = Image (e.g., `imgVenue`)

- **CSS Classes:** kebab-case (e.g., `admin-card-gold`, `venue-img`)

### 12.2 File Organization
- **Code-behind files:** Separate .aspx.cs and .aspx.designer.cs files
- **Master pages:** Site.Master and Site.Mobile.Master
- **Subdirectories:** Admin/ for admin pages, Content/ for CSS, Scripts/ for JS

### 12.3 Data Binding
- Uses asp:Repeater for testimonials
- Uses asp:GridView for data tables
- Uses asp:CheckBoxList for multi-select filters
- Bind() method for inline data binding in templates

---

## 13. COMMON ISSUES & DEBUGGING

### Known Issues:
1. **ManageBookings.aspx** - Not yet created, needs implementation
2. **Feedback display** - May need optimization for large datasets
3. **Image handling** - Ensure proper path resolution for venue images
4. **Session timeout** - Add session timeout warning before logout
5. **Responsive design** - Test on mobile devices for mobile master page

### Testing Checklist:
- [ ] Test login/logout flow
- [ ] Test venue filtering (city, type, date)
- [ ] Test booking with add-ons (catering, decoration)
- [ ] Test admin CRUD operations on venues
- [ ] Test booking cancellation
- [ ] Test feedback submission and display
- [ ] Test responsive design on mobile (Site.Mobile.Master)
- [ ] Test password validation
- [ ] Check database relationships and constraints
- [ ] Verify admin role access restrictions

---

## 14. FUTURE ENHANCEMENT OPPORTUNITIES

1. **Payment Integration** - Stripe/Razorpay for online payments
2. **Email Notifications** - Booking confirmation emails
3. **Venue Search Enhancement** - Advanced filters, price range slider
4. **User Reviews Rating** - 5-star rating system with individual reviews
5. **Wishlist Feature** - Save favorite venues
6. **Promotional Codes** - Discount coupon system
7. **Admin Reports** - Revenue reports, booking trends
8. **Venue Gallery** - Multiple images per venue
9. **Live Chat Support** - Customer support chatbot
10. **Mobile App** - Native mobile application

---

## 15. QUICK REFERENCE - IMPORTANT IDs & METHODS

### Session Variables:
```csharp
Session["UserId"]          // int
Session["UserEmail"]       // string
Session["UserRole"]        // "Admin" or "User"
Session["UserName"]        // string
```

### GridView Event Handlers:
```csharp
gvUserBookings_RowCommand          // Handle action button clicks
gvManageVenues_RowDeleting         // Handle venue deletion
```

### Key Methods to Implement:
- `CalculateTotal()` - Calculate booking cost with add-ons
- `FilterVenues()` - Apply city/type/date filters
- `CancelBooking()` - Cancel pending bookings
- `ChangeBookingStatus()` - Admin status changes
- `GetAverageRating()` - Calculate venue rating from feedbacks
- `GetTopRatedVenues()` - Fetch featured venues for homepage

---

## 16. FILE EXTENSION SELECTION

**This documentation uses: `.md` (Markdown)**

**Reasons:**
- ✅ Lightweight and readable in any text editor
- ✅ GitHub-compatible for version control
- ✅ Easily converted to HTML/PDF
- ✅ Supports code blocks and formatting
- ✅ Can be read in VS Code with live preview
- ✅ Industry standard for technical documentation

---

**Document Revision:**
- V1.0 - Initial comprehensive documentation (Feb 8, 2026)

**For inquiries or updates,** please update this document's "Last Updated" date and revision history.

---

*Generated for AI Coding Agents - Next Developer Reference*
