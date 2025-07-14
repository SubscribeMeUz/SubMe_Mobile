part of 'visit_bloc.dart';

class VisitState extends Equatable {
  final BlocStatus status;
  final BlocStatus visitStatus;
  final List<MySubscriptionEntity> myAbonementsInProvider;
  final int? providerId;
  final String? errorMessage;

  const VisitState({
    this.status = BlocStatus.initial,
    this.visitStatus = BlocStatus.initial,
    this.errorMessage,
    this.providerId,
    this.myAbonementsInProvider = const [],
  });

  @override
  List<Object?> get props => [
    status,
    visitStatus,
    providerId,
    errorMessage,
    myAbonementsInProvider,
  ];

  VisitState copyWith({
    BlocStatus? status,
    BlocStatus? visitStatus,
    String? errorMessage,
    int? providerId,
    List<MySubscriptionEntity>? myAbonementsInProvider,
  }) {
    return VisitState(
      status: status ?? this.status,
      visitStatus: visitStatus ?? this.visitStatus,
      providerId: providerId ?? this.providerId,
      errorMessage: errorMessage ?? this.errorMessage,
      myAbonementsInProvider: myAbonementsInProvider ?? this.myAbonementsInProvider,
    );
  }
}
