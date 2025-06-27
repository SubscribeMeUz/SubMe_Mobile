part of 'abonement_bloc.dart';

class AbonementState extends Equatable {
  final BlocStatus status;
  final String? errorMessage;
  final SubscriptionEntity? providerDetailEntity;
  final ProviderAbonementsEntity? providerTariffList;
  final int tabIndex;
  final int? chosenOptionId;

  const AbonementState({
    this.status = BlocStatus.initial,
    this.errorMessage,
    this.providerDetailEntity,
    this.providerTariffList,
    this.tabIndex = 0,
    this.chosenOptionId,
  });

  AbonementState copyWith({
    BlocStatus? status,
    String? errorMessage,
    SubscriptionEntity? providerDetailEntity,
    ProviderAbonementsEntity? providerTariffList,
    int? tabIndex,
    int? chosenOptionId,
  }) {
    return AbonementState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      providerDetailEntity: providerDetailEntity ?? this.providerDetailEntity,
      providerTariffList: providerTariffList ?? this.providerTariffList,
      tabIndex: tabIndex ?? this.tabIndex,
      chosenOptionId: chosenOptionId ?? this.chosenOptionId,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    providerDetailEntity,
    providerTariffList,
    tabIndex,
    chosenOptionId,
  ];
}
