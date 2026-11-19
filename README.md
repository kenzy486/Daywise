# DayWise

A calm, private everyday well-being journal for students and young workers (18–30) in Egypt.

## Tagline
"Small habits. Your patterns. Better days."

## Features
Built from the DayWise Figma design (mobile app, desktop dashboard and website).

- **Website** (wide screens, signed out): hero, how it works, demo preview, suggestions, privacy and FAQ
- **Welcome / sign up**, sign in and password reset (Firebase Auth)
- **Choose your goals** onboarding (sleep, stress, energy, activity, nutrition) + nickname
- **Today**: well-being score (mood, energy, stress), 7/30-day mood/energy/stress trends,
  sleep & activity bars, "one small thing" suggestion, pattern preview
- **Desktop dashboard** with sidebar, recent reflections table and account & data controls
- **Daily check-in**: sleep hours/quality, mood, energy, stress, water, activity, meals, breaks,
  screen time, caffeine, phone-away-before-bed and an optional note (one entry per day, editable)
- **Personal insights** after 7+ check-ins: "your best days look like…", habit comparisons with
  confidence labels (patterns, not proof)
- **For you**: three daily suggestions based on your goals — done / skip / undo and helpful feedback
- **Support**: university counselling, official Egyptian resources and urgent-help guidance
- **Explore Nour's demo** without an account (illustrative data, kept in memory only)
- Bilingual: English and Egyptian Arabic with a fully mirrored RTL layout and Arabic numerals
- Private by default: export your entries or delete all your data
- No gamification, no streaks, no guilt

On the web, `?demo=1` opens the demo directly and `?lang=ar` / `?lang=en` picks the language.

## Design System
- **Mood**: Warm editorial, calm, spacious, hand-made feeling
- **Colors**: Paper (#F8F7F1), forest green (#246653), ink (#193E36), sage (#E6EEE1), mint (#D6E9D9), sand (#F0EBDD)
- **Typography**: Lora (English headings), Inter (English UI), IBM Plex Sans Arabic (Arabic)
- **Icons**: Lucide (`lucide_icons_flutter`), matching the Figma file
- **Shapes**: Cards radius 20px, buttons pill-shaped, 44px+ touch targets

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
├── main.dart          # App entry + routing (website / welcome / onboarding / app)
├── screens/           # Landing, auth, goals, app shell, Today, check-in, insights, for you, support
├── widgets/           # dw.dart (design-system components) and charts.dart
├── theme/             # Design tokens (colors, typography)
├── models/            # CheckIn model
├── services/          # AppState, Firebase services, insights, suggestions, demo data
├── utils/             # Locale-aware number/date formatting
└── l10n/              # English + Arabic strings (ARB) and generated localizations
assets/images/         # Illustrations from the Figma file
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
