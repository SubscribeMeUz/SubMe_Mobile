class ProviderAbonementsEntity {
  final int id;
  final String title;
  final String logo;
  final List<TabEntity>? tabEntity;
  final Map<String, List<AbonementBlock>> abonements;

  const ProviderAbonementsEntity({
    required this.id,
    required this.title,
    required this.logo,
    required this.tabEntity,
    required this.abonements,
  });
}

class TabEntity {
  final String title;
  final String value;

  const TabEntity({required this.title, required this.value});
}

class AbonementBlock {
  final String? title;
  final List<AbonementOptionEntity> options;

  AbonementBlock({required this.title, required this.options});
}

class AbonementOptionEntity {
  final int id;
  final String planName;
  final String subtitle;
  final String title;
  final String? label;

  const AbonementOptionEntity({
    required this.id,
    required this.planName,
    required this.subtitle,
    required this.title,
    this.label,
  });
}
