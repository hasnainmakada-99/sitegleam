# Development Guide

This document provides detailed information for developers working on SiteGleam.

## Project Overview

SiteGleam is a Flutter application that analyzes website performance using Google's PageSpeed Insights API. The app provides comprehensive performance metrics with a responsive, Material 3 design.

## Architecture

### Project Structure

```
lib/
├── config/
│   └── theme.dart              # Centralized theme configuration
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

### Design Patterns

1. **Service Layer Pattern**: API calls are abstracted into service classes
2. **Model-View Pattern**: Clear separation between data models and UI
3. **Widget Composition**: Complex UIs built from smaller, reusable widgets
4. **Responsive Design**: Adaptive layouts based on screen size

## Key Features Implemented

### 🔧 Technical Improvements

1. **API Security**
   - Moved hardcoded API key to environment variables
   - Added fallback mechanism for missing environment variables
   - Secure configuration management

2. **Error Handling**
   - Comprehensive exception handling in API service
   - Network connectivity checks
   - Timeout management (30-second default)
   - User-friendly error messages

3. **Memory Management**
   - Fixed FocusNode memory leaks
   - Proper disposal of controllers and resources
   - Lifecycle-aware widget implementation

4. **Null Safety**
   - Full null safety implementation
   - Safe data extraction from API responses
   - Defensive programming practices

### 🎨 UI/UX Improvements

1. **Responsive Design**
   - Mobile-first approach with tablet/desktop adaptations
   - Breakpoint-based layout system (600px, 1024px)
   - Responsive typography and spacing
   - Adaptive grid layouts

2. **Material 3 Design**
   - Modern color schemes and typography
   - Consistent spacing and elevation
   - Proper contrast ratios for accessibility
   - Dynamic theme switching

3. **Performance Visualization**
   - Fixed empty score displays
   - Real-time metric updates
   - Color-coded performance indicators
   - Detailed metric breakdowns

### 🚀 Performance Optimizations

1. **Network Layer**
   - Optimized HTTP requests
   - Connection timeout handling
   - Retry mechanisms for failed requests
   - Efficient data parsing

2. **UI Performance**
   - Const constructors where possible
   - Efficient widget rebuilds
   - Proper use of StatelessWidget vs StatefulWidget
   - Memory-efficient image handling

## Development Workflow

### Setting Up Development Environment

1. **Prerequisites**
   ```bash
   flutter --version  # Should be 3.7.2+
   dart --version     # Should be 3.0.0+
   ```

2. **Environment Configuration**
   ```bash
   cp .env.example .env
   # Add your Google PageSpeed Insights API key
   ```

3. **Dependencies**
   ```bash
   flutter pub get
   flutter pub deps    # Check dependency tree
   ```

### Code Quality Tools

1. **Formatting**
   ```bash
   dart format .
   dart format --set-exit-if-changed .  # CI check
   ```

2. **Static Analysis**
   ```bash
   flutter analyze
   dart analyze --fatal-infos
   ```

3. **Testing**
   ```bash
   flutter test
   flutter test --coverage
   ```

### Debugging

1. **Flutter Inspector**: Use for widget tree analysis
2. **Performance Overlay**: Enable for performance debugging
3. **Network Debugging**: Monitor API calls and responses
4. **Memory Profiling**: Check for memory leaks

## API Integration

### Google PageSpeed Insights API

The app integrates with Google's PageSpeed Insights API v5:

- **Endpoint**: `https://www.googleapis.com/pagespeedonline/v5/runPagespeed`
- **Parameters**: 
  - `url`: Website URL to analyze
  - `key`: API key for authentication
  - `category`: Performance metrics to analyze
  - `strategy`: Mobile or desktop analysis

### Data Flow

1. User enters URL in home screen
2. URL validation and formatting
3. API request with timeout handling
4. Response parsing and error checking
5. Data model creation
6. Navigation to results screen
7. Responsive UI rendering

## Responsive Design System

### Breakpoints

```dart
// Mobile: < 600px
bool isMobile = MediaQuery.of(context).size.width < 600;

// Tablet: 600px - 1024px  
bool isTablet = width >= 600 && width < 1024;

// Desktop: >= 1024px
bool isDesktop = MediaQuery.of(context).size.width >= 1024;
```

### Layout Adaptations

1. **Mobile**: Single column, compact spacing
2. **Tablet**: Grid layouts, medium spacing
3. **Desktop**: Multi-column, generous spacing

### Typography Scaling

```dart
double getResponsiveFontSize(BuildContext context, double baseSize) {
  final width = MediaQuery.of(context).size.width;
  if (width < 600) return baseSize;
  if (width < 1024) return baseSize * 1.1;
  return baseSize * 1.2;
}
```

## Testing Strategy

### Unit Tests
- Model validation and data parsing
- Service layer API interactions
- Utility function testing

### Widget Tests
- UI component behavior
- User interaction handling
- Responsive layout verification

### Integration Tests
- Complete user flows
- API integration testing
- Cross-platform compatibility

## Performance Considerations

### Memory Management
- Dispose controllers in `dispose()` method
- Use `const` constructors for immutable widgets
- Avoid memory leaks in async operations

### Network Optimization
- Implement request timeouts
- Handle network connectivity changes
- Cache responses when appropriate

### UI Performance
- Minimize widget rebuilds
- Use `RepaintBoundary` for complex widgets
- Optimize image loading and caching

## Security Best Practices

### API Key Management
- Never commit API keys to version control
- Use environment variables for configuration
- Implement key rotation strategies

### Input Validation
- Validate and sanitize user inputs
- Implement proper URL validation
- Handle malicious input gracefully

### Network Security
- Use HTTPS for all API calls
- Implement certificate pinning (future)
- Validate API responses

## Deployment

### Build Configurations

1. **Debug Build**
   ```bash
   flutter run --debug
   ```

2. **Release Build**
   ```bash
   flutter build apk --release
   flutter build ios --release
   flutter build web --release
   ```

### Environment-Specific Builds
- Development: Debug mode, verbose logging
- Staging: Release mode, limited logging
- Production: Release mode, minimal logging

## Monitoring and Analytics

### Error Tracking
- Implement crash reporting (future)
- Monitor API failure rates
- Track user experience metrics

### Performance Monitoring
- Monitor app startup time
- Track API response times
- Measure UI rendering performance

## Future Enhancements

### Planned Features
1. **Offline Support**: Cache results for offline viewing
2. **Data Export**: PDF and JSON export functionality
3. **Historical Tracking**: Store and compare results over time
4. **User Accounts**: Cloud sync and personalization
5. **Advanced Analytics**: Detailed performance insights

### Technical Debt
1. **Testing Coverage**: Increase test coverage to 90%+
2. **Accessibility**: Improve screen reader support
3. **Internationalization**: Add multi-language support
4. **Performance**: Implement advanced caching strategies

## Troubleshooting

### Common Issues

1. **API Key Issues**
   - Verify API key is correctly set in `.env`
   - Check API key permissions in Google Cloud Console
   - Ensure PageSpeed Insights API is enabled

2. **Build Issues**
   - Run `flutter clean && flutter pub get`
   - Check Flutter and Dart versions
   - Verify all dependencies are compatible

3. **Performance Issues**
   - Use Flutter Inspector to identify bottlenecks
   - Check for memory leaks with DevTools
   - Profile app performance on target devices

### Debug Commands

```bash
# Clean build artifacts
flutter clean

# Get fresh dependencies
flutter pub get

# Run with verbose logging
flutter run --verbose

# Build with debug info
flutter build apk --debug

# Analyze performance
flutter run --profile
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed contribution guidelines.

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Guide](https://dart.dev/guides)
- [Material Design 3](https://m3.material.io/)
- [PageSpeed Insights API](https://developers.google.com/speed/docs/insights/v5/get-started)
- [Flutter Performance Best Practices](https://flutter.dev/docs/perf/best-practices)