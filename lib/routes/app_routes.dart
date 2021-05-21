import 'package:get/route_manager.dart';
import 'package:pexpenses/pages/home_page/home_binding.dart';
import 'package:pexpenses/pages/home_page/home_page.dart';

class AppRoutes {
  static const HOME = '/home';

  static final routes = [
    GetPage(name: HOME, page: () => HomePage(), binding: HomeBinding())
  ];
}
