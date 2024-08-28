import 'package:go_router/go_router.dart';
import 'package:todo/screens/home/presentation/screen_home.dart';

class RouterPaths {
  static const String home = ScreenHome.routeName;

}

final List<GoRoute> routes = [
  GoRoute(
    path: ScreenHome.routeName,
    builder: (context, state) => const ScreenHome(),
    routes: []
  ),
];
