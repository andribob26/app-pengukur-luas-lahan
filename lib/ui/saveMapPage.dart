import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/widget/popListTileWidget.dart';
import 'package:flutter_application_1/utils/routeName.dart';
import 'package:flutter_application_1/utils/toolTipShape.dart';
import 'package:get/get.dart';

class SaveMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        excludeHeaderSemantics: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          "Pengukur Luas Lahan",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).padding.top + kToolbarHeight),
          child: Text("okecoy"),
        ),
        actions: [
          PopupMenuButton(
            elevation: 3,
            color: Colors.white,
            offset: Offset(0, 50),
            icon: Icon(
              Icons.list,
              color: Colors.black,
            ),
            shape: TooltipShape(),
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                    // padding: EdgeInsets.all(0),
                    child: PopListTileWidget(
                      title: 'Andri Febrian',
                      icon: Icons.person,
                      onTap: () {
                        Get.offNamed(RouteNames.loginPage);
                      },
                    )),
                PopupMenuItem(
                    // padding: EdgeInsets.all(0),
                    child: PopListTileWidget(
                      title: 'Pengukuran Tersimpan',
                      icon: Icons.local_library,
                      onTap: () {
                        Get.offNamed(RouteNames.saveMapPage);
                      },
                    )),
                PopupMenuItem(
                    // padding: EdgeInsets.all(0),
                    child: PopListTileWidget(
                      title: 'Pengaturan',
                      icon: Icons.settings,
                      onTap: null,
                    )),
                PopupMenuItem(
                    // padding: EdgeInsets.all(0),
                    child: PopListTileWidget(
                      title: 'Log out',
                      icon: Icons.logout,
                      onTap: null,
                    )),
              ];
            },
          ),
        ],
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Material(
                borderRadius: BorderRadius.circular(5),
                elevation: 3,
                color: Colors.white,
                child: ListTile(
                  title: Text("data"),
                ),
              ),
            );
          }),
    );
  }
}
