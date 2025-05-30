# 🌟 SiteGleam

**A powerful, responsive Flutter application for comprehensive website performance analysis**

SiteGleam is a modern mobile application that provides detailed website performance insights using Google's PageSpeed Insights API. Built with Flutter, it offers a beautiful, responsive interface that works seamlessly across all device sizes.

## ✨ Features

### 🚀 Core Functionality
- **Website Performance Analysis**: Get comprehensive performance metrics for any website
- **Real-time Scoring**: View performance scores with detailed breakdowns
- **Multiple Metrics**: Analyze First Contentful Paint, Largest Contentful Paint, Speed Index, and more
- **Historical Data**: Track performance over time with timestamps

### 📱 User Experience
- **Responsive Design**: Optimized layouts for mobile, tablet, and desktop
- **Material 3 Design**: Modern UI following Google's latest design principles
- **Dark/Light Theme**: Automatic theme switching based on system preferences
- **Smooth Animations**: Engaging transitions and loading states
- **Error Handling**: Comprehensive error messages and network status checks

### 🛡️ Security & Performance
- **Environment Variables**: Secure API key management
- **Network Optimization**: Intelligent timeout and retry mechanisms
- **Memory Management**: Proper resource disposal and lifecycle management
- **Null Safety**: Full Dart null safety implementation

## 📱 Screenshots

*Coming soon - Screenshots will be added after the app is fully tested*

## 🛠️ Technology Stack

- **Framework**: Flutter 3.7.2+
- **Language**: Dart
- **API**: Google PageSpeed Insights API v5
- **State Management**: StatefulWidget with proper lifecycle management
- **Charts**: FL Chart for performance visualizations
- **HTTP Client**: Dart HTTP package
- **Environment**: flutter_dotenv for configuration

## 📦 Dependencies

```yaml
dependencies:
  flutter: ^3.7.2
  http: ^1.4.0              # HTTP requests
  fl_chart: ^1.0.0          # Performance charts
  intl: ^0.20.2             # Date formatting
  shared_preferences: ^2.5.3 # Local storage
  url_launcher: ^6.3.1      # External links
  lottie: ^3.3.1            # Animations
  flutter_dotenv: ^5.2.1    # Environment variables
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.7.2 or higher
- Dart SDK 3.0.0 or higher
- Google PageSpeed Insights API key

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/hasnainmakada-99/sitegleam.git
   cd sitegleam
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up environment variables**
   ```bash
   cp .env.example .env
   ```
   
   Edit `.env` and add your Google PageSpeed Insights API key:
   ```env
   PAGESPEED_API_KEY=your_api_key_here
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

### Getting a PageSpeed Insights API Key

1. Go to the [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the PageSpeed Insights API
4. Create credentials (API Key)
5. Copy the API key to your `.env` file

## 🏗️ Project Structure

```
lib/
├── config/
│   └── theme.dart              # App theme and responsive utilities
├── models/
│   └── performance_result.dart # Data models for API responses
├── screens/
│   ├── home_screen.dart        # Main input screen
│   └── results_screen.dart     # Results display screen
├── services/
│   └── pagespeed_service.dart  # API service layer
├── widgets/
│   ├── url_input_field.dart    # Custom URL input widget
│   └── performance_card.dart   # Performance metric cards
└── main.dart                   # App entry point
```

## 🎨 Design System

### Responsive Breakpoints
- **Mobile**: < 600px width
- **Tablet**: 600px - 1024px width  
- **Desktop**: > 1024px width

### Theme Features
- Material 3 design system
- Responsive typography scaling
- Adaptive layouts for different screen sizes
- Consistent spacing and padding
- Color scheme with proper contrast ratios

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the root directory:

```env
# Google PageSpeed Insights API Key
PAGESPEED_API_KEY=your_api_key_here

# Optional: API timeout in seconds (default: 30)
API_TIMEOUT=30

# Optional: Enable debug mode (default: false)
DEBUG_MODE=false
```

### Build Configuration

For production builds, ensure you:

1. Remove debug flags
2. Optimize assets
3. Enable code obfuscation
4. Set proper app signing

```bash
# Android Release Build
flutter build apk --release --obfuscate --split-debug-info=build/debug-info

# iOS Release Build  
flutter build ios --release --obfuscate --split-debug-info=build/debug-info
```

## 🧪 Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter drive --target=test_driver/app.dart
```

### Test Structure

```
test/
├── unit/
│   ├── models/
│   ├── services/
│   └── widgets/
├── widget/
│   └── widget_test.dart
└── integration/
    └── app_test.dart
```

## 🚀 Deployment

### Android

1. **Configure signing**
   ```bash
   keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

2. **Build release APK**
   ```bash
   flutter build apk --release
   ```

3. **Build App Bundle**
   ```bash
   flutter build appbundle --release
   ```

### iOS

1. **Configure Xcode project**
2. **Set up provisioning profiles**
3. **Build for release**
   ```bash
   flutter build ios --release
   ```

### Web

```bash
flutter build web --release
```

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Make your changes**
4. **Add tests for new functionality**
5. **Ensure all tests pass**
   ```bash
   flutter test
   ```
6. **Commit your changes**
   ```bash
   git commit -m 'Add amazing feature'
   ```
7. **Push to your branch**
   ```bash
   git push origin feature/amazing-feature
   ```
8. **Open a Pull Request**

### Code Style

- Follow [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add documentation for public APIs
- Maintain consistent formatting with `dart format`

## 🐛 Known Issues

- [ ] Loading animations could be more engaging
- [ ] Share functionality not yet implemented
- [ ] Offline mode not available
- [ ] Limited error recovery options

## 🗺️ Roadmap

### Version 1.1.0
- [ ] Offline caching of results
- [ ] Export results to PDF
- [ ] Comparison between multiple websites
- [ ] Historical performance tracking

### Version 1.2.0
- [ ] User accounts and cloud sync
- [ ] Custom performance budgets
- [ ] Automated monitoring alerts
- [ ] Advanced filtering and search

### Version 2.0.0
- [ ] Multi-language support
- [ ] Advanced analytics dashboard
- [ ] Team collaboration features
- [ ] API for third-party integrations

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Hasnain Makada**
- GitHub: [@hasnainmakada-99](https://github.com/hasnainmakada-99)
- Email: hasnainmakada99@gmail.com

## 🙏 Acknowledgments

- Google PageSpeed Insights API for performance data
- Flutter team for the amazing framework
- Material Design team for design guidelines
- Open source community for inspiration and support

## 📞 Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/hasnainmakada-99/sitegleam/issues) page
2. Create a new issue with detailed information
3. Join our community discussions
4. Contact the maintainer directly

---

**Made with ❤️ using Flutter**
