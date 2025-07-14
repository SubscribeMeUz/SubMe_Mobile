part of 'visit_bloc.dart';

sealed class VisitEvent extends Equatable {
  const VisitEvent();
  @override
  List<Object?> get props => [];
}

class GetMyAbonementsOfProviderEvent extends VisitEvent {
  final String providerId;

  const GetMyAbonementsOfProviderEvent({required this.providerId});

  @override
  List<Object?> get props => [providerId];
}

class SendVisitEvent extends VisitEvent {
  final int providerId;
  final int abonementId;

  const SendVisitEvent({required this.providerId, required this.abonementId});

  @override
  List<Object?> get props => [providerId, abonementId];
}
