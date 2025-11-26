part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final Map<String, dynamic> data;

  LoginSuccess(this.data);
}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}
