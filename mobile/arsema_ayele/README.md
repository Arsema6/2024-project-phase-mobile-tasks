# Flutter Ecommerce UI & Navigation
## Task 6: Implementing a Flutter User Interface
**Objective:**
Create a Flutter user interface that replicates the design of a provided picture (see Figma link below). The UI was built using custom images and creative assets.
- **Design Replication:** The UI closely follows the provided reference, matching colors, layout, typography, and design elements.
- **Widgets Used:** The app uses core Flutter widgets such as `Container`, `Column`, `Row`, `Image`, `Text`, `Button`, and more to achieve the design.
- **Screenshots:** UI screenshots are included in the `assets/screenshots` folder.
  <img width="546" height="848" alt="homepage" src="https://github.com/user-attachments/assets/5448ece3-c02b-483f-8e21-267e18f1775c" /><img width="613" height="920" alt="description" src="https://github.com/user-attachments/assets/bf4b06fd-07c3-4294-8d50-2575b8dbfb03" />
  <img width="539" height="840" alt="edit" src="https://github.com/user-attachments/assets/3ec94632-0f75-4d38-a9e2-04c87597f5bb" />

  <img width="601" height="915" alt="addproduct" src="https://github.com/user-attachments/assets/9957e4b7-e9f5-4e60-9e39-9a36307e11e2" />
  <img width="541" height="984" alt="search" src="https://github.com/user-attachments/assets/5d430d01-39b0-4b7d-897c-8bb0a8a8d5c9" />

  `/https://github.com/Arsema6/2024-project-phase-mobile-tasks/tree/main/mobile/arsema_ayele/assets/screenshots`
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
