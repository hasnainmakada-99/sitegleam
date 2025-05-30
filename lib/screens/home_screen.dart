import 'package:flutter/material.dart';
import '../services/pagespeed_service.dart';
import '../widgets/url_input_field.dart';
import '../config/theme.dart';
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

    // Hide keyboard when analysis starts
    FocusScope.of(context).unfocus();

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
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red.shade800,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isAnalyzing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSmallScreen = AppTheme.isMobile(context);
    final responsivePadding = AppTheme.getResponsivePadding(context);

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: isSmallScreen ? 150.0 : 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    'SiteGleam',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: AppTheme.getResponsiveFontSize(context, 20),
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          colorScheme.primary,
                          colorScheme.primaryContainer,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.speed_rounded,
                        size: isSmallScreen ? 60 : 80,
                        color: colorScheme.onPrimary.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: AppTheme.isDesktop(context) ? 800 : double.infinity,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(responsivePadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Website Performance Analysis',
                            style: TextStyle(
                              fontSize: AppTheme.getResponsiveFontSize(context, 24),
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Enter a URL to analyze its performance, accessibility, best practices, and SEO metrics.',
                            style: TextStyle(
                              fontSize: AppTheme.getResponsiveFontSize(context, 16),
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 32),
                          UrlInputField(
                            controller: _urlController,
                            onSubmitted: _analyzeWebsite,
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton.icon(
                              onPressed: _isAnalyzing ? null : _analyzeWebsite,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.primary,
                                foregroundColor: colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: _isAnalyzing
                                  ? SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: colorScheme.onPrimary,
                                      ),
                                    )
                                  : const Icon(Icons.analytics_rounded),
                              label: Text(
                                _isAnalyzing ? 'Analyzing...' : 'Analyze Website',
                                style: TextStyle(
                                  fontSize: AppTheme.getResponsiveFontSize(context, 16),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 48),
                          _buildFeaturesSection(colorScheme),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(ColorScheme colorScheme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = AppTheme.isDesktop(context);
        final isTablet = AppTheme.isTablet(context);
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What We Analyze',
              style: TextStyle(
                fontSize: AppTheme.getResponsiveFontSize(context, 20),
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            if (isDesktop || isTablet)
              // Grid layout for larger screens
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: isDesktop ? 2 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 3,
                children: [
                  _buildFeatureCard(
                    icon: Icons.speed,
                    title: 'Performance',
                    description: 'Loading time and interactivity metrics',
                    color: Colors.blue,
                  ),
                  _buildFeatureCard(
                    icon: Icons.accessibility_new,
                    title: 'Accessibility',
                    description: 'How accessible your site is to all users',
                    color: Colors.green,
                  ),
                  _buildFeatureCard(
                    icon: Icons.check_circle,
                    title: 'Best Practices',
                    description: 'Adherence to web development best practices',
                    color: Colors.amber,
                  ),
                  _buildFeatureCard(
                    icon: Icons.trending_up,
                    title: 'SEO',
                    description: 'Search engine optimization factors',
                    color: Colors.purple,
                  ),
                ],
              )
            else
              // Column layout for mobile
              Column(
                children: [
                  _buildFeatureCard(
                    icon: Icons.speed,
                    title: 'Performance',
                    description: 'Loading time and interactivity metrics',
                    color: Colors.blue,
                  ),
                  _buildFeatureCard(
                    icon: Icons.accessibility_new,
                    title: 'Accessibility',
                    description: 'How accessible your site is to all users',
                    color: Colors.green,
                  ),
                  _buildFeatureCard(
                    icon: Icons.check_circle,
                    title: 'Best Practices',
                    description: 'Adherence to web development best practices',
                    color: Colors.amber,
                  ),
                  _buildFeatureCard(
                    icon: Icons.trending_up,
                    title: 'SEO',
                    description: 'Search engine optimization factors',
                    color: Colors.purple,
                  ),
                ],
              ),
          ],
        );
      },
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              radius: 24,
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
