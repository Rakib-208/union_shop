🛍️ Union Shop
---------------------------------------------------------------------------------------

Union Shop is a fully responsive Flutter-based e-commerce application developed for university students to browse, customize, and purchase merchandise with a seamless, personalized experience. It features product catalog filtering, Firebase authentication, personalized print services, and persistent cart and order history—crafted with scalability and maintainability in mind.



🚀 Features
---------------------------------------------------------------------------------------

🛒 Core Shopping Experience

Full product catalog with categorized collections: Clothing, Accessories, Sale items, and All Products.

Smart filtering by size, color, and price.

Real-time product search with fuzzy keyword matching and dynamic scoring.

Product detail pages with size, color, and quantity selectors.

Add-to-cart and Buy-Now flows with persistent local storage.



👕 Personalised Print Shack
---------------------------------------------------------------------------------------

Customizable text-based product personalization (1 or 2 lines).

Dynamic form and validation based on user input.

Personalized items seamlessly integrated into the cart and order system.

👤 Authentication & Orders

Firebase email/password login and signup.

Snackbar-based user feedback for auth actions.

Order history stored locally and displayed in collapsible, detailed tiles.

Firebase integration with graceful error handling.



🧭 Navigation & Layout
---------------------------------------------------------------------------------------

Responsive design for desktop, tablet, and mobile views.

Shared AppHeader and Footer for consistent layout across pages.

Named route navigation for all major sections.

Auto-persistence of cart and orders via SharedPreferences.


📄 Static Pages
---------------------------------------------------------------------------------------

About Us

Terms & Conditions

Print Shack Info Page

---------------------------------------------------------------------------------------
🛠️ Getting Started
🔧 Prerequisites
---------------------------------------------------------------------------------------

Flutter 3.x

Dart 3.x

Firebase project with Email/Password Auth enabled

---------------------------------------------------------------------------------------
📦 Installation
---------------------------------------------------------------------------------------

Clone the repository:
git clone https://github.com/Rakib-208/union-shop.git && cd union-shop

Install dependencies:
flutter pub get

Add your Firebase configuration:

Place google-services.json (Android) in android/app/

Place GoogleService-Info.plist (iOS) in ios/Runner/

Run the app:
flutter run
---------------------------------------------------------------------------------------
🔍 Key Packages Used
---------------------------------------------------------------------------------------
Package	Purpose
firebase_auth	Authentication handling
shared_preferences	Persistent local storage
url_launcher	External email/contact link support
flutter/material	UI components and theming


🧪 Testing Suggestions
---------------------------------------------------------------------------------------

✅ Login and signup with dummy Firebase accounts.

✅ Add and personalize a product using Print Shack.

✅ Search for items with synonyms (e.g. “tshirt”, “tee”, “accessory”).

✅ Resize the window to verify adaptive layout.

✅ Try Buy Now flow and validate order history persistence.

---------------------------------------------------------------------------------------
🧑‍🎓 Project Context
---------------------------------------------------------------------------------------
📄 License

This project is intended for academic use. Commercial reuse is not permitted without written consent.

🤝 Contact

Maintained by: MD RAKIBUL HASSAN HREDOY
For queries or collaborations, please reach out at ra.hasan3210@gamil.com