part of 'subscription_bloc.dart';

class SubscriptionState extends Equatable {
  final BlocStatus status;
  final List<MySubscriptionEntity> myAbonements;
  final int myAbonementsCount;
  final List<SubscriptionEntity> subscriptions;
  final int subscriptionCount;
  final String? errorMessage;

  const SubscriptionState({
    this.status = BlocStatus.initial,
    this.myAbonements = const [],
    this.subscriptions = const [],
    this.myAbonementsCount = 1,
    this.subscriptionCount = 1,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
    status,
    myAbonements,
    subscriptions,
    errorMessage,
    myAbonementsCount,
    subscriptionCount,
  ];

  SubscriptionState copyWith({
    BlocStatus? status,
    List<MySubscriptionEntity>? myAbonements,
    List<SubscriptionEntity>? subscriptions,
    String? errorMessage,
    int? myAbonementsCount,
    int? subscriptionCount,
  }) {
    return SubscriptionState(
      status: status ?? this.status,
      myAbonements: myAbonements ?? this.myAbonements,
      subscriptions: subscriptions ?? this.subscriptions,
      errorMessage: errorMessage ?? this.errorMessage,
      myAbonementsCount: myAbonementsCount ?? this.myAbonementsCount,
      subscriptionCount: subscriptionCount ?? this.subscriptionCount,
    );
  }
}
