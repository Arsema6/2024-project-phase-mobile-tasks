# Flutter Ecommerce UI & Navigation
## Task 6: Implementing a Flutter User Interface
**Objective:**
Create a Flutter user interface that replicates the design of a provided picture (see Figma link below). The UI was built using custom images and creative assets.
- **Design Replication:** The UI closely follows the provided reference, matching colors, layout, typography, and design elements.
- **Widgets Used:** The app uses core Flutter widgets such as `Container`, `Column`, `Row`, `Image`, `Text`, `Button`, and more to achieve the design.
- **Screenshots:** UI screenshots are included in the `assets/screenshots/` folder.
- **Figma Link:** [Link]
## Task 7: Implementing Navigation and Routing in an Ecommerce Mobile App
This project is a simple e-commerce mobile app built with Flutter. It allows users to create, view, update, and delete products, with seamless navigation and routing.
### Features
- **Screen Navigation:**
  - Home screen: Displays a list of all products.
  - Add/Edit Product screen: Allows users to add or edit product details.
  - Product Description screen: View details of a selected product.
  - Navigation between screens uses Flutter's built-in navigation methods.
- **Named Routes:**
  - All screens are registered with named routes for clean and maintainable navigation.
- **Passing Data Between Screens:**
  - Product data is passed between screens for creation, editing, and viewing.
- **Navigation Animations:**
  - Smooth transitions and animations are implemented for a better user experience.
- **Handling Navigation Events:**
  - Back button and other navigation events are handled to ensure an intuitive flow.
### How to Run the App
1. Clone the repository:
   ```sh
   git clone https://github.com/Arsema6/2024-project-phase-mobile-tasks.git
   cd 2024-project-phase-mobile-tasks/mobile/arsema_ayele
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Run the app:
   ```sh
   flutter run
   ```
### Project Structure
- `lib/` - Main source code (UI, navigation, logic)
- `assets/` - Images and screenshots
- `android/`, `ios/`, `web/`, `linux/`, `macos/`, `windows/` - Platform-specific code
