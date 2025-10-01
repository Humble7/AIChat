# AIChat

**AIChat** is a full-featured chat application built with SwiftUI, designed to demonstrate clean architecture, scalable code, and modern iOS development practices.

The app includes onboarding, authentication, real-time chat, avatar creation with AI, and support for multiple build environments (Mock, Development, Production).

---

## 🚀 Features

### Multi-Environment Setup
- **Mock**, **Development**, and **Production** schemes
- Dependency injection for environment-agnostic code

### Authentication & Onboarding
- Launch screen with sign-in
- Guided onboarding flow with saved user preferences

### A/B Testing
- Configurable experiments (UI variations, feature toggles)
- Developer settings panel to enable/disable tests in Dev/Mock builds

### Chat System
- Real-time messaging with Firebase
- Local persistence using SwiftData
- AI-powered avatars with unique personalities
- Empty state handling, time stamps, and chat management

### Avatar System
- Create and customize avatars
- AI-generated images and personality traits
- Avatars can be used in chats or shared across users

### Reusable UI Components
- Custom modal and alert implementations
- Scalable TabBar navigation (Home, Chats, Profile)
- Theming support (e.g., user-selected colors)

---

## 🛠️ Tech Stack

| Category | Technology |
|----------|------------|
| **Language** | Swift |
| **Framework** | SwiftUI |
| **Architecture** | MVVM + Dependency Injection |
| **Local Storage** | SwiftData |
| **Cloud Storage** | Firebase Realtime Database + Cloud Functions |
| **Other** | A/B Testing framework, reusable modals, alerts, and UI components |

---

## 📦 Project Structure
AIChat/
├── Mock/               # Mock environment configuration
├── Development/        # Development environment configuration
├── Production/         # Production environment configuration
├── Models/             # Data models and entities
├── Views/              # SwiftUI views and screens
├── ViewModels/         # MVVM view models
├── Services/           # Business logic and API services
├── Components/         # Reusable UI components
└── Utils/              # Helper functions and extensions

---

## 🎯 Key Highlights

- **Clean Architecture**: Separation of concerns with MVVM pattern
- **Dependency Injection**: Flexible and testable code structure
- **Multi-Environment Support**: Easy switching between Mock, Dev, and Production
- **Real-Time Capabilities**: Firebase integration for live messaging
- **AI Integration**: Avatar generation with personality traits
- **Modern iOS Development**: Built entirely with SwiftUI and modern Swift practices
