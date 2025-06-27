import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_pro/config/enums/bloc_status.dart';
import 'package:gym_pro/config/network/api_exception.dart';
import 'package:gym_pro/domain/entity/provider_abonements_entity.dart';
import 'package:gym_pro/domain/entity/subcription_entity.dart';
import 'package:gym_pro/domain/repository/subscription_repository.dart';

part 'abonement_event.dart';
part 'abonement_state.dart';

class AbonementBloc extends Bloc<AbonementEvent, AbonementState> {
  final SubscriptionRepository repository;

  AbonementBloc({required this.repository}) : super(AbonementState()) {
    on<GetProviderDetailEvent>(_getProviderDetail);
    on<GetProviderAbonementsEvent>(_getProviderAbonements);
    on<ChangeTabIndexEvent>(_changeTab);
    on<ChooseTariffOptionEvent>(_chooseOption);
  }

  FutureOr<void> _getProviderDetail(
    GetProviderDetailEvent event,
    Emitter<AbonementState> emit,
  ) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      final data = await repository.getProviderDetail(event.providerId);

      emit(state.copyWith(status: BlocStatus.success, providerDetailEntity: data));
    } on ApiException catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, errorMessage: e.errMessage));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, errorMessage: '$e'));
    }
  }

  FutureOr<void> _getProviderAbonements(
    GetProviderAbonementsEvent event,
    Emitter<AbonementState> emit,
  ) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      final data = await repository.getProviderTariffs(event.providerId);

      emit(state.copyWith(status: BlocStatus.success, providerTariffList: data));
    } on ApiException catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, errorMessage: e.errMessage));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, errorMessage: '$e'));
    }
  }

  FutureOr<void> _changeTab(ChangeTabIndexEvent event, Emitter<AbonementState> emit) async {
    emit(state.copyWith(tabIndex: event.tabIndex));
  }

  FutureOr<void> _chooseOption(ChooseTariffOptionEvent event, Emitter<AbonementState> emit) async {
    emit(state.copyWith(chosenOptionId: event.optionId));
  }
}
