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
<p align="center">
  <img src="https://github.com/aliasar1/Blogs-App/blob/main/repo_assets/splash.png" alt="Splash Screen">
</p>

### Login Screnn
<p align="center">
  <img src="https://github.com/aliasar1/Blogs-App/blob/main/repo_assets/login.png" alt="Login Screen">
</p>

### Signup Screen
<p align="center">
  <img src="https://github.com/aliasar1/Blogs-App/blob/main/repo_assets/signup.png" alt="Signup Screen">
</p>

### All Blogs Screen
<p align="center">
  <img src="https://github.com/aliasar1/Blogs-App/blob/main/repo_assets/all_blogs.png" alt="All Blogs Screen">
</p>

### My Blogs Screen
<p align="center">
  <img src="https://github.com/aliasar1/Blogs-App/blob/main/repo_assets/my_blogs.png" alt="My Blogs Screen">
</p>

### Add Blog Screen
<p align="center">
  <img src="https://github.com/aliasar1/Blogs-App/blob/main/repo_assets/add_blog.png" alt="Add Blogs Screen">
</p>

### Blog Details Screen
<p align="center">
  <img src="https://github.com/aliasar1/Blogs-App/blob/main/repo_assets/blog_overview.png" alt="Blogs overview Screen">
  <img src="https://github.com/aliasar1/Blogs-App/blob/main/repo_assets/blog_overview_2.png" alt="Blogs overview Screen">
  <img src="https://github.com/aliasar1/Blogs-App/blob/main/repo_assets/blog_overview_3.png" alt="Blogs overview Screen">
</p>

### Delete Blog Screen
<p align="center">
  <img src="https://github.com/aliasar1/Blogs-App/blob/main/repo_assets/delete_blog.png" alt="Delete Blog Screen">
</p>

### Edit Blog Screen
<p align="center">
  <img src="https://github.com/aliasar1/Blogs-App/blob/main/repo_assets/edit_blog.png" alt="Edit Blog Screen">
</p>

### Bookmark Screen
<p align="center">
  <img src="https://github.com/aliasar1/Blogs-App/blob/main/repo_assets/bookmark.png" alt="Bookmark Blog Screen">
</p>

### Drawer For Screen Navigation
<p align="center">
  <img src="https://github.com/aliasar1/Blogs-App/blob/main/repo_assets/drawer.png" alt="Drawer">
</p>

### Logout
<p align="center">
  <img src="https://github.com/aliasar1/Blogs-App/blob/main/repo_assets/logout.png" alt="Logout Screen">
</p>

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
