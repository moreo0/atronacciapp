part of 'router_import.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoginRoute.page,
          initial: true,
        ),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: EditProfileRoute.page),
        AutoRoute(page: LihatPostinganRoute.page),
        AutoRoute(page: SetReminderRoute.page),
        AutoRoute(page: CreateSetReminderRoute.page),
        AutoRoute(page: QuizDetailRoute.page),
        AutoRoute(page: QuizSoalRoute.page),
        AutoRoute(page: QuizNilaiRoute.page),
        AutoRoute(page: QuizCreateRoute.page),
        AutoRoute(page: ChatAIRoute.page),
        AutoRoute(page: EmailVerifRoute.page),
        AutoRoute(page: ChangePasswordRoute.page),

        // For Bottom Nav Bar
        AutoRoute(
          page: MainRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: QuizRoute.page),
            AutoRoute(page: NotificationRoute.page),
            AutoRoute(page: SearchRoute.page),
            AutoRoute(page: CreatePostingRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ],
        )
      ];
}

class RouterObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    log('/ Push Route: ${route.settings.name}',
        time: DateTime.now(), name: "Route");
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    log('/ Pop Route: ${route.settings.name}',
        time: DateTime.now(), name: "Route");
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    log('/ Remove Route: ${route.settings.name}',
        time: DateTime.now(), name: "Route");
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    log('/ Replace Route: ${newRoute?.settings.name}',
        time: DateTime.now(), name: "Route");
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    log('/ User Gesture: ${route.settings.name}',
        time: DateTime.now(), name: "Route");
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    log('/ User Gesture Stopped', time: DateTime.now(), name: "Route");
    super.didStopUserGesture();
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    log('/ Route Visited: ${route.name}', name: "Route");
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    log('/ Route Re-visited: ${route.name}', name: "Route");
  }
}
