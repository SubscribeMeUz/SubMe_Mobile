import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_pro/config/enums/bloc_status.dart';
import 'package:gym_pro/config/network/api_exception.dart';
import 'package:gym_pro/domain/entity/my_subscription_entity.dart';
import 'package:gym_pro/domain/entity/provider_entity.dart';
import 'package:gym_pro/domain/repository/subscription_repository.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository repository;
  SubscriptionBloc({required this.repository}) : super(SubscriptionState()) {
    on<GetMySubscriptionsEvent>(_getMySubscription);
    on<GetSubscriptionEvent>(_getSubscriptions);
    on<PurchaseSubscriptionEvent>(_purchaseSubscriptions);
  }

  FutureOr<void> _getMySubscription(
    GetMySubscriptionsEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      final data = await repository.getMySubscriptions();

      emit(state.copyWith(status: BlocStatus.success, myAbonements: data));
    } on ApiException catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, errorMessage: e.errMessage));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, errorMessage: '$e'));
    }
  }

  FutureOr<void> _getSubscriptions(
    GetSubscriptionEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      final data = await repository.getAllProvider();

      emit(state.copyWith(status: BlocStatus.success, subscriptions: data));
    } on ApiException catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, errorMessage: e.errMessage));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, errorMessage: '$e'));
    }
  }

  FutureOr<void> _purchaseSubscriptions(
    PurchaseSubscriptionEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      await repository.buySubscription(event.abonementId);

      emit(state.copyWith(status: BlocStatus.success));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure, errorMessage: '$e'));
    }
  }
}
