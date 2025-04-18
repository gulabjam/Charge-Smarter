
# ⚡ Charge Smarter

**Charge Smarter** is an innovative mobile application built to help Electric Vehicle (EV) owners **efficiently locate nearby charging stations** while **monitoring battery levels in real time**. Developed using **Flutter** for cross-platform support, it integrates **Google Maps API** for seamless navigation and **Firebase** for backend services.

---

## 📱 Key Features

- 🔋 **Battery Monitoring**  
  Real-time battery status and estimated driving range with critical battery alerts.

- 📍 **Charging Station Locator**  
  Google Maps integration with station markers, filters (distance, connector type, availability), and turn-by-turn navigation.

- 🔐 **User Authentication**  
  Firebase-powered secure login and registration system.

- 🏠 **Home Dashboard**  
  Clean and intuitive interface to view battery levels and nearby charging stations.

---

## 📁 Project Structure

```
/charge-smarter
├── README.md
├── pubspec.yaml
├── pubspec.lock
├── analysis_options.yaml
├── firebase.json
├── gradle.properties
├── gradlew
├── gradlew.bat
├── settings.gradle.kts
├── sample_app.iml
├── assets/
│   ├── battery_background.jpeg
│   ├── excharging.jpg
│   ├── logo.jpg
│   └── location.json
├── lib/
│   ├── main.dart
│   ├── login.dart
│   ├── register.dart
│   ├── Homepage.dart
│   ├── batterylevel.dart
│   ├── map.dart
│   └── firebase_options.dart
├── android/
│   ├── app/
│   │   ├── build.gradle
│   │   └── AndroidManifest.xml
│   └── gradle/
└── ios/
    ├── Runner.xcodeproj
    ├── Runner.xcworkspace
    └── Info.plist
```

---

## 🔧 Technical Stack

| Feature              | Technology Used                |
|----------------------|--------------------------------|
| Cross-Platform Dev   | Flutter                        |
| Navigation           | Google Maps API                |
| Backend/Auth         | Firebase (Auth, Firestore, RTDB)|
| Real-Time Monitoring | Custom battery API integration |
| State Management     | Flutter (setState / Provider)  |

---

## 🔥 Firebase Integration

- **Authentication** – Secure email/password-based login & registration.
- **Realtime Database** – Sync and update charging station data.
- **Cloud Firestore** – Store user preferences and saved locations.
- **Platform Config** – `firebase_options.dart` auto-generated for platform-specific setup.

---

## 🚀 Core Dart Files

| File Name            | Purpose |
|----------------------|---------|
| `main.dart`          | App entry point, Firebase initialization. |
| `login.dart`         | Firebase Auth login logic. |
| `register.dart`      | New user registration using Firebase. |
| `Homepage.dart`      | Displays battery status and nearby stations. |
| `batterylevel.dart`  | Battery monitoring with alerts. |
| `map.dart`           | Google Maps UI and station filtering. |
| `firebase_options.dart` | Firebase configuration. |

---

## 🖼️ Assets

| File Name                | Description |
|--------------------------|-------------|
| `battery_background.jpeg`| Battery dashboard background. |
| `excharging.jpg`         | Sample image of a charging station. |
| `logo.jpg`               | Application logo. |
| `location.json`          | Sample JSON data for charging stations. |

---

## 📲 Platform Support

- **Android**: Configured via `gradle.properties`, `AndroidManifest.xml`.
- **iOS**: Configured using `Info.plist`, `Runner.xcodeproj`, `Runner.xcworkspace`.

---

## 📌 Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/charge-smarter.git
   cd charge-smarter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase**
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).
   - Follow setup using `firebase_options.dart`.

4. **Run the app**
   ```bash
   flutter run
   ```

---

## ✨ Future Improvements

- Push notifications for low battery and nearby charging availability.
- In-app payments for charging sessions.
- Dark mode and accessibility improvements.

---

## 🧑‍💻 Contributors

- [Bhavin Biju](https://github.com/your-username) – Developer
- [Video Demonstration Link](https://youtu.be/ykU6HiN6xMM)

---



