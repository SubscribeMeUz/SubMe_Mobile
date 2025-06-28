part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserEvent extends UserEvent {}
