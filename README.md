# 🤖 BuddyAI — Personal Virtual Voice Assistant

<p align="center">
  <img src="assets/images/image-circle.png" alt="BuddyAI Logo" width="140"/>
</p>

<p align="center">
  <strong>An AI-powered personal virtual voice assistant built with Flutter, OpenAI ChatGPT, and DALL·E.</strong>
</p>

<p align="center">
  <a href="#-overview">Overview</a> •
  <a href="#-features">Features</a> •
  <a href="#-architecture">Architecture</a> •
  <a href="#-installation">Installation</a> •
  <a href="#-configuration">Configuration</a> •
  <a href="#-usage">Usage</a> •
  <a href="#-project-structure">Project Structure</a>
</p>

---

## 📌 Overview

**BuddyAI** is a personal virtual voice assistant application developed using **Flutter** and powered by **OpenAI's conversational and image-generation capabilities**.

The application allows users to communicate with an AI assistant naturally through **voice commands**. The user's speech is converted into text, processed using OpenAI's language model, and the resulting response is presented inside the application and can also be spoken aloud using text-to-speech.

BuddyAI also supports **AI image generation**. When the application detects that the user's request is asking for an image, artwork, illustration, or another visual creation, the request is automatically routed to the image-generation API instead of the conversational API.

The application therefore combines three major capabilities:

* 🎤 **Speech-to-Text**
* 🧠 **AI Conversational Assistance**
* 🎨 **AI Image Generation**
* 🔊 **Text-to-Speech**

The goal of BuddyAI is to provide a simple, interactive, and accessible interface for communicating with artificial intelligence without requiring users to type every request manually.

---

## ✨ Key Highlights

| Capability             | Technology                               |
| ---------------------- | ---------------------------------------- |
| 📱 Cross-platform UI   | Flutter                                  |
| 🎤 Voice Recognition   | `speech_to_text`                         |
| 🧠 AI Conversations    | OpenAI Chat Completions API              |
| 🎨 AI Image Generation | OpenAI Images API / DALL·E               |
| 🔊 Voice Responses     | Flutter TTS                              |
| 🌐 API Communication   | Dart HTTP                                |
| 🎬 UI Animations       | Animate Do                               |
| 🎨 UI Design           | Flutter Material 3                       |
| 🖼️ Local Assets       | Flutter Assets                           |
| 💻 Supported Platforms | Android, iOS, Web, Linux, macOS, Windows |

The application's dependency configuration includes `speech_to_text`, `http`, `cloud_text_to_speech`, `flutter_tts`, and `animate_do`, along with Flutter's Material and Cupertino components.

---

# 🎯 Project Objectives

BuddyAI was designed with the following objectives:

1. Build an easy-to-use personal AI assistant.
2. Provide a voice-first interaction experience.
3. Convert spoken commands into text automatically.
4. Process natural-language requests using an AI language model.
5. Generate intelligent conversational responses.
6. Identify requests that require image generation.
7. Generate AI-created images from natural-language prompts.
8. Read AI responses aloud using text-to-speech.
9. Provide a clean and modern mobile-friendly interface.
10. Demonstrate the integration of AI APIs into a Flutter application.

---

# 🚀 Features

## 🎤 1. Voice Input

BuddyAI provides voice-based interaction through the device microphone.

The application uses the `speech_to_text` Flutter package to recognize the user's speech and convert it into text.

The voice-recognition workflow is:

```text
User speaks
     ↓
Microphone
     ↓
Speech Recognition
     ↓
Recognized Text
     ↓
AI Processing
```

The application initializes speech recognition when the home screen starts and maintains the recognized speech in application state.

---

## 🧠 2. AI Conversational Assistant

Normal questions and conversational requests are sent to OpenAI's Chat Completions API.

BuddyAI maintains a message history in memory so that subsequent requests can be sent along with previous conversation messages.

Conceptually:

```text
User Question
     ↓
BuddyAI
     ↓
OpenAI Chat API
     ↓
AI Response
     ↓
Display Response
     ↓
Text-to-Speech
```

The implementation maintains a `messages` list containing user and assistant messages, allowing the conversation context to be preserved during the current application session.

---

## 🎨 3. AI Image Generation

BuddyAI can also generate images from natural-language requests.

For example, a user can ask:

```text
Create an image of a futuristic city at sunset.
```

Before sending the request directly to the conversational model, BuddyAI asks the AI whether the request appears to require image generation.

The process is:

```text
User Voice
    ↓
Speech-to-Text
    ↓
Intent Detection
    ↓
 ┌───────────────┐
 │ Image Request?│
 └───────┬───────┘
      Yes│       │No
         ↓       ↓
      DALL·E   ChatGPT
         ↓       ↓
     Image URL  Text Response
         ↓       ↓
      Display    Display
```

The source code uses an OpenAI chat request to classify whether the user's prompt is requesting an image. If the result is `yes`, the application calls the image-generation endpoint; otherwise, it sends the request to the conversational endpoint.

---

## 🔊 4. Text-to-Speech

After receiving a normal AI response, BuddyAI uses `flutter_tts` to convert the generated text into spoken audio.

This allows users to hear responses rather than reading them.

```text
AI Response
     ↓
Flutter TTS
     ↓
Spoken Response
```

The application initializes the TTS service when the home screen is created and invokes speech synthesis after receiving a conversational response.

---

## 🎙️ 5. Interactive Voice Button

The main screen includes a floating microphone button.

Its behavior changes depending on the current speech-recognition state:

### When BuddyAI is idle

The microphone button starts listening.

### While BuddyAI is listening

The button changes to a stop icon and submitting the interaction triggers AI processing.

### After processing

BuddyAI displays the response or generated image and, for text responses, speaks the answer aloud.

This creates a simple push-to-interact voice workflow.

---

## 💬 6. Conversational Response Display

AI responses are displayed directly inside the BuddyAI interface.

The initial screen presents a welcome message:

```text
Welcome to BuddyAi!. How can I help you?
```

Once an AI response is generated, the response replaces the initial greeting.

---

## 🖼️ 7. Generated Image Display

When an image-generation request succeeds, BuddyAI receives an image URL and displays the resulting image directly inside the application.

The generated image is presented using Flutter's network image capabilities with rounded corners for a cleaner interface.

---

## 🎬 8. Animated User Interface

BuddyAI uses the `animate_do` package to add entrance and transition animations.

Examples include:

* `BounceInDown`
* `ZoomIn`
* `FadeInRight`
* `SlideInLeft`

These animations are used throughout the home screen for the title, assistant area, responses, feature cards, and microphone button.

---

# 🏠 User Interface

The main BuddyAI screen contains several sections.

### Header

The application displays:

```text
☰        BuddyAi
```

with the application title centered in the app bar.

### Assistant Avatar

A circular assistant image is displayed below the header.

### AI Response Area

The assistant response appears inside a rounded message container.

### Feature Cards

When no response or generated image is currently displayed, BuddyAI presents three introductory feature cards:

* **ChatGPT**
* **DALL-E**
* **Smart Voice Assistant**

### Voice Control

A floating action button at the bottom allows the user to start and stop voice interaction.

The UI structure and feature cards are implemented in `home_page.dart` and `features.dart`.

---

# 🧩 Technology Stack

## Frontend

### Flutter

BuddyAI is developed using Flutter, Google's cross-platform UI framework.

Flutter allows the same project to target multiple platforms, and the repository contains platform-specific folders for:

```text
android/
ios/
linux/
macos/
web/
windows/
```

The repository also contains the standard Flutter `lib`, `assets`, and `test` directories.

---

## Programming Language

### Dart

The application logic and UI are written in Dart.

---

## Artificial Intelligence

### OpenAI Chat Completions

Used for:

* Conversational responses
* Natural-language understanding
* Image-request classification

### OpenAI Image Generation

Used for:

* AI-generated images
* Artwork
* Illustrations
* Creative visual requests

The current implementation calls OpenAI endpoints from the Flutter application through HTTP requests.

---

## Speech Recognition

### `speech_to_text`

Used to convert the user's spoken words into text.

---

## Text-to-Speech

### `flutter_tts`

Used to convert AI-generated text responses into spoken output.

---

## HTTP Communication

### `http`

Used to communicate with the OpenAI APIs.

---

## UI Animation

### `animate_do`

Used for visual entrance and transition animations.

---

# 🏗️ Architecture

BuddyAI follows a lightweight Flutter architecture centered around the main home screen and an OpenAI service layer.

```text
                    ┌─────────────────────┐
                    │       User          │
                    └──────────┬──────────┘
                               │
                         Voice Command
                               │
                               ▼
                    ┌─────────────────────┐
                    │ Speech-to-Text      │
                    │ speech_to_text      │
                    └──────────┬──────────┘
                               │
                         Recognized Text
                               │
                               ▼
                    ┌─────────────────────┐
                    │   OpenAI Service    │
                    │ openai_service.dart │
                    └──────────┬──────────┘
                               │
                    Intent Classification
                               │
                 ┌─────────────┴─────────────┐
                 │                           │
                 ▼                           ▼
        ┌────────────────┐          ┌────────────────┐
        │   ChatGPT      │          │     DALL·E     │
        │ Conversational │          │ Image Creation │
        └───────┬────────┘          └───────┬────────┘
                │                           │
                ▼                           ▼
        Text Response                 Image URL
                │                           │
                ▼                           ▼
        ┌──────────────┐            ┌───────────────┐
        │ Flutter TTS  │            │ Image Display │
        └──────┬───────┘            └───────────────┘
               │
               ▼
          Spoken Answer
```

---

# 🔄 Application Workflow

The complete application workflow can be summarized as follows:

### Step 1 — Launch Application

Flutter initializes the application and loads `HomePage`.

### Step 2 — Initialize Services

The application initializes:

* Speech recognition
* Text-to-speech

### Step 3 — User Starts Speaking

The user presses the microphone button.

### Step 4 — Speech Recognition

The application listens to the microphone and updates the recognized text.

### Step 5 — User Stops Speaking

The recognized text is submitted for processing.

### Step 6 — AI Intent Detection

The OpenAI service determines whether the request is:

* A normal conversational request
* An image-generation request

### Step 7A — Conversational Request

The prompt is sent to ChatGPT.

The resulting response is:

1. Displayed on screen.
2. Added to the conversation history.
3. Spoken using TTS.

### Step 7B — Image Request

The prompt is sent to the image-generation API.

The returned image URL is then displayed inside the application.

---

# 📁 Project Structure

The repository follows a standard Flutter project structure:

```text
BuddyAI-Personal-Virtual-Voice-Assistant-App/
│
├── .vscode/
│
├── android/
│   └── Android-specific project files
│
├── assets/
│   ├── images/
│   └── sounds/
│
├── ios/
│   └── iOS-specific project files
│
├── lib/
│   ├── main.dart
│   ├── home_page.dart
│   ├── color.dart
│   ├── features.dart
│   ├── openai_service.dart
│   └── secrets.dart
│
├── linux/
│
├── macos/
│
├── test/
│
├── web/
│
├── windows/
│
├── .gitignore
├── .metadata
├── analysis_options.yaml
├── pubspec.yaml
├── pubspec.lock
└── README.md
```

The current repository contains the Flutter platform directories and application files listed above.

---

# 📄 Important Source Files

## `lib/main.dart`

The application's entry point.

It initializes `MyApp` and configures the Flutter `MaterialApp`.

The application uses Material 3 and sets `HomePage` as its initial screen.

---

## `lib/home_page.dart`

This is the primary application screen.

It handles:

* Speech recognition
* TTS
* User interaction
* AI requests
* Response rendering
* Generated-image rendering
* Microphone interaction
* UI animations

The home page is implemented as a `StatefulWidget` because the interface changes dynamically according to speech and AI-response state.

---

## `lib/openai_service.dart`

This file contains the application's OpenAI integration.

It provides three major operations:

```text
isArtPromoptAPI()
ChatGPTAPI()
dallEAPI()
```

### `isArtPromoptAPI()`

Determines whether the user's request should be treated as an image-generation request.

### `ChatGPTAPI()`

Sends conversational requests to OpenAI's chat-completions endpoint.

### `dallEAPI()`

Sends image-generation requests to OpenAI's image-generation endpoint.

The service also maintains the conversation message list.

---

## `lib/features.dart`

Contains the reusable `FeatureBox` widget used for displaying the introductory feature cards on the home screen.

---

## `lib/color.dart`

Contains centralized color definitions used throughout the application.

The project defines colors for:

* Main font
* Suggestion cards
* Assistant circle
* Borders
* Black
* White

Centralizing these values makes the visual design easier to maintain.

---

# 📦 Dependencies

The project currently uses the following Flutter packages:

```yaml
speech_to_text: ^6.6.2
cupertino_icons: ^1.0.6
http: ^1.2.2
cloud_text_to_speech: ^1.1.3
flutter_tts: ^4.0.2
animate_do: ^3.3.4
```

Development dependencies include:

```yaml
flutter_test
flutter_lints
```

The project requires Dart SDK:

```text
>=3.3.1 <4.0.0
```

and currently uses Flutter's Material 3 configuration.

---

# 🛠️ Installation

## Prerequisites

Before running BuddyAI, install:

* Flutter SDK
* Dart SDK
* Android Studio or another Flutter-compatible IDE
* Android SDK for Android development
* Xcode for iOS/macOS development on macOS
* An OpenAI API key

You can verify your Flutter installation with:

```bash
flutter doctor
```

---

# 📥 Clone the Repository

Clone the project using Git:

```bash
git clone https://github.com/Nafees369/BuddyAI-Personal-Virtual-Voice-Assistant-App.git
```

Navigate to the project:

```bash
cd BuddyAI-Personal-Virtual-Voice-Assistant-App
```

---

# 📦 Install Flutter Dependencies

Run:

```bash
flutter pub get
```

This downloads the packages specified in `pubspec.yaml`.

---

# 🔑 Configuration

BuddyAI communicates with OpenAI using an API key.

The current source imports the key from:

```text
lib/secrets.dart
```

The OpenAI service uses that key when constructing the authorization header:

```text
Authorization: Bearer <OPENAI_API_KEY>
```

The API key should **never be committed to a public GitHub repository**.

Create your local secrets file:

```text
lib/secrets.dart
```

and define your key according to the application's expected variable:

```dart
const String openAIAPIkey = 'YOUR_OPENAI_API_KEY';
```

### ⚠️ Security Warning

Do not replace `YOUR_OPENAI_API_KEY` with an actual key inside code that will be pushed to GitHub.

A leaked API key can be abused by other users and may result in unexpected API usage and charges.

For production applications, use a secure backend instead of exposing the OpenAI API key directly inside a Flutter client.

---

# ▶️ Run the Application

After configuring the API key, run:

```bash
flutter run
```

To see available devices:

```bash
flutter devices
```

Then specify a device if necessary:

```bash
flutter run -d <device-id>
```

---

# 📱 Android

To run BuddyAI on Android:

```bash
flutter run
```

Make sure:

* An Android emulator is running, or
* An Android device is connected with USB debugging enabled.

Because BuddyAI uses microphone-based speech recognition, the application may require microphone permission.

---

# 🍎 iOS

On macOS, configure the iOS project and run:

```bash
flutter run
```

Microphone and speech-recognition permissions must be configured appropriately for iOS deployment.

---

# 🌐 Web

Flutter also provides a Web target in the repository.

Run:

```bash
flutter run -d chrome
```

Web support for speech recognition, text-to-speech, and API behavior can depend on the browser and platform.

---

# 💻 Desktop

The repository also includes:

```text
linux/
macos/
windows/
```

Flutter desktop support can therefore be used to build and run the project on supported desktop environments.

---

# 🎮 How to Use BuddyAI

## Basic Voice Conversation

1. Launch BuddyAI.
2. Press the microphone button.
3. Speak naturally.
4. Wait for speech recognition to capture your request.
5. Press the microphone/stop control to submit.
6. BuddyAI sends the request to OpenAI.
7. The response appears on screen.
8. The response is spoken aloud.

Example:

```text
User:
What is artificial intelligence?

BuddyAI:
Artificial intelligence is a field of computer science...
```

---

# 🎨 Generating an Image

You can also request an image.

Example:

```text
Generate an image of a futuristic smart city at night.
```

BuddyAI determines that the request is related to image generation and routes it to the image-generation service.

The generated image is then displayed in the application.

---

# 🧠 Conversation Context

BuddyAI stores messages in an in-memory list during the application's current session.

The basic structure is:

```text
User message
      ↓
messages[]
      ↓
OpenAI
      ↓
Assistant response
      ↓
messages[]
```

This allows subsequent requests to include previous conversation messages.

However, the current implementation does **not** provide persistent conversation storage. Restarting the application clears the in-memory conversation history.

---

# 🎨 UI Design

BuddyAI uses a clean, lightweight interface based on Flutter Material 3.

The application defines a custom color palette including:

```text
Main Font Color
Suggestion Box Colors
Assistant Circle Color
Border Color
Black
White
```

These colors are centralized in `color.dart`.

The interface also uses animated components to make interactions feel more dynamic.

---

# 🔐 Security Considerations

Because BuddyAI communicates with an external AI service, API credentials must be protected.

### Recommended Practices

Do:

* Keep API keys outside source control.
* Add secrets files to `.gitignore`.
* Use environment-specific configuration.
* Use a backend proxy for production applications.
* Monitor API usage.
* Rotate compromised API keys immediately.

Do not:

```text
Hard-code production API keys
        ↓
Push them to GitHub
        ↓
Expose them publicly
```

For a production deployment, the recommended architecture is:

```text
Flutter App
     ↓
Secure Backend
     ↓
OpenAI API
```

rather than:

```text
Flutter App
     ↓
OpenAI API
```

with the secret key embedded in the client.

---

# 🔮 Future Enhancements

BuddyAI can be extended into a much more capable personal AI assistant.

## 🧠 Advanced AI

Potential improvements include:

* GPT-based modern models
* Streaming responses
* Function calling
* AI agents
* Tool integration
* Retrieval-Augmented Generation (RAG)
* Context-aware conversations
* Personalized AI memory

---

## 🎤 Advanced Voice Features

Future versions could include:

* Wake-word detection
* Continuous conversation
* Voice activity detection
* Multiple languages
* Multiple accents
* Voice selection
* Adjustable speaking speed
* Improved speech recognition
* Real-time voice interaction

---

## 💾 Persistent Memory

A database could be added to store:

```text
User Profile
     ↓
Preferences
     ↓
Conversation History
     ↓
Important Memories
     ↓
Personalized AI Responses
```

Possible storage technologies include:

* SQLite
* Firebase
* Supabase
* PostgreSQL

---

## 🔐 Authentication

Possible authentication features:

* Email/password
* Google Sign-In
* Apple Sign-In
* Firebase Authentication

---

## 🛠️ AI Tool Integration

BuddyAI could eventually perform real-world actions such as:

* Weather lookup
* Web search
* Calendar management
* Reminder creation
* Email assistance
* Note taking
* Task management
* File search
* Smart-home control

This would transform BuddyAI from a conversational assistant into a more capable AI agent.

---

# 🧪 Testing

Flutter's testing framework is included in the project.

Run:

```bash
flutter test
```

Static analysis can be performed using:

```bash
flutter analyze
```

For a complete validation workflow:

```bash
flutter clean
flutter pub get
flutter analyze
flutter test
flutter run
```

---

# 🧹 Code Quality

Before submitting changes, it is recommended to run:

```bash
dart format .
```

followed by:

```bash
flutter analyze
```

This helps maintain consistent formatting and identify potential issues.

---

# 🤝 Contributing

Contributions are welcome.

To contribute:

### 1. Fork the repository

Create your own fork of the project.

### 2. Clone your fork

```bash
git clone https://github.com/YOUR_USERNAME/BuddyAI-Personal-Virtual-Voice-Assistant-App.git
```

### 3. Create a feature branch

```bash
git checkout -b feature/your-feature
```

### 4. Make your changes

Implement your feature or bug fix.

### 5. Test the application

```bash
flutter analyze
flutter test
flutter run
```

### 6. Commit your changes

```bash
git add .
git commit -m "Add: your feature description"
```

### 7. Push your branch

```bash
git push origin feature/your-feature
```

### 8. Open a Pull Request

Create a pull request describing:

* What was changed
* Why it was changed
* How it was tested
* Any limitations or known issues

---

# 👨‍💻 Author

**Nafees Ahmad**

Software Engineering Student | Flutter Developer | AI/ML Developer

GitHub:

**Nafees369**

---

# 🌟 Project Purpose

BuddyAI was developed as a practical demonstration of integrating modern AI capabilities into a cross-platform Flutter application.

The project demonstrates how multiple technologies can be combined:

```text
Flutter
   +
Dart
   +
Speech Recognition
   +
OpenAI
   +
AI Image Generation
   +
Text-to-Speech
   +
Animated UI
   =
BuddyAI
```

It provides an excellent foundation for experimenting with:

* AI-powered mobile applications
* Voice interfaces
* Natural-language processing
* Generative AI
* AI image generation
* Human-computer interaction
* Cross-platform application development

---

# 📊 Feature Summary

| Feature                  | Status |
| ------------------------ | :----: |
| Flutter application      |    ✅   |
| Cross-platform structure |    ✅   |
| Speech-to-text           |    ✅   |
| Voice interaction        |    ✅   |
| ChatGPT integration      |    ✅   |
| AI image generation      |    ✅   |
| Text-to-speech           |    ✅   |
| Conversation context     |    ✅   |
| Animated interface       |    ✅   |
| Custom UI theme          |    ✅   |
| Persistent memory        |   🔮   |
| User authentication      |   🔮   |
| Conversation database    |   🔮   |
| Wake-word activation     |   🔮   |
| Streaming responses      |   🔮   |
| AI tool calling          |   🔮   |
| Personalized memory      |   🔮   |
| Secure backend           |   🔮   |

---

# 📚 Learning Outcomes

Working on BuddyAI provides practical experience with:

### Flutter

* Stateful widgets
* Stateless widgets
* Material 3
* Layout design
* Asset management
* Platform-specific Flutter projects
* UI animations

### Dart

* Asynchronous programming
* Futures
* Classes and objects
* Lists and maps
* HTTP requests
* JSON parsing
* State management

### Artificial Intelligence

* Large Language Models
* Conversational AI
* Prompt-based interaction
* AI image generation
* Intent classification
* Generative AI APIs

### Voice Technology

* Speech recognition
* Speech-to-text
* Text-to-speech
* Voice-driven application interaction

### API Integration

* REST API communication
* HTTP POST requests
* JSON encoding/decoding
* Authorization headers
* API response handling

---

# 🏁 Quick Start

For experienced Flutter developers, the complete setup can be summarized as:

```bash
git clone https://github.com/Nafees369/BuddyAI-Personal-Virtual-Voice-Assistant-App.git

cd BuddyAI-Personal-Virtual-Voice-Assistant-App

flutter pub get

flutter run
```

Before running the application, configure the required OpenAI API key securely.

---

# 💡 Example Commands

BuddyAI can be used for conversational requests such as:

```text
What is machine learning?
```

```text
Explain object-oriented programming.
```

```text
Write a short poem about technology.
```

```text
What is the difference between AI and machine learning?
```

For visual generation:

```text
Generate an image of a futuristic robot assistant.
```

```text
Create a digital painting of a mountain landscape.
```

```text
Generate a cyberpunk city at night.
```

---

# 🔗 Repository

The complete source code is available on GitHub.

https://github.com/Nafees369/BuddyAI-Personal-Virtual-Voice-Assistant-App

---

# ⭐ Support the Project

If you find BuddyAI useful or interesting:

* ⭐ Star the repository
* 🍴 Fork the project
* 🐛 Report bugs
* 💡 Suggest new features
* 🔧 Submit pull requests
* 📢 Share the project with other developers

---

<p align="center">
  <strong>Built with Flutter 💙 and powered by AI 🤖</strong>
</p>

<p align="center">
  <em>BuddyAI — Your Personal Virtual Voice Assistant</em>
</p>
