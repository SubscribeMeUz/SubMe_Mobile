import 'package:flutter/material.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  applyElevationOverlayColor: true,
  visualDensity: VisualDensity.standard,
  materialTapTargetSize: MaterialTapTargetSize.padded,
);

final ThemeData appLightTheme = appTheme.copyWith(
  primaryColor: AppColors.lightTheme.primaryColor,

  scaffoldBackgroundColor: AppColors.lightTheme.backgroundColor,
  brightness: Brightness.light,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.transparent),
  dividerTheme: DividerThemeData(
    thickness: 0.5,
    space: 0.5,
    color: AppColors.lightTheme.borderColor,
  ),
  extensions: <ThemeExtension<dynamic>>[
    AppTextStyles.light,
    AppColors.lightTheme,
    // ThemeGradients.light,
  ],
  appBarTheme: AppBarTheme(
    elevation: 0.25,
    foregroundColor: AppColors.lightTheme.backgroundColor,
    backgroundColor: AppColors.lightTheme.backgroundColor,
    surfaceTintColor: AppColors.lightTheme.backgroundColor,

    titleTextStyle: AppTextStyles.light.sfProRegular,
    toolbarHeight: 56,
    scrolledUnderElevation: 0.5,
    centerTitle: true,
    iconTheme: IconThemeData(
      color: AppColors.lightTheme.whiteColor,
      size: 20,
      opacity: 1,
      opticalSize: 24,
    ),
  ),

  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: AppColors.lightTheme.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      fixedSize: const Size(60, 55),
      iconSize: 35,
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: AppColors.lightTheme.primaryColor,
      foregroundColor: AppColors.lightTheme.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
);

// final appDarkTheme = appTheme.copyWith(
//   primaryColor: AppColors.darkTheme.primary,
//   scaffoldBackgroundColor: Colors.black,
//   brightness: Brightness.dark,

//   dividerTheme: const DividerThemeData(
//     thickness: 0.5,
//     space: 0.5,
//     // color: ThemeColors.dark.separator,
//   ),
//   bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.transparent),
//   // bottomSheetTheme:
//   //     BottomSheetThemeData(backgroundColor: ThemeColors.dark.bodySurfaceColor),
//   extensions: <ThemeExtension<dynamic>>[
//     AppTextStyles.light,
//     AppColors.dark,
//     // ThemeGradients.dark,
//   ],
//   appBarTheme: const AppBarTheme(
//     elevation: 0.25,
//     centerTitle: true,
//     toolbarHeight: 56,
//     scrolledUnderElevation: 0.5,
//     iconTheme: IconThemeData(opacity: 1, size: 20, opticalSize: 24),
//   ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//       disabledBackgroundColor: const Color(0xFFE9E9E9),
//       disabledForegroundColor: const Color(0xFF9B9B9B),
//       foregroundColor: Colors.black,
//       backgroundColor: const Color(0xFF5389B5),
//       iconColor: Colors.white,
//       elevation: 4,
//       minimumSize: const Size.fromHeight(50),
//       padding: EdgeInsets.zero,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11), side: BorderSide.none),
//       textStyle: const TextStyle(
//         color: Colors.white,
//         fontSize: 15,
//         fontFamily: 'Mont',
//         fontWeight: FontWeight.w800,
//       ),
//     ),
//   ),
//   iconButtonTheme: IconButtonThemeData(
//     style: IconButton.styleFrom(
//       //backgroundColor: AppColors.dark.buttonPrimary,
//       foregroundColor: AppColors.dark.background,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       fixedSize: const Size(60, 55),
//       iconSize: 35,
//     ),
//   ),
//   textButtonTheme: TextButtonThemeData(
//     style: TextButton.styleFrom(
//       backgroundColor: AppColors.dark.buttonPrimary,
//       foregroundColor: AppColors.dark.background,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     ),
//   ),
// );
