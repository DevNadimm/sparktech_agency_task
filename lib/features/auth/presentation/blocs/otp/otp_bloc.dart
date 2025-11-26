import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparktech_agency_task/features/auth/data/repositories/otp_repository.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial()) {
    on<VerifyOtpEvent>(_onVerifyOtp);
  }

  Future<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<OtpState> emit,
  ) async {
    emit(OtpLoading());
    try {
      final data = await OtpRepository.verifyOtp(otp: event.otp);
      emit(OtpSuccess(data));
    } catch (e) {
      emit(OtpFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
