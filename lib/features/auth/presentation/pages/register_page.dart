import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sparktech_agency_task/core/constants/colors.dart';
import 'package:sparktech_agency_task/core/widgets/app_bar_back_btn.dart';
import 'package:sparktech_agency_task/core/widgets/app_notifier.dart';
import 'package:sparktech_agency_task/core/widgets/custom_text_field.dart';
import 'package:sparktech_agency_task/core/widgets/loader.dart';
import 'package:sparktech_agency_task/features/auth/presentation/blocs/register/register_bloc.dart';
import 'package:sparktech_agency_task/features/auth/presentation/widgets/auth_footer.dart';
import 'package:sparktech_agency_task/features/auth/presentation/widgets/upload_profile_image_section.dart';

class RegisterPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const RegisterPage());

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  File? _profileImage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          AppNotifier.showToast(state.message, type: MessageType.error);
        }
        if (state is RegisterSuccess) {
          AppNotifier.showToast(
            'Registration successful! Please login.',
            type: MessageType.success,
          );
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   LoginPage.route(),
          //       (route) => false,
          // );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is RegisterLoading)
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
        title: const Text('Register an Account'),
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
                    "Create your account and get started. Your smarter, faster and more organized journey begins here.",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryFontColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                UploadProfileImageSection(
                  imageFile: _profileImage,
                  onImagePicked: (image) => setState(() => _profileImage = image),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  label: 'First Name',
                  controller: _firstNameController,
                  isRequired: true,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  hintText: 'Enter first name',
                  validationLabel: 'First Name',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Email',
                  controller: _emailController,
                  isRequired: true,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  hintText: 'Enter email',
                  validationLabel: 'Email',
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
                    onPressed: _register,
                    child: const Text('Register'),
                  ),
                ),
                const SizedBox(height: 24),
                AuthFooter(
                  label: "Already have an account? ",
                  actionText: "Sign In",
                  onTap: () {
                    // Navigator.pushReplacement(context, LoginPage.route());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _register() {
    if (_globalKey.currentState?.validate() ?? false) {
      context.read<RegisterBloc>().add(
        RegisterUserEvent(
          firstName: _firstNameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          profileImagePath: _profileImage?.path,
        ),
      );
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}