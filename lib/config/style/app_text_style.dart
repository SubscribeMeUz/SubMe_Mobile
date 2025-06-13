import 'package:flutter/material.dart';

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle sfProLight;
  final TextStyle sfProSemiBold;
  final TextStyle sfProHeavy;
  final TextStyle sfProBold;
  final TextStyle sfProMedium;
  final TextStyle sfProRegular;

  static const _sfProFamily = 'SF-Pro';

  static const light = AppTextStyles(
    sfProLight: TextStyle(fontFamily: _sfProFamily, fontWeight: FontWeight.w300, fontSize: 14),
    sfProSemiBold: TextStyle(fontFamily: _sfProFamily, fontWeight: FontWeight.w600, fontSize: 18),

    sfProHeavy: TextStyle(fontFamily: _sfProFamily, fontWeight: FontWeight.w800, fontSize: 20),
    sfProBold: TextStyle(fontFamily: _sfProFamily, fontWeight: FontWeight.w700, fontSize: 14),
    sfProMedium: TextStyle(
      fontFamily: _sfProFamily,
      fontWeight: FontWeight.w500,
      fontSize: 17,
      height: 22 / 17,
    ),
    sfProRegular: TextStyle(fontFamily: _sfProFamily, fontWeight: FontWeight.w400, fontSize: 14),
  );

  static const dark = light;

  const AppTextStyles({
    required this.sfProLight,
    required this.sfProSemiBold,
    required this.sfProHeavy,
    required this.sfProBold,
    required this.sfProMedium,
    required this.sfProRegular,
  });

  @override
  AppTextStyles copyWith({
    TextStyle? sfProBold,
    TextStyle? sfProMedium,
    TextStyle? sfProRegular,
    TextStyle? sfProLight,
    TextStyle? sfProSemiBold,
    TextStyle? sfProHeavy,
  }) {
    return AppTextStyles(
      sfProBold: sfProBold ?? this.sfProBold,
      sfProMedium: sfProMedium ?? this.sfProMedium,
      sfProRegular: sfProRegular ?? this.sfProRegular,
      sfProLight: sfProLight ?? this.sfProLight,
      sfProSemiBold: sfProSemiBold ?? this.sfProSemiBold,
      sfProHeavy: sfProHeavy ?? this.sfProHeavy,
    );
  }

  @override
  ThemeExtension<AppTextStyles> lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) return this;
    return AppTextStyles(
      sfProBold: TextStyle.lerp(sfProBold, other.sfProBold, t)!,
      sfProMedium: TextStyle.lerp(sfProMedium, other.sfProMedium, t)!,
      sfProRegular: TextStyle.lerp(sfProRegular, other.sfProRegular, t)!,
      sfProHeavy: TextStyle.lerp(sfProHeavy, other.sfProHeavy, t)!,
      sfProSemiBold: TextStyle.lerp(sfProSemiBold, other.sfProSemiBold, t)!,
      sfProLight: TextStyle.lerp(sfProLight, other.sfProLight, t)!,
    );
  }
}

extension BuildContextX on BuildContext {
  AppTextStyles get textStyle => Theme.of(this).extension<AppTextStyles>()!;
}
