import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sparktech_agency_task/core/constants/colors.dart';
import 'package:sparktech_agency_task/core/services/app_preferences.dart';
import 'package:sparktech_agency_task/features/onboarding/presentation/pages/welcome_page.dart';

class DashboardPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const DashboardPage());

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Thank You, SparkTech Agency!',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryFontColor,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'I really appreciate the opportunity to participate in this round. Looking forward to contributing and growing with the team!',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: AppColors.secondaryFontColor,
                      height: 1.5,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Icon(
                  Icons.task_alt_rounded,
                  size: 100,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () async {
                      await AppPreferences.clearAll();
                      if (!context.mounted) return;
                      Navigator.pushAndRemoveUntil(
                        context,
                        WelcomePage.route(), (route) => false,
                      );
                    },
                    child: Text('Logout'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
