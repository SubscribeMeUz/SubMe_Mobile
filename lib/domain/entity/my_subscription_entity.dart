class MySubscriptionEntity {
  final int id;
  final String name;
  final String logoUrl;
  final bool isPopular;
  final String period;
  final DateTime finishDate;
  final int leftDays;

  const MySubscriptionEntity({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.isPopular,
    required this.period,
    required this.finishDate,
    required this.leftDays,
  });
}
