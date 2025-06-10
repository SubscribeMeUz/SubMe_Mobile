part of 'app_settings_cubit.dart';

class AppSettingsState extends Equatable {
  final String locale;

  const AppSettingsState({required this.locale});

  @override
  List<Object?> get props => [locale];
}
