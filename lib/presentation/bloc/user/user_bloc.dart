import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_pro/config/enums/bloc_status.dart';
import 'package:gym_pro/domain/entity/user_entity.dart';
import 'package:gym_pro/domain/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc({required this.repository}) : super(UserState()) {
    on<GetUserEvent>(_getUser);
    on<UpdateUserEvent>(_updateUser);
  }

  FutureOr<void> _getUser(GetUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      final user = await repository.getUser();

      emit(state.copyWith(status: BlocStatus.success, userEntity: user));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }

  FutureOr<void> _updateUser(UpdateUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      await repository.updateUser(event.username, event.phoneNumber, event.fullName);

      emit(state.copyWith(status: BlocStatus.success));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }
}
