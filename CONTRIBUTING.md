# Contributing to SiteGleam

Thank you for your interest in contributing to SiteGleam! We welcome contributions from everyone and are grateful for every contribution, no matter how small.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [How to Contribute](#how-to-contribute)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Testing Guidelines](#testing-guidelines)
- [Documentation](#documentation)
- [Community](#community)

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to [hasnainmakada99@gmail.com](mailto:hasnainmakada99@gmail.com).

### Our Standards

- **Be respectful**: Treat everyone with respect and kindness
- **Be inclusive**: Welcome newcomers and help them get started
- **Be collaborative**: Work together and share knowledge
- **Be constructive**: Provide helpful feedback and suggestions
- **Be patient**: Remember that everyone has different skill levels

## Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.7.2 or higher)
- [Dart SDK](https://dart.dev/get-dart) (3.0.0 or higher)
- [Git](https://git-scm.com/)
- A code editor ([VS Code](https://code.visualstudio.com/) with Flutter extension recommended)

### Development Setup

1. **Fork the repository**
   ```bash
   # Click the "Fork" button on GitHub, then clone your fork
   git clone https://github.com/YOUR_USERNAME/sitegleam.git
   cd sitegleam
   ```

2. **Add upstream remote**
   ```bash
   git remote add upstream https://github.com/hasnainmakada-99/sitegleam.git
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Set up environment variables**
   ```bash
   cp .env.example .env
   # Edit .env and add your Google PageSpeed Insights API key
   ```

5. **Verify setup**
   ```bash
   flutter doctor
   flutter test
   ```

## How to Contribute

### Types of Contributions

We welcome various types of contributions:

- **Bug fixes**: Help us identify and fix issues
- **Feature development**: Implement new features from our roadmap
- **Documentation**: Improve our docs, README, or code comments
- **Testing**: Add or improve test coverage
- **Performance**: Optimize app performance
- **UI/UX**: Enhance user interface and experience
- **Accessibility**: Improve app accessibility
- **Translations**: Add support for new languages (future)

### Finding Issues to Work On

- Check our [Issues](https://github.com/hasnainmakada-99/sitegleam/issues) page
- Look for issues labeled `good first issue` for beginners
- Issues labeled `help wanted` are great for contributors
- Feel free to propose new features by creating an issue first

### Before You Start

1. **Check existing issues**: Make sure your contribution isn't already being worked on
2. **Create an issue**: For new features or significant changes, create an issue to discuss first
3. **Assign yourself**: Comment on the issue to let others know you're working on it

## Pull Request Process

### 1. Create a Feature Branch

```bash
# Update your main branch
git checkout main
git pull upstream main

# Create a new feature branch
git checkout -b feature/your-feature-name
```

### 2. Make Your Changes

- Write clean, readable code
- Follow our coding standards
- Add tests for new functionality
- Update documentation as needed
- Ensure your changes don't break existing functionality

### 3. Test Your Changes

```bash
# Run all tests
flutter test

# Run the app and test manually
flutter run

# Check for formatting issues
dart format --set-exit-if-changed .

# Run static analysis
flutter analyze
```

### 4. Commit Your Changes

```bash
# Stage your changes
git add .

# Commit with a descriptive message
git commit -m "feat: add website comparison feature

- Add comparison screen with side-by-side metrics
- Implement data model for comparison results
- Add responsive layout for comparison view
- Include unit tests for comparison logic

Closes #123"
```

#### Commit Message Format

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Types:**
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that don't affect code meaning (formatting, etc.)
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `perf`: Performance improvements
- `test`: Adding missing tests or correcting existing tests
- `chore`: Changes to build process or auxiliary tools

### 5. Push and Create Pull Request

```bash
# Push your branch
git push origin feature/your-feature-name

# Create a pull request on GitHub
```

### 6. Pull Request Guidelines

- **Title**: Use a clear, descriptive title
- **Description**: Explain what changes you made and why
- **Screenshots**: Include screenshots for UI changes
- **Testing**: Describe how you tested your changes
- **Breaking Changes**: Clearly mark any breaking changes

#### Pull Request Template

```markdown
## Description
Brief description of changes made.

## Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

## Testing
- [ ] I have added tests that prove my fix is effective or that my feature works
- [ ] New and existing unit tests pass locally with my changes
- [ ] I have tested this change on multiple screen sizes

## Screenshots (if applicable)
Add screenshots to help explain your changes.

## Checklist
- [ ] My code follows the style guidelines of this project
- [ ] I have performed a self-review of my own code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] Any dependent changes have been merged and published
```

## Coding Standards

### Dart/Flutter Guidelines

1. **Follow Dart style guide**: Use `dart format` to format your code
2. **Use meaningful names**: Variables, functions, and classes should have descriptive names
3. **Keep functions small**: Functions should do one thing well
4. **Add documentation**: Document public APIs and complex logic
5. **Handle errors**: Always handle potential errors gracefully
6. **Use null safety**: Take advantage of Dart's null safety features

### Code Organization

```
lib/
├── config/          # App configuration (theme, constants)
├── models/          # Data models
├── screens/         # UI screens
├── services/        # Business logic and API calls
├── widgets/         # Reusable UI components
└── utils/           # Utility functions
```

### Widget Guidelines

- **Prefer StatelessWidget**: Use StatefulWidget only when necessary
- **Extract widgets**: Break down complex widgets into smaller, reusable components
- **Use const constructors**: When possible, use const constructors for performance
- **Dispose resources**: Always dispose of controllers, streams, and other resources

### Performance Best Practices

- **Avoid rebuilds**: Use `const` widgets and proper state management
- **Optimize images**: Use appropriate image formats and sizes
- **Lazy loading**: Implement lazy loading for large lists
- **Memory management**: Dispose of resources properly

## Testing Guidelines

### Test Structure

```
test/
├── unit/            # Unit tests for models, services, utils
├── widget/          # Widget tests for UI components
└── integration/     # Integration tests for complete flows
```

### Writing Tests

1. **Unit tests**: Test individual functions and classes
2. **Widget tests**: Test UI components in isolation
3. **Integration tests**: Test complete user flows
4. **Test naming**: Use descriptive test names that explain what is being tested

### Test Example

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:sitegleam/models/performance_result.dart';

void main() {
  group('PerformanceResult', () {
    test('should calculate overall score correctly', () {
      // Arrange
      final result = PerformanceResult(
        performanceScore: 90,
        accessibilityScore: 85,
        bestPracticesScore: 80,
        seoScore: 95,
        // ... other required fields
      );

      // Act
      final overallScore = result.overallScore;

      // Assert
      expect(overallScore, equals(87.5));
    });
  });
}
```

## Documentation

### Code Documentation

- **Public APIs**: Document all public methods and classes
- **Complex logic**: Add comments for complex algorithms or business logic
- **TODOs**: Use TODO comments for future improvements

### README Updates

When adding new features:
1. Update the features list
2. Add setup instructions if needed
3. Update screenshots if UI changes
4. Update the roadmap if applicable

## Community

### Getting Help

- **GitHub Issues**: For bug reports and feature requests
- **Discussions**: For questions and general discussion
- **Email**: [hasnainmakada99@gmail.com](mailto:hasnainmakada99@gmail.com) for direct contact

### Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes for significant contributions
- Special thanks in commit messages

## Release Process

1. **Version bumping**: Follow semantic versioning
2. **Changelog**: Update CHANGELOG.md with new features and fixes
3. **Testing**: Ensure all tests pass and manual testing is complete
4. **Documentation**: Update documentation as needed
5. **Release notes**: Create detailed release notes

## Questions?

Don't hesitate to ask questions! We're here to help:

- Open an issue for technical questions
- Email us for general inquiries
- Check existing issues and discussions first

Thank you for contributing to SiteGleam! 🚀