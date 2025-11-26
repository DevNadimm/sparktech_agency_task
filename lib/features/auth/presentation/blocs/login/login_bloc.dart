import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparktech_agency_task/features/auth/data/repositories/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUserEvent>(_onLoginUser);
  }

  Future<void> _onLoginUser(
    LoginUserEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final data = await LoginRepository.loginUser(
        email: event.email,
        password: event.password,
      );
      emit(LoginSuccess(data));
    } catch (e) {
      emit(LoginFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
