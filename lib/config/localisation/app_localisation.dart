import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  AppLocalizations(this.locale);
  final Locale locale;

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) as AppLocalizations;
  }

  Map<String, dynamic>? _localizedMap;
  Map<String, String>? _localizedStrings;

  Future<bool> load() async {
    final String jsonString = await rootBundle.loadString(
      'assets/i10n/${locale.languageCode}.json',
    );
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedMap = jsonMap;
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  String? translate(String key, {Map<String, String>? values}) {
    String? message = _localizedStrings![key];
    if (message == null && _localizedMap != null && key.contains('.')) {
      message = _getNestedValue(_localizedMap!, key);
    }
    if (values != null && message != null) {
      return _formatReturnMessage(message, values);
    }
    return message;
  }

  String? _getNestedValue(Map<String, dynamic> map, String key) {
    final parts = key.split('.');
    dynamic value = map;
    for (final part in parts) {
      if (value is Map && value.containsKey(part)) {
        value = value[part];
      } else {
        return null;
      }
    }
    return value is String ? value : null;
  }

  String _formatReturnMessage(String value, Map<String, String> arguments) {
    var localValue = value;

    arguments.forEach(
      (formatKey, formatValue) => localValue = localValue.replaceAll('{$formatKey}', formatValue),
    );

    return localValue;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['uz', 'ru', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => true;
}

extension LocalisationExtension on BuildContext {
  String tr(String key, {int? pluralCount, Map<String, String>? values}) {
    final translation = AppLocalizations.of(this).translate(key) ?? '{{$key}}';

    if (values != null) {
      return _formatString(translation, values);
    }

    return translation;
  }

  String _formatString(String template, Map<String, String> values) {
    String result = template;
    values.forEach((key, value) {
      result = result.replaceAll('{$key}', value);
    });
    return result;
  }
}
