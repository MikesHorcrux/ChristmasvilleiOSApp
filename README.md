# Christmasville iOS App 🎄

A magical Christmas-themed iOS app that brings the joy of the North Pole to your device! Features include Mrs. Claus's Kitchen recipes, interactive chats with Christmas characters, and festive location-based features.

## Features 🎅

- **Mrs. Claus's Kitchen**: Browse and create festive recipes
- **Chat with Christmas Characters**: Interactive conversations powered by AI
- **Location-based Features**: Discover Christmas magic around you
- **Beautiful UI**: Modern, festive design with attention to detail

## Requirements 📱

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+
- CocoaPods or Swift Package Manager

## Installation 🛠️

1. Clone the repository
```bash
git clone https://github.com/ChristmasvilleiOSApp.git
cd ChristmasvilleiOSApp
```

2. Install dependencies (if using CocoaPods)
```bash
pod install
```

## Configuration ⚙️

### Firebase Setup
1. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com)
2. Add an iOS app to your Firebase project
3. Download the `GoogleService-Info.plist` file
4. Add it to your Xcode project (drag and drop into the project navigator)
   - Make sure not to commit this file to source control

### RevenueCat Setup (for Subscriptions)
1. Create an account at [RevenueCat](https://www.revenuecat.com/)
2. Create a new app in RevenueCat dashboard
3. Get your API key
4. Update `SubscriptionManager.swift` with your API key:
```swift
Purchases.configure(withAPIKey: "your_api_key_here")
```

### Vertex AI Setup
1. Set up a Google Cloud project
2. Enable the Vertex AI API
3. Create service account credentials
4. Configure the credentials in your project

## Development 🛠️

### Test Data Generation
The app includes helper functions to generate test data for development:

1. In `SettingsView.swift`, you'll find functions to generate:
   - Sample Christmas light locations in Austin
   - Test giftee profiles
   - Sample recipes

To use these features, enable debug mode in the Settings view.

## Usage 🎮

1. Open `Christmasville.xcworkspace` in Xcode
2. Select your target device/simulator
3. Build and run (⌘+R)

## Architecture 🏗️

The app follows a modern SwiftUI architecture with:
- MVVM pattern
- Observable framework for state management
- Clean separation of concerns
- Manager classes for specific functionalities

## Contributing 🤝

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments 👏

- Icons from [Icons8](https://icons8.com) and [SF Symbols](https://developer.apple.com/sf-symbols/)
- Design inspiration from Apple's iOS design guidelines and modern Christmas aesthetics
- Special thanks to all contributors

## Support 💬

For support, please open an issue in the GitHub repository or contact support@christmasvilleapp.com

