import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sparktech_agency_task/core/constants/colors.dart';
import 'package:sparktech_agency_task/core/widgets/app_bar_back_btn.dart';
import 'package:sparktech_agency_task/core/widgets/app_notifier.dart';
import 'package:sparktech_agency_task/core/widgets/loader.dart';
import 'package:sparktech_agency_task/features/auth/presentation/blocs/otp/otp_bloc.dart';
import 'package:sparktech_agency_task/features/auth/presentation/pages/login_page.dart';

class OtpVerificationPage extends StatefulWidget {
  static Route route(String email) => MaterialPageRoute(
    builder: (_) => OtpVerificationPage(email: email),
  );

  final String email;

  const OtpVerificationPage({super.key, required this.email});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state is OtpFailure) {
          AppNotifier.showToast(state.message, type: MessageType.error);
        }
        if (state is OtpSuccess) {
          AppNotifier.showToast(
            'Account verified successfully! Please login.',
            type: MessageType.success,
          );
          Navigator.push(
            context,
            LoginPage.route(),
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is OtpLoading)
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
        title: const Text('OTP Verification'),
        leading: const AppBarBackBtn(),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  text: "Enter the 6-digit OTP sent to ",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryFontColor,
                    ),
                  ),
                  children: [
                    TextSpan(
                      text: widget.email,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryFontColor,
                        ),
                      ),
                    ),
                    const TextSpan(
                      text: " to verify your account.",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _otpField(context),
              const SizedBox(height: 24),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _verifyOtp,
                  child: const Text("Verify OTP"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verifyOtp() {
    final otp = _otpController.text.trim();
    if (otp.isEmpty) {
      AppNotifier.showToast('OTP cannot be empty', type: MessageType.error);
    } else if (otp.length < 6) {
      AppNotifier.showToast('OTP must be 6 digits', type: MessageType.error);
    } else {
      context.read<OtpBloc>().add(VerifyOtpEvent(otp: otp));
    }
  }

  Widget _otpField(BuildContext context) {
    return PinCodeTextField(
      controller: _otpController,
      length: 6,
      obscureText: false,
      keyboardType: TextInputType.number,
      animationType: AnimationType.scale,
      backgroundColor: Colors.transparent,
      autoDisposeControllers: false,
      enableActiveFill: true,
      appContext: context,
      animationDuration: const Duration(milliseconds: 300),
      textStyle: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryFontColor,
        ),
      ),
      cursorColor: AppColors.primaryColor,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(16),
        fieldHeight: 56,
        fieldWidth: 48,
        borderWidth: 2,
        fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 4),
        activeColor: AppColors.primaryColor,
        selectedColor: AppColors.primaryColor,
        inactiveColor: AppColors.inputBorderColor,
        disabledColor: Colors.grey.shade300,
        activeFillColor: AppColors.white,
        selectedFillColor: AppColors.cardOverlay,
        inactiveFillColor: AppColors.white,
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}
