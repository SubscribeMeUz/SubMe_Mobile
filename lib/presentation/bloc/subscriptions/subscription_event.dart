part of 'subscription_bloc.dart';

sealed class SubscriptionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMySubscriptionsEvent extends SubscriptionEvent {}

class GetSubscriptionEvent extends SubscriptionEvent {}

class PurchaseSubscriptionEvent extends SubscriptionEvent {
  final int abonementId;

  PurchaseSubscriptionEvent({required this.abonementId});

  @override
  List<Object> get props => [abonementId];
}
