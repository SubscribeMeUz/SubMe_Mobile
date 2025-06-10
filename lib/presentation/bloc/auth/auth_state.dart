part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final BlocStatus status;
  final String? errorMessage;

  const AuthState({this.status = BlocStatus.initial, this.errorMessage});

  @override
  List<Object?> get props => [status, errorMessage];

  AuthState copyWith({BlocStatus? status, String? errorMessage}) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
