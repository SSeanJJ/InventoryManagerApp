# Inventory Manager App

A cross-platform inventory management application built with Flutter and Dart. The application uses Firebase Authentication for user authentication and Cloud Firestore for cloud-based inventory storage and synchronization.

## Overview

The Inventory Manager App allows users to create an account, sign in, and manage inventory data through a Flutter-based user interface. The project integrates Firebase services to provide authentication and persistent cloud data storage.

The application was developed using MVC principles to separate the user interface, application logic, and data management responsibilities.

## Features

* User registration and authentication
* Secure login using Firebase Authentication
* Create, view, update, and delete inventory items
* Cloud-based inventory storage with Cloud Firestore
* Real-time inventory data synchronization
* Input validation to prevent invalid inventory entries
* Client-side state management
* Cross-platform application architecture
* MVC-based organization of application components

## Technologies

### Flutter

Flutter is used to build the application's user interface and provides the ability to target multiple platforms from a shared codebase.

### Dart

Dart is the primary programming language used to implement the application's UI, business logic, state management, and Firebase integration.

### Firebase Authentication

Firebase Authentication provides user registration and login functionality, allowing inventory data and application functionality to be associated with authenticated users.

### Cloud Firestore

Cloud Firestore is used as the application's cloud-hosted NoSQL database. Inventory information is stored as documents within Firestore collections and can be retrieved and updated by the application.

## Architecture

The application follows Model-View-Controller (MVC) principles to separate responsibilities within the application.

### Model

Represents the application's inventory data and associated data structures.

### View

Contains the Flutter user interface and displays information to the user.

### Controller

Handles application logic and coordinates interactions between the user interface, application data, and Firebase services.

This separation helps keep the application organized and makes individual components easier to maintain and extend.

## Application Flow

A typical application flow is:

1. The user opens the application.
2. The user registers or signs in.
3. Firebase Authentication verifies the user's credentials.
4. The authenticated user accesses the inventory interface.
5. The user creates, views, updates, or deletes inventory items.
6. User input is validated before inventory changes are processed.
7. Inventory data is stored and retrieved using Cloud Firestore.
8. The Flutter interface reflects the current application state and inventory data.

## Data Management

The application supports the standard CRUD operations:

* Create - Add a new inventory item.
* Read - Retrieve and display existing inventory items.
* Update - Modify an existing inventory item.
* Delete - Remove an inventory item.

Cloud Firestore provides persistent cloud storage for inventory information and allows application data to remain available across sessions and supported devices.

## Input Validation

Client-side input validation is used to prevent invalid or incomplete inventory information from being submitted. Validation helps maintain consistent data and provides users with immediate feedback when information needs to be corrected.

## Project Structure

The project follows the standard Flutter project structure, with the main application source code located in the `lib` directory.

```text
InventoryManagerApp/
├── android/
├── ios/
├── lib/
├── linux/
├── macos/
├── web/
├── windows/
├── pubspec.yaml
└── README.md
```

The `pubspec.yaml` file defines the Flutter project configuration and dependencies, including Firebase Core, Firebase Authentication, and Cloud Firestore.

## Getting Started

### Prerequisites

To run the project locally, you will need:

* Flutter SDK
* Dart SDK
* A supported IDE such as Visual Studio Code or Android Studio
* A configured Firebase project
* A supported emulator, simulator, browser, or physical device

### Installation

Clone the repository:

```bash
git clone https://github.com/SSeanJJ/InventoryManagerApp.git
```

Navigate into the project directory:

```bash
cd InventoryManagerApp
```

Install the Flutter dependencies:

```bash
flutter pub get
```

Ensure the required Firebase configuration is available for the target platform.

Run the application:

```bash
flutter run
```

## Key Concepts Demonstrated

This project demonstrates experience with:

* Cross-platform application development
* Object-oriented programming with Dart
* Flutter UI development
* Firebase integration
* User authentication
* NoSQL databases
* CRUD operations
* Application state management
* Input validation
* MVC architecture
* Separation of concerns
* Asynchronous cloud operations

## Future Improvements

Potential improvements include:

* Expanded automated testing
* Additional inventory search and filtering
* Improved error handling and user feedback
* Enhanced Firebase security rules
* Additional server-side validation
* Inventory categories and organization
* Improved responsive UI
* Additional reporting and inventory analytics

## Purpose

This project was developed to gain experience building a complete application that combines a cross-platform user interface with authentication, cloud-based persistent storage, state management, and structured application architecture.
