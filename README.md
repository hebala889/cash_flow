# Cash Flow — Mobile Accounting & Business Management Platform

Cash Flow is a Flutter mobile application designed to help small-business owners manage financial activities, customers, suppliers, products, transactions, and business insights from one place.

## Highlights

- Authentication and persistent login state
- Financial dashboard and transaction tracking
- Customer and supplier management
- Product and inventory management
- Sales, purchases, payments, and collections
- Notifications
- AI Business Assistant
- Shadow CEO / business insights
- Profile and application settings
- REST API integration with a PHP backend
- Local state/preferences using SharedPreferences

## Tech Stack

- Flutter / Dart
- Material UI
- PHP REST API
- MySQL backend
- HTTP / JSON API integration
- SharedPreferences
- Google Fonts

## Project Structure

```text
lib/
├── main.dart
├── screens/
├── services/
│   ├── api_service.dart
│   └── assistant_service.dart
└── widgets/
    └── ai_chat_sheet.dart

assets/
└── images/
    └── logo.png
```

## Getting Started

```bash
flutter pub get
flutter run
```

Make sure the configured backend API is reachable before testing features that require server communication.

## Notes

This repository contains the Flutter source project. Generated build artifacts, local IDE files, Gradle caches, and machine-specific configuration files are intentionally excluded from the repository.

## Portfolio

This project was developed as a practical business-management application combining mobile development, REST APIs, database-backed workflows, and AI-assisted business features.
