import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color primaryColor;
  final Color backgroundColor;
  final Color whiteColor;
  final Color blackColor;
  final Color redColor;
  final Color grayDarkColor;
  final Color containerDark;
  final Color cardDark;
  final Color modalDark;
  final Color primaryContainerDark;
  final Color secondaryColor;
  final Color borderColor;
  final Color disabledColor;
  final Color disabledButtonColor;

  const AppColors({
    required this.primaryColor,
    required this.backgroundColor,
    required this.whiteColor,
    required this.blackColor,
    required this.redColor,
    required this.grayDarkColor,
    required this.secondaryColor,
    required this.borderColor,
    required this.disabledColor,
    required this.disabledButtonColor,
    required this.containerDark,
    required this.cardDark,
    required this.primaryContainerDark,
    required this.modalDark,
  });

  static const lightTheme = AppColors(
    primaryColor: Color(0xffC3FF45),
    disabledButtonColor: Color.fromARGB(255, 112, 129, 76),
    backgroundColor: Color(0xff000000),
    whiteColor: Colors.white,
    blackColor: Color(0xff000000),
    secondaryColor: Color(0xFFEBF599),
    borderColor: Color(0xff292D30),
    disabledColor: Color(0xffBDBDBD),
    redColor: Color(0xffFF4530),
    grayDarkColor: Color(0xff868686),
    containerDark: Color(0xff1C1C1E),
    modalDark: Color(0xff111214),
    primaryContainerDark: Color(0xff141D00),
    cardDark: Color(0xff141414),
  );
  static const darkTheme = AppColors(
    primaryColor: Color(0xff3B23C3),
    disabledButtonColor: Color.fromARGB(255, 112, 129, 76),
    backgroundColor: Color(0xffF2F2F2),
    whiteColor: Colors.white,
    blackColor: Color(0xff000000),
    secondaryColor: Color(0xEBEBF599),
    borderColor: Color(0xff292D30),
    disabledColor: Color(0xffBDBDBD),
    redColor: Color(0xffFF4530),
    grayDarkColor: Color(0xff868686),
    containerDark: Color(0xff1C1C1E),
    cardDark: Color(0xff141414),
    modalDark: Color(0xff111214),
    primaryContainerDark: Color(0xff141D00),
  );

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primaryColor,
    Color? whiteColor,
    Color? backgroundColor,
    Color? lightBlackColor,
    Color? secondaryColor,
    Color? borderColor,
    Color? disabledColor,
    Color? disabledButtonColor,
    Color? redColor,
    Color? grayDarkColor,
    Color? containerDark,
    Color? primaryContainerDark,
    Color? modalDark,
    Color? cardDark,
    Color? blackColor,
  }) {
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      borderColor: borderColor ?? this.borderColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      whiteColor: whiteColor ?? this.whiteColor,
      cardDark: cardDark ?? this.cardDark,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      disabledColor: disabledColor ?? this.disabledColor,
      disabledButtonColor: disabledButtonColor ?? this.disabledButtonColor,
      redColor: redColor ?? this.redColor,
      grayDarkColor: grayDarkColor ?? this.grayDarkColor,
      containerDark: containerDark ?? this.containerDark,
      primaryContainerDark: primaryContainerDark ?? this.primaryContainerDark,
      modalDark: modalDark ?? this.modalDark,
      blackColor: blackColor ?? this.blackColor,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      whiteColor: Color.lerp(whiteColor, other.whiteColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t)!,
      disabledButtonColor: Color.lerp(disabledButtonColor, other.disabledButtonColor, t)!,
      redColor: Color.lerp(redColor, other.redColor, t)!,
      grayDarkColor: Color.lerp(grayDarkColor, other.grayDarkColor, t)!,
      containerDark: Color.lerp(containerDark, other.containerDark, t)!,
      primaryContainerDark: Color.lerp(primaryContainerDark, other.primaryContainerDark, t)!,
      modalDark: Color.lerp(modalDark, other.modalDark, t)!,
      cardDark: Color.lerp(cardDark, other.cardDark, t)!,
      blackColor: Color.lerp(blackColor, other.blackColor, t)!,
    );
  }
}

extension BuildContextX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
