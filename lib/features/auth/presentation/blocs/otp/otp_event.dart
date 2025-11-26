part of 'otp_bloc.dart';

abstract class OtpEvent {}

class VerifyOtpEvent extends OtpEvent {
  final String otp;

  VerifyOtpEvent({required this.otp});
}
