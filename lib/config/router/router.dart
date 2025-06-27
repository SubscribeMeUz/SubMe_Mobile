import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_pro/components/success_page.dart';
import 'package:gym_pro/config/di/app_injection.dart';
import 'package:gym_pro/config/router/route_name.dart';
import 'package:gym_pro/presentation/bloc/abonements/abonement_bloc.dart';
import 'package:gym_pro/presentation/bloc/auth/auth_bloc.dart';
import 'package:gym_pro/presentation/bloc/subscriptions/subscription_bloc.dart';
import 'package:gym_pro/presentation/pages/add_subscription/subscription_catalog_page.dart';
import 'package:gym_pro/presentation/pages/auth/confirm_number_page.dart';
import 'package:gym_pro/presentation/pages/auth/enter_phone_page.dart';
import 'package:gym_pro/presentation/pages/auth/welcome_page.dart';
import 'package:gym_pro/presentation/pages/category/abonements_page.dart';
import 'package:gym_pro/presentation/pages/category/my_abonements_page.dart';
import 'package:gym_pro/presentation/pages/category/provider_list_page.dart';
import 'package:gym_pro/presentation/pages/category/subscription_detail_page.dart';
import 'package:gym_pro/presentation/pages/home/home_page.dart';
import 'package:gym_pro/presentation/pages/main/main_page.dart';
import 'package:gym_pro/presentation/pages/profile/profile_page.dart';
import 'package:gym_pro/presentation/pages/splash_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final subcriptionDetailPage = GoRoute(
    path: 'subscription_detail_page',
    name: RouteName.subscriptionDetailPage,
    builder:
        (context, state) => BlocProvider(
          create: (_) => AbonementBloc(repository: getIt.get()),

          child: SubscriptionDetailPage(providerId: state.extra as int),
        ),
    routes: [
      GoRoute(
        path: 'abonements_page',
        name: RouteName.abonementsPage,
        builder:
            (context, state) => BlocProvider(
              create: (_) => AbonementBloc(repository: getIt.get()),
              child: AbonementsPage(providerId: state.extra as int),
            ),
      ),
    ],
  );
  static final router = GoRouter(
    initialLocation: '/splash',
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/splash',
        name: RouteName.splashRoute,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/welcome',
        name: RouteName.welcomeRoute,
        builder: (context, state) => const WelcomePage(),
        routes: [
          GoRoute(
            path: 'enter_phone',
            name: RouteName.enterPhoneRoute,
            builder:
                (context, state) => BlocProvider(
                  create: (_) => AuthBloc(repository: getIt.get()),
                  child: const EnterPhonePage(),
                ),
            routes: [
              GoRoute(
                path: '/confirm_auth',
                name: RouteName.confirmAuthRoute,
                builder:
                    (context, state) => BlocProvider(
                      create: (_) => AuthBloc(repository: getIt.get()),
                      child: ConfirmNumberPage(phoneNumber: state.extra as String),
                    ),
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: '/success_page',
        name: RouteName.successRoute,
        builder: (context, state) => SuccessPage(args: state.extra as SuccessPageArgs),
      ),
      GoRoute(
        path: '/subscription_catalog_page',
        name: RouteName.subscriptionCatalogPage,
        builder: (context, state) => SubscriptionCatalogPage(),
      ),

      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return MainPage(state: state, navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: RouteName.homeRoute,
                builder:
                    (context, state) => BlocProvider(
                      create: (_) => SubscriptionBloc(repository: getIt.get()),
                      child: HomePage(),
                    ),
                routes: [
                  subcriptionDetailPage,
                  GoRoute(
                    path: '/catalog',
                    name: RouteName.providersRoute,
                    builder:
                        (context, state) => BlocProvider(
                          create: (_) => SubscriptionBloc(repository: getIt.get()),
                          child: ProviderListPage(),
                        ),
                  ),
                  GoRoute(
                    path: '/my_subscriptions',
                    name: RouteName.mySubscriptionsRoute,
                    builder:
                        (context, state) => BlocProvider(
                          create: (_) => SubscriptionBloc(repository: getIt.get()),
                          child: MySubscriptionsPage(),
                        ),
                    // routes: [subcriptionDetailPage],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: '/home1', builder: (context, state) => Container())],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home2',
                // name: RouteName.homeRoute,
                builder: (context, state) => Container(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                name: RouteName.profileRoute,
                builder: (context, state) => ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
