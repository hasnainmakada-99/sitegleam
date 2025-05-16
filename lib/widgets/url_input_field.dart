import 'package:flutter/material.dart';

class UrlInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode = FocusNode();
  UrlInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Website URL',
        hintText: 'https://example.com',
        prefixIcon: const Icon(Icons.link),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      keyboardType: TextInputType.url,
      focusNode: focusNode,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a URL';
        }
        final urlRegExp = RegExp(
          r'^(https?:\/\/)?(www\.)?[a-zA-Z0-9]+([\-\.]{1}[a-zA-Z0-9]+)*\.[a-zA-Z]{2,}(:[0-9]{1,5})?(\/.*)?$',
        );
        if (!urlRegExp.hasMatch(value)) {
          return 'Please enter a valid URL';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: (value) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
