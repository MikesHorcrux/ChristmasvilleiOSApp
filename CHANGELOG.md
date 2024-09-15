## 2024-09-15

### Added
- Introduced `TypingIndicatorView` to display typing animations in chat.
- Added placeholder system messages for pending chat responses.

### Changed
- Improved chat message handling to ensure UI updates occur on the main thread.
- Enhanced `ChatView` to handle pending messages and ensure the latest message is always visible.
- Updated `TextEntryView` to reset the text field after sending a message.

### Fixed
- Removed an unused breakpoint from the debugger configuration.

## 2024-09-12

### Added
- Integrated Firebase Performance for enhanced app monitoring and analytics.
- Automated crash report handling with a new shell script build phase for Firebase Crashlytics.

### Changed
- Updated build settings to improve debugging information.

## 2024-09-11

### Changed
- Updated capsule indicator color and padding in `ChatView` for improved visual consistency and layout spacing.

## 2024-09-05

### Added
- New `SettingsView` for managing subscriptions, accessibility, and debug mode.
- Onboarding flow with `OnboardingView` to guide new users.
- `SubscriptionManager` using RevenueCat for subscription handling.
- New image assets for enhanced visual representation.

### Changed
- Migrated chat functionality to FirebaseVertexAI.
- Enhanced various views with new UI elements and navigation improvements.

### Fixed
- Paywall presentation issues.