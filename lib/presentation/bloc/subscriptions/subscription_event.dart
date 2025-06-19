part of 'subscription_bloc.dart';

sealed class SubscriptionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMySubscriptionsEvent extends SubscriptionEvent {}

class GetSubscriptionEvent extends SubscriptionEvent {}
