import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_pro/config/enums/bloc_status.dart';
import 'package:gym_pro/config/network/api_exception.dart';
import 'package:gym_pro/domain/entity/my_subscription_entity.dart';
import 'package:gym_pro/domain/repository/subscription_repository.dart';

part 'visit_state.dart';
part 'visit_event.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  final SubscriptionRepository repository;

  VisitBloc({required this.repository}) : super(VisitState()) {
    on<GetMyAbonementsOfProviderEvent>(_getMyAbonementsOfProvider);
    on<SendVisitEvent>(_sendVisit);
  }

  FutureOr<void> _sendVisit(SendVisitEvent event, Emitter<VisitState> emit) async {
    try {
      emit(state.copyWith(visitStatus: BlocStatus.loading));

      await repository.visitAbonement(event.abonementId, event.providerId);

      emit(state.copyWith(visitStatus: BlocStatus.success));
    } on ApiException catch (e) {
      emit(state.copyWith(visitStatus: BlocStatus.error, errorMessage: e.errMessage));
    } catch (e) {
      emit(state.copyWith(visitStatus: BlocStatus.error, errorMessage: '$e'));
    }
  }

  FutureOr<void> _getMyAbonementsOfProvider(
    GetMyAbonementsOfProviderEvent event,
    Emitter<VisitState> emit,
  ) async {
    try {
      final providerId = int.tryParse(event.providerId);

      emit(state.copyWith(status: BlocStatus.loading, providerId: providerId));

      final data = await repository.getMySubscriptions();

      final abonOfProviderIdList =
          data.where((element) => element.providerId == providerId).toList();

      emit(
        state.copyWith(status: BlocStatus.success, myAbonementsInProvider: abonOfProviderIdList),
      );
    } on ApiException catch (e) {
      emit(state.copyWith(status: BlocStatus.error, errorMessage: e.errMessage));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error, errorMessage: '$e'));
    }
  }
}
