import 'package:gym_pro/domain/entity/provider_abonements_entity.dart';

class ProviderAbonementsModel {
  final int id;
  final String title;
  final String logo;
  final List<TabOption>? tabs;
  final Map<String, List<PlanBlock>> plansByTab;

  ProviderAbonementsModel({
    required this.id,
    required this.title,
    required this.logo,
    required this.tabs,
    required this.plansByTab,
  });

  factory ProviderAbonementsModel.fromJson(Map<String, dynamic> json) {
    late final List<dynamic> tabs;
    if (json.containsKey('tabs')) {
      tabs = json['tabs'] as List;
    } else {
      tabs = [];
    }
    return ProviderAbonementsModel(
      id: json['id'],
      title: json['title'],
      logo: json['logo'],
      tabs: tabs.isEmpty ? null : tabs.map((e) => TabOption.fromJson(e)).toList(),
      plansByTab: (json['plansByTab'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, (value as List).map((e) => PlanBlock.fromJson(e)).toList()),
      ),
    );
  }

  ProviderAbonementsEntity get toEntity {
    return ProviderAbonementsEntity(
      id: id,
      title: title,
      logo: logo,
      isHorizontal: plansByTab.entries.length > 1,
      tabEntity: tabs?.map((e) => TabEntity(title: e.label, value: e.value)).toList(),
      abonements: plansByTab.map(
        (key, value) => MapEntry(key, value.map((e) => e.toEntity).toList()),
      ),
    );
  }
}

class TabOption {
  final String label;
  final String value;

  TabOption({required this.label, required this.value});

  factory TabOption.fromJson(Map<String, dynamic> json) {
    return TabOption(label: json['label'], value: json['value']);
  }
}

class PlanBlock {
  final String? title;
  final List<PlanOption> options;

  PlanBlock({required this.title, required this.options});

  factory PlanBlock.fromJson(Map<String, dynamic> json) {
    return PlanBlock(
      title: json['title'],
      options: (json['options'] as List).map((e) => PlanOption.fromJson(e)).toList(),
    );
  }

  AbonementBlock get toEntity {
    return AbonementBlock(title: title, options: options.map((e) => e.toEntity).toList());
  }
}

class PlanOption {
  final int id;
  final String planName;
  final String subtitle;
  final String title;
  final String? label;

  PlanOption({
    required this.id,
    required this.planName,
    required this.subtitle,
    this.label,
    required this.title,
  });

  factory PlanOption.fromJson(Map<String, dynamic> json) {
    return PlanOption(
      id: json['id'],
      planName: json['plan_name'],
      subtitle: json['subtitle'],
      title: json['title'],
      label: json['label'],
    );
  }

  AbonementOptionEntity get toEntity {
    return AbonementOptionEntity(id: id, planName: planName, subtitle: subtitle, title: title);
  }
}
