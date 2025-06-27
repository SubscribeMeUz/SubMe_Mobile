part of 'abonement_bloc.dart';

sealed class AbonementEvent extends Equatable {
  const AbonementEvent();
}

class GetProviderDetailEvent extends AbonementEvent {
  final int providerId;

  const GetProviderDetailEvent({required this.providerId});

  @override
  List<Object?> get props => [providerId];
}

class GetProviderAbonementsEvent extends AbonementEvent {
  final int providerId;

  const GetProviderAbonementsEvent({required this.providerId});

  @override
  List<Object?> get props => [providerId];
}

class ChangeTabIndexEvent extends AbonementEvent {
  final int tabIndex;

  const ChangeTabIndexEvent({required this.tabIndex});

  @override
  List<Object?> get props => [tabIndex];
}

class ChooseTariffOptionEvent extends AbonementEvent {
  final int optionId;

  const ChooseTariffOptionEvent({required this.optionId});

  @override
  List<Object?> get props => [optionId];
}
