part of 'register_bloc.dart';

abstract class RegisterEvent {}

class RegisterUserEvent extends RegisterEvent {
  final String firstName;
  final String email;
  final String password;
  final String? profileImagePath;

  RegisterUserEvent({
    required this.firstName,
    required this.email,
    required this.password,
    this.profileImagePath,
  });
}
