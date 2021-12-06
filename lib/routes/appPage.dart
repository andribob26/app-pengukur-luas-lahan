
import 'package:flutter_application_1/bindings/homePageBinding.dart';
import 'package:flutter_application_1/ui/homePage.dart';
import 'package:flutter_application_1/ui/loginPage.dart';
import 'package:flutter_application_1/ui/saveMapPage.dart';
import 'package:flutter_application_1/utils/routeName.dart';
import 'package:get/get.dart';

class AppPage {
  static final pages = [
    GetPage(
      name: RouteNames.homePage,
      page: () => HomePage(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: RouteNames.loginPage,
      page: () => LoginPage(),
      // binding: HitungLuasBinding(),
    ),
    GetPage(
      name: RouteNames.saveMapPage,
      page: () => SaveMapPage(),
      // binding: HitungLuasBinding(),
    ),
  ];
}
