import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gym_pro/config/di/app_injection.dart';
import 'package:gym_pro/config/localisation/app_localisation.dart';
import 'package:gym_pro/config/router/router.dart';
import 'package:gym_pro/config/style/theme.dart';
import 'package:gym_pro/presentation/bloc/app_settings/app_settings_cubit.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector().setServices();
  runApp(BlocProvider(create: (context) => AppSettingsCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        return KeyboardDismisser(
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            title: 'Gym Pro',
            locale: Locale(state.locale),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizations.delegate,
            ],
            themeAnimationCurve: Curves.slowMiddle,
            supportedLocales: const [
              Locale.fromSubtags(languageCode: 'uz'),
              Locale.fromSubtags(languageCode: 'ru'),
              Locale.fromSubtags(languageCode: 'en'),
            ],
            theme: appLightTheme,
            themeMode: ThemeMode.light,
          ),
        );
      },
    );
  }
}
