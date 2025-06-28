part of 'user_bloc.dart';

class UserState extends Equatable {
  final BlocStatus status;
  final UserEntity? userEntity;
  final String? errorMessage;

  const UserState({this.status = BlocStatus.initial, this.userEntity, this.errorMessage});

  @override
  List<Object?> get props => [status, userEntity, errorMessage];

  UserState copyWith({BlocStatus? status, UserEntity? userEntity, String? errorMessage}) {
    return UserState(
      status: status ?? this.status,
      userEntity: userEntity ?? this.userEntity,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
