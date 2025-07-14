part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final String? phoneNumber;
  final String? fullName;
  final String? username;

  UpdateUserEvent({this.phoneNumber, this.fullName, this.username});
}
