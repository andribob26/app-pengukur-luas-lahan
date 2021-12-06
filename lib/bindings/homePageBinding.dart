import 'package:flutter_application_1/controllers/homePageController.dart';
import 'package:get/get.dart';

class HomePageBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(HomePageController());
  }
}