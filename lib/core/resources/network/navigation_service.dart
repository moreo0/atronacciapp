import 'package:univs/core/routes/router_import.dart';
import 'package:univs/core/routes/router_import.gr.dart';

class NavigationService {
  late final AppRouter router;

  NavigationService() {
    router = AppRouter();
  }

  void navigateToLogin() {
    router.replace(const LoginRoute());
  }

  void pop() {
    // ignore: deprecated_member_use
    router.pop();
  }
}
