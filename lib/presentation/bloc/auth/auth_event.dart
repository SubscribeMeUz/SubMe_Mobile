part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class SendPhoneNumberEvent extends AuthEvent {
  final String phone;

  const SendPhoneNumberEvent({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class ConfirmNumberEvent extends AuthEvent {
  final String phone;
  final String code;

  const ConfirmNumberEvent({required this.phone, required this.code});

  @override
  List<Object?> get props => [phone, code];
}
