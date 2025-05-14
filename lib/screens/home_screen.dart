import 'package:flutter/material.dart';
import '../services/pagespeed_service.dart';
import '../widgets/url_input_field.dart';
import 'results_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _urlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isAnalyzing = false;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _analyzeWebsite() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isAnalyzing = true);

    try {
      final pageSpeedService = PageSpeedService();
      final result = await pageSpeedService.analyzeWebsite(_urlController.text);

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultsScreen(result: result)),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      if (mounted) {
        setState(() => _isAnalyzing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SiteGleam'), centerTitle: true),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Analyze Website Performance',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              UrlInputField(controller: _urlController),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isAnalyzing ? null : _analyzeWebsite,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                child:
                    _isAnalyzing
                        ? const CircularProgressIndicator()
                        : const Text('Analyze Website'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
