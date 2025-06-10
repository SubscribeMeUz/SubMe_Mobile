import 'package:flutter/material.dart';

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle robotoThin;
  final TextStyle robotoExtraLight;
  final TextStyle robotoLight;
  final TextStyle robotoMedium;
  final TextStyle robotoRegular;
  final TextStyle robotoSemiBold;
  final TextStyle robotoBold;
  final TextStyle robotoExtraBold;
  final TextStyle robotoBlack;
  final TextStyle sfProBold;
  final TextStyle sfProMedium;
  final TextStyle sfProRegular;

  static const _robotoFamily = 'Roboto';
  static const _sfProFamily = 'SF-Pro';

  static const light = AppTextStyles(
    robotoThin: TextStyle(fontFamily: _robotoFamily, fontWeight: FontWeight.w100, fontSize: 12),
    robotoExtraLight: TextStyle(
      fontFamily: _robotoFamily,
      fontWeight: FontWeight.w200,
      fontSize: 14,
    ),
    robotoLight: TextStyle(fontFamily: _robotoFamily, fontWeight: FontWeight.w300, fontSize: 14),
    robotoRegular: TextStyle(fontFamily: _robotoFamily, fontWeight: FontWeight.w400, fontSize: 16),
    robotoMedium: TextStyle(fontFamily: _robotoFamily, fontWeight: FontWeight.w500, fontSize: 16),
    robotoSemiBold: TextStyle(fontFamily: _robotoFamily, fontWeight: FontWeight.w600, fontSize: 18),
    robotoBold: TextStyle(fontFamily: _robotoFamily, fontWeight: FontWeight.w700, fontSize: 18),
    robotoExtraBold: TextStyle(
      fontFamily: _robotoFamily,
      fontWeight: FontWeight.w800,
      fontSize: 20,
    ),
    robotoBlack: TextStyle(fontFamily: _robotoFamily, fontWeight: FontWeight.w900, fontSize: 20),
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
    required this.robotoThin,
    required this.robotoExtraLight,
    required this.robotoLight,
    required this.robotoMedium,
    required this.robotoRegular,
    required this.robotoSemiBold,
    required this.robotoBold,
    required this.robotoExtraBold,
    required this.robotoBlack,
    required this.sfProBold,
    required this.sfProMedium,
    required this.sfProRegular,
  });

  @override
  AppTextStyles copyWith({
    TextStyle? mediumFont,
    TextStyle? robotoThin,
    TextStyle? robotoExtraLight,
    TextStyle? robotoLight,
    TextStyle? robotoRegular,
    TextStyle? robotoMedium,
    TextStyle? robotoSemiBold,
    TextStyle? robotoBold,
    TextStyle? robotoExtraBold,
    TextStyle? robotoBlack,
    TextStyle? sfProBold,
    TextStyle? sfProMedium,
    TextStyle? sfProRegular,
  }) {
    return AppTextStyles(
      robotoThin: robotoThin ?? this.robotoThin,
      robotoExtraLight: robotoExtraLight ?? this.robotoExtraLight,
      robotoLight: robotoLight ?? this.robotoLight,
      robotoRegular: robotoRegular ?? this.robotoRegular,
      robotoMedium: robotoMedium ?? this.robotoMedium,
      robotoSemiBold: robotoSemiBold ?? this.robotoSemiBold,
      robotoBold: robotoBold ?? this.robotoBold,
      robotoExtraBold: robotoExtraBold ?? this.robotoExtraBold,
      robotoBlack: robotoBlack ?? this.robotoBlack,
      sfProBold: sfProBold ?? this.sfProBold,
      sfProMedium: sfProMedium ?? this.sfProMedium,
      sfProRegular: sfProRegular ?? this.sfProRegular,
    );
  }

  @override
  ThemeExtension<AppTextStyles> lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) return this;
    return AppTextStyles(
      robotoThin: TextStyle.lerp(robotoThin, other.robotoThin, t)!,

      robotoExtraLight: TextStyle.lerp(robotoExtraLight, other.robotoExtraLight, t)!,
      robotoLight: TextStyle.lerp(robotoLight, other.robotoLight, t)!,
      robotoRegular: TextStyle.lerp(robotoRegular, other.robotoRegular, t)!,
      robotoMedium: TextStyle.lerp(robotoMedium, other.robotoMedium, t)!,

      robotoSemiBold: TextStyle.lerp(robotoSemiBold, other.robotoSemiBold, t)!,
      robotoBold: TextStyle.lerp(robotoBold, other.robotoBold, t)!,
      robotoExtraBold: TextStyle.lerp(robotoExtraBold, other.robotoExtraBold, t)!,
      robotoBlack: TextStyle.lerp(robotoBlack, other.robotoBlack, t)!,
      sfProBold: TextStyle.lerp(sfProBold, other.sfProBold, t)!,
      sfProMedium: TextStyle.lerp(sfProMedium, other.sfProMedium, t)!,
      sfProRegular: TextStyle.lerp(sfProRegular, other.sfProRegular, t)!,
    );
  }
}

extension BuildContextX on BuildContext {
  AppTextStyles get textStyle => Theme.of(this).extension<AppTextStyles>()!;
}
