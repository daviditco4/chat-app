# Chat App

This is an online text chat that lets you sign up with a new username, email, password and photo.
Also, this is the sixth Flutter app I made in Academind's Flutter & Dart course.

Links to the course:

* On Udemy.com - [Flutter & Dart - The Complete Guide](https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/)
* On Academind.com - [Learn Flutter & Dart to Build iOS & Android Apps](https://pro.academind.com/p/learn-flutter-dart-to-build-ios-android-apps-2020)

## Concepts used during development

* Firebase basics
  * What is it?
  * Getting started with Firebase and the FlutterFire SDK
  * Adding Firebase security rules
* More Dart & Flutter basics
  * Rendering Stream data with StreamBuilder
* More core widgets
  * ButtonBar
* More theming basics
  * Using a dark theme
* Authenticating users with the FlutterFire SDK
  * Implementing user sign-up, sign-in & sign-out
  * Modifying the username & photo of a created user
* Using the Cloud Firestore database to manage chat messages sent by users
  * Listening to chat messages
  * Sending & ordering chat messages
* Using Firebase's Cloud Storage to upload photos of users
* Creating an Instagram-like chat bubble UI
  * Rendering the user photo at the bottom of a group of messages and the username at the top
* Working with push notifications for Android & iOS
  * How it works
  * Notification messages vs. data messages
  * Getting started with Android & Firebase Cloud Messaging
  * Getting started with iOS & Firebase Cloud Messaging
  * Implementing functions for handling notification messages & data messages
  * Providing a custom notification ringtone, color and photo
  * Using topics for sending notifications to a group of users only
* Using Firebase Cloud Functions to send automated push notifications for Android & iOS
  * Getting started with Cloud Functions
  * Setting a Firestore trigger
  * Extracting data from a Firestore Database entry to create the push notification

## Getting Started

Read this for downloading and installing the app from your mobile device.

### Prerequisites

You'll need:

```
- Android KitKat or later (version 4.4, API level 19).

- Installation of apps from unknown sources permitted (see the "Setting up your device"
section at https://www.cnet.com/tech/mobile/how-to-install-apps-outside-of-google-play/).

- The application's binary file (download from the "Releases" section in this project's
GitHub repository home page), then begin the installation by opening the file.
```

### How to use

1. Open the app.
2. Tap "Sign Up Instead".
3. Enter your photo, email, username and a new password.
4. Tap "Sign Up".
5. Scroll through the chat history to read messages from other people.
6. To send a new message, enter some text in the bottom field, then tap the "send" button.
7. Once you finish using the app, open the pop-up menu at the upper-right corner of the screen and tap "Sign Out".
8. To sign in again, enter your email and password, then tap "Sign In".

Screenshots:

<p float="left">
  <img alt="App Screenshot 1" src="/dev_assets/images/app_screenshot_1.png" width="250" />
  <img alt="App Screenshot 2" src="/dev_assets/images/app_screenshot_2.png" width="250" />
  <img alt="App Screenshot 3" src="/dev_assets/images/app_screenshot_3.png" width="250" />
  <img alt="App Screenshot 4" src="/dev_assets/images/app_screenshot_4.png" width="250" />
  <img alt="App Screenshot 5" src="/dev_assets/images/app_screenshot_5.png" width="250" />
  <img alt="App Screenshot 6" src="/dev_assets/images/app_screenshot_6.png" width="250" />
  <img alt="App Screenshot 7" src="/dev_assets/images/app_screenshot_7.png" width="250" />
  <img alt="App Screenshot 8" src="/dev_assets/images/app_screenshot_8.png" width="250" />
  <img alt="App Screenshot 9" src="/dev_assets/images/app_screenshot_9.png" width="250" />
</p>

## Built with

* [Dart 2.13.4](https://dart.dev/) - The programming language used

## Authors

* **David Itcovici** - [LinkedIn](https://www.linkedin.com/in/david-itcovici/)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
