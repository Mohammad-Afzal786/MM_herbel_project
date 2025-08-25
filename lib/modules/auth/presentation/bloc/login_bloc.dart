import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmherbel/modules/auth/domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(const LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading, error: null));

    final result = await loginUseCase(email: event.email, password: event.password);

    result.fold(
      (failure) => emit(state.copyWith(status: LoginStatus.failure, error: failure.message)),
      (data) => emit(state.copyWith(status: LoginStatus.success, data: data)),
    );
  }
}
