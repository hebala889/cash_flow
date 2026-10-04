# Cash Flow 💰

> **Mobile Accounting & Business Management Platform**

Cash Flow is a Flutter-based mobile application designed to help small-business owners manage customers, suppliers, products, transactions, cash flow, inventory, and business insights from one place.

The project combines a mobile frontend with REST API integration and database-backed business workflows, with AI-assisted features for business analysis.

## 📱 Screenshots

### Dashboard & Financial Overview

![Dashboard](docs/screenshots/dashboard.jpeg)

![Financial Position](docs/screenshots/financial_position.jpeg)

### Customers & Suppliers

![Suppliers](docs/screenshots/suppliers.jpeg)

![Customers](docs/screenshots/customers.jpeg)

### Operations & Transactions

![Operations](docs/screenshots/operations.jpeg)

![Transactions](docs/screenshots/transactions.jpeg)

### AI & Business Intelligence

![Business Insights](docs/screenshots/business_insights.jpeg)

![AI Insights](docs/screenshots/ai_insights.jpeg)

![Shadow CEO](docs/screenshots/shadow_ceo.jpeg)

## ✨ Key Features

- 🔐 User authentication and persistent login state
- 📊 Financial dashboard and business overview
- 👥 Customer and supplier management
- 📦 Product and inventory management
- 💰 Sales and purchase operations
- 💳 Payments and collections
- 🔔 Notifications and business alerts
- 🤖 AI Business Assistant
- 🧠 AI-powered business insights
- 👔 Shadow CEO / CEO Score
- 📈 Financial position and transaction analysis
- ⚙️ Profile and application settings

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Mobile App | Flutter / Dart |
| UI | Flutter Material UI |
| Backend API | PHP REST API |
| Database | MySQL |
| API Communication | HTTP / JSON |
| Local Storage | SharedPreferences |
| AI Features | AI Business Assistant / Insights |

## 🏗️ Architecture

```text
Flutter Mobile App
        │
        │ HTTP / JSON
        ▼
   PHP REST API
        │
        ▼
      MySQL
```

## 📂 Project Structure

```text
lib/
├── main.dart
├── screens/
├── services/
├── widgets/
└── ...

assets/
└── images/

android/
iOS/
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK (included with Flutter)
- Android Studio or VS Code
- Android emulator or physical device
- Accessible PHP REST API + MySQL backend

### Installation

```bash
git clone https://github.com/hebala889/cash_flow.git
cd cash_flow
flutter pub get
flutter run
```

Make sure the backend/API configuration points to a reachable server before testing features that communicate with the backend.

## 🎯 Project Goal

Cash Flow was built to provide small-business owners with a practical mobile tool for managing day-to-day financial and operational activities while turning business data into actionable insights.

## 👨‍💻 Project

**Cash Flow — Mobile Accounting & Business Management Platform**

Developed with Flutter, PHP REST APIs, MySQL, and AI-assisted business features.
