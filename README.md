# Blog App

This is a simple blog app created using Flutter and Firebase, with state management handled by GetX and following the MVC design pattern.

## Features

- User registration: Users can create an account by providing their email and password.
- User login: Users can log in to their account using their registered email and password.
- Persistent login state: The app remembers the user's login state, so they don't need to log in again after closing the app.
- Create a blog: Logged-in users can create new blog posts by providing a title, content, and optional image.
- Read blogs: Users can view all blogs created by other users.
- Update a blog: The original author of a blog can edit and update the blog post's title, content, and image.
- Delete a blog: The original author can also delete their blog post.
- Bookmark blogs: Users can bookmark their favorite blogs for later reference.
- Search Blog: User can search blogs using titles to match.

## Technologies Used

- Flutter: a UI toolkit for building natively compiled applications for mobile, web, and desktop.
- GetX: a powerful package for state management and navigation in Flutter applications.
- Firebase: a mobile and web application development platform that provides backend services and easy-to-use SDKs.

## Architecture

The app follows the MVC (Model-View-Controller) design pattern, where each component has a specific role:

- Model: Represents the data structures and business logic of the application.
- View: Handles the user interface, including the layout, widgets, and visual elements.
- Controller: Mediates between the model and the view, handling user input, processing data, and updating the model.

GetX is used for state management, providing reactive updates to the view whenever the model changes. It simplifies the process of managing app state, navigation, and dependency injection.

## Screenshots

### Splash Screen
![image](https://github.com/aliasar1/Blogs-App/assets/74453775/24ba123a-e0ca-4e23-87b9-f055f9448d4a)

### Login Screnn
![image](https://github.com/aliasar1/Blogs-App/assets/74453775/c552011a-8ec9-429f-aab4-543e42d87623)

### Signup Screen
![image](https://github.com/aliasar1/Blogs-App/assets/74453775/012c3dc0-6dd6-4806-8db0-9e47960a45f5)

### All Blogs Screen
![image](https://github.com/aliasar1/Blogs-App/assets/74453775/8088dbb7-99a7-42da-a496-581d10c6614c)

### My Blogs Screen
![image](https://github.com/aliasar1/Blogs-App/assets/74453775/79964f04-c445-45e0-b994-78e8256c4136)

### Add Blog Screen
![image](https://github.com/aliasar1/Blogs-App/assets/74453775/eaac70c2-d70b-4ee3-bfc0-92eadb5edbad)

### Blog Details Screen
![image](https://github.com/aliasar1/Blogs-App/assets/74453775/e241d567-7599-47e0-96b1-4a9f788b1852)
![image](https://github.com/aliasar1/Blogs-App/assets/74453775/4c7e613c-23fa-4d6c-8c01-1a1857bdad1c)

### Delete Blog Screen
![image](https://github.com/aliasar1/Blogs-App/assets/74453775/1abcc5bb-f236-4b52-8fd1-ac472239d63f)

### Edit Blog Screen
![image](https://github.com/aliasar1/Blogs-App/assets/74453775/80bf0570-a2c3-4eb5-b1c0-f45fc65fd1e0)

### Bookmark Screen
![image](https://github.com/aliasar1/Blogs-App/assets/74453775/8afbede3-7af3-4f8e-9a19-a70184d8cd4f)

### Drawer For Screen Navigation
![image](https://github.com/aliasar1/Blogs-App/assets/74453775/5fbf1456-a0a5-478c-98ae-e254c85bd9a7)

### Logout
![image](https://github.com/aliasar1/Blogs-App/assets/74453775/1d739a42-2d5d-4cab-830f-291f645e9bed)

## Getting Started

To run this app locally, follow these steps:

1. Clone this repository: `https://github.com/aliasar1/Blogs-App.git`
2. Navigate to the project directory: `cd Blogs-App`
3. Ensure that you have Flutter installed on your machine. If not, follow the official Flutter installation guide: [Flutter - Get Started](https://flutter.dev/docs/get-started)
4. Connect your device or start an emulator.
5. Run the app: `flutter run`

Make sure to configure Firebase in your project. Refer to the official Firebase documentation for detailed instructions on setting up Firebase with Flutter: [Firebase for Flutter](https://firebase.flutter.dev/)

## Configuration

Before running the app, make sure to configure the Firebase project in your Flutter app. You'll need to:

1. Create a new Firebase project: Visit the [Firebase Console](https://console.firebase.google.com/) and create a new project.
2. Add google-services file which is generated.
3. Enable Firebase Authentication: In the Firebase Console, navigate to the "Authentication" section and enable the desired authentication methods (e.g., email/password).
4. Enable Firebase Firestore to use database service.

## Contributing

Contributions are welcome! If you find any bugs or have suggestions for new features, please open an issue or submit a pull request.

When contributing to this project, please follow the existing code style and conventions. Make sure to test your changes thoroughly before submitting a pull request.
