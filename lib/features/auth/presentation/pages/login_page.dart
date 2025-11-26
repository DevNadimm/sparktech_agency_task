import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sparktech_agency_task/core/constants/colors.dart';
import 'package:sparktech_agency_task/core/widgets/app_bar_back_btn.dart';
import 'package:sparktech_agency_task/core/widgets/app_notifier.dart';
import 'package:sparktech_agency_task/core/widgets/custom_text_field.dart';
import 'package:sparktech_agency_task/core/widgets/loader.dart';
import 'package:sparktech_agency_task/features/auth/presentation/blocs/login/login_bloc.dart';
import 'package:sparktech_agency_task/features/auth/presentation/pages/register_page.dart';
import 'package:sparktech_agency_task/features/auth/presentation/widgets/auth_footer.dart';
import 'package:sparktech_agency_task/features/dashboard/presentation/pages/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const LoginPage());

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          AppNotifier.showToast(state.message, type: MessageType.error);
        }
        if (state is LoginSuccess) {
          Navigator.pushReplacement(context, DashboardPage.route());
          AppNotifier.showToast('Login successful!', type: MessageType.success);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is LoginLoading)
              Container(
                color: AppColors.black.withValues(alpha: 0.6),
                child: const Loader(),
              ),
          ],
        );
      },
    );
  }

  Widget content() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        leading: const AppBarBackBtn(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome back! Sign in to continue your journey and access all your features.",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryFontColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  label: 'Email',
                  controller: _emailController,
                  isRequired: true,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  hintText: 'Enter email',
                  validationLabel: 'Email',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }

                    final emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );

                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Password',
                  controller: _passwordController,
                  isRequired: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  hintText: 'Enter password',
                  validationLabel: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _login,
                    child: const Text('Sign In'),
                  ),
                ),
                const SizedBox(height: 24),
                AuthFooter(
                  label: "Don't have an account? ",
                  actionText: "Register",
                  onTap: () {
                    Navigator.pushReplacement(context, RegisterPage.route());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    if (_globalKey.currentState?.validate() ?? false) {
      context.read<LoginBloc>().add(
        LoginUserEvent(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
