import '../screens/home_page.dart';
import '../screens/gps_page.dart';

class AppRoutes {
  static const String home = '/home';
  static const String gps = '/gps';

  static final routes = {
    home: (context) => const HomePage(),
    gps: (context) => const GpsPage(),
  };
}
