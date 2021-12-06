import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/appPage.dart';
import 'package:get/get.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      title: 'Flutter Google Maps Demo',
      getPages: AppPage.pages,
    );
  }
}
