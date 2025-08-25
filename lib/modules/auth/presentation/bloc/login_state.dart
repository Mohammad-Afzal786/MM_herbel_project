import 'package:equatable/equatable.dart';
import 'package:mmherbel/modules/auth/domain/entities/login_result.dart';


enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final LoginResult? data;
  final String? error;

  const LoginState({
    this.status = LoginStatus.initial,
    this.data,
    this.error,
  });

  LoginState copyWith({
    LoginStatus? status,
    LoginResult? data,
    String? error,
  }) {
    return LoginState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, data, error];
}
