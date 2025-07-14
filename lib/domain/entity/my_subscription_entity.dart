class MySubscriptionEntity {
  final int id;
  final int providerId;
  final String name;
  final String logoUrl;
  final bool isPopular;
  final String period;
  final DateTime? finishDate;
  final DateTime? startDate;
  final int leftDays;
  final int totalCount;
  final int leftCount;

  const MySubscriptionEntity({
    required this.id,
    required this.providerId,
    required this.name,
    required this.logoUrl,
    required this.isPopular,
    required this.period,
    required this.finishDate,
    required this.leftDays,
    required this.totalCount,
    required this.leftCount,
    required this.startDate,
  });
}
