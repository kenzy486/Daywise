# DayWise

A calm, private everyday well-being journal for students and young workers (18–30) in Egypt.

## Tagline
"Small habits. Your patterns. Better days."

## Features
- Daily check-in tracking (sleep, mood, energy, stress, activity, nutrition)
- Personal insights and pattern recognition
- Personalized daily suggestions
- Bilingual: English and Egyptian Arabic (fully RTL)
- Demo mode for exploration
- Private by default with export/delete options
- No gamification, no streaks, no guilt

## Design System
- **Mood**: Warm editorial, calm, spacious, hand-made feeling
- **Colors**: Cream paper (#F8F6F0), deep forest green (#23634F), soft sage tints
- **Typography**: Newsreader/Lora (English serif), Inter (English body), IBM Plex Sans Arabic (Arabic body), Noto Naskh Arabic (Arabic serif)
- **Shapes**: Cards radius 24px, buttons pill-shaped

## Getting Started

### Prerequisites
- Flutter SDK (>= 3.12.2)
- Firebase project configured
- Android Studio / VS Code

### Installation

1. Clone the repository
2. Install dependencies:
```bash
flutter pub get
```

3. Generate localization files:
```bash
flutter gen-l10n
```

4. Configure Firebase:
   - Add `google-services.json` to `android/app/`
   - Add `GoogleService-Info.plist` to `ios/Runner/`
   - Add `firebase_options.dart` to `lib/`

5. Run the app:
```bash
# Chrome (web)
flutter run -d chrome

# Android emulator
flutter run -d android

# iOS simulator
flutter run -d ios
```

## Project Structure
```
lib/
├── layout/           # Responsive shell and main screens
├── screens/          # Auth screens
├── screens/auth/     # Auth components
├── screens/checkin/  # Check-in screen
├── widgets/          # Reusable UI components
├── theme/            # Design tokens and theme
├── models/           # Data models
├── services/         # Business logic (Firebase, etc.)
├── l10n/             # Localization files
├── debug/            # Demo data generator
└── data/             # Static data
```

## Firebase Configuration

### Firestore Rules
The app uses Firestore rules to ensure:
- Users can only read/write their own data
- Check-in data is validated for type and range
- Profile and suggestions collections are protected

See `firestore.rules` for details.

## Development

### Run tests
```bash
flutter test
```

### Analyze code
```bash
flutter analyze
```

### Format code
```bash
dart format .
```

## Localization

The app supports English and Egyptian Arabic. To add new strings:
1. Add the key to `lib/l10n/app_en.arb`
2. Add the translation to `lib/l10n/app_ar.arb`
3. Run `flutter gen-l10n`

## Medical Disclaimer
DayWise supports healthy habits; it does not give medical advice. It is not a diagnosis tool or a replacement for professional healthcare.

## License
This project is designed to support SDG 3: Good Health and Well-being. An independent project with no United Nations affiliation or endorsement.
