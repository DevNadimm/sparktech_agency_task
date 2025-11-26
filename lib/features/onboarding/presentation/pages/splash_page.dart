import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sparktech_agency_task/core/constants/asset_paths.dart';
import 'package:sparktech_agency_task/core/constants/colors.dart';
import 'package:sparktech_agency_task/core/services/app_preferences.dart';
import 'package:sparktech_agency_task/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:sparktech_agency_task/features/onboarding/presentation/pages/welcome_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 3));

    final token = await AppPreferences.getAccessToken();
    if (!mounted) return;

    if (token.isNotEmpty) {
      Navigator.pushReplacement(context, DashboardPage.route());
    } else {
      Navigator.pushReplacement(context, WelcomePage.route());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset(
                          AssetPaths.sparktechLogo,
                          height: 100,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'SparkTech Task',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 24,
                            color: AppColors.primaryFontColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
