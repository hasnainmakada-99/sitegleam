import 'package:flutter/material.dart';

class UrlInputField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onSubmitted;

  const UrlInputField({
    super.key, 
    required this.controller,
    this.onSubmitted,
  });

  @override
  State<UrlInputField> createState() => _UrlInputFieldState();
}

class _UrlInputFieldState extends State<UrlInputField> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      decoration: InputDecoration(
        labelText: 'Website URL',
        hintText: 'https://example.com',
        helperText: 'Enter a website URL to analyze its performance',
        prefixIcon: Icon(
          Icons.link_rounded,
          color: colorScheme.primary,
        ),
        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
                icon: Icon(
                  Icons.clear_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
                onPressed: () {
                  widget.controller.clear();
                  setState(() {});
                },
                tooltip: 'Clear URL',
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12 : 16,
          vertical: isSmallScreen ? 12 : 16,
        ),
      ),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.go,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a URL';
        }
        
        // More comprehensive URL validation
        final urlRegExp = RegExp(
          r'^(https?:\/\/)?(www\.)?[a-zA-Z0-9]+([\-\.]{1}[a-zA-Z0-9]+)*\.[a-zA-Z]{2,}(:[0-9]{1,5})?(\/.*)?$',
          caseSensitive: false,
        );
        
        if (!urlRegExp.hasMatch(value.trim())) {
          return 'Please enter a valid URL (e.g., example.com)';
        }
        
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) {
        setState(() {}); // Update suffix icon visibility
      },
      onFieldSubmitted: (value) {
        if (value.isNotEmpty) {
          _focusNode.unfocus();
          widget.onSubmitted?.call();
        }
      },
      style: TextStyle(
        fontSize: isSmallScreen ? 14 : 16,
        color: colorScheme.onSurface,
      ),
    );
  }
}
