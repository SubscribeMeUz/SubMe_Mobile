import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_pro/config/enums/bloc_status.dart';
import 'package:gym_pro/config/network/api_exception.dart';
import 'package:gym_pro/domain/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc({required this.repository}) : super(AuthState()) {
    on<SendPhoneNumberEvent>(_sendPhoneNumber);
    on<ConfirmNumberEvent>(_confirmNumber);
  }

  FutureOr<void> _sendPhoneNumber(SendPhoneNumberEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      await repository.userLogin(event.phone);

      emit(state.copyWith(status: BlocStatus.success));
    } on ApiException catch (e) {
      emit(state.copyWith(status: BlocStatus.error, errorMessage: e.errMessage));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error, errorMessage: e.toString()));
    }
  }

  FutureOr<void> _confirmNumber(ConfirmNumberEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      await repository.verifyOtp(event.phone, event.code);

      emit(state.copyWith(status: BlocStatus.success));
    } on ApiException catch (e) {
      emit(state.copyWith(status: BlocStatus.error, errorMessage: e.errMessage));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error, errorMessage: e.toString()));
    }
  }
}
