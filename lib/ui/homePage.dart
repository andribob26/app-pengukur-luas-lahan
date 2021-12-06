import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/homePageController.dart';
import 'package:flutter_application_1/ui/widget/popListTileWidget.dart';
import 'package:flutter_application_1/utils/hitungMap.dart';
import 'package:flutter_application_1/utils/routeName.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatelessWidget {
  final HomePageController homeC = Get.find();
  final HitungMap hitungMap = HitungMap();

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pengukur Luas Lahan",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          color: Colors.lightBlue.shade600,
          height: heightScreen -
              (MediaQuery.of(context).padding.top + kToolbarHeight),
        ),
        actions: [
          PopupMenuButton(
            elevation: 2,
            color: Colors.white,
            offset: Offset(0, 50),
            icon: Icon(
              Icons.list,
              color: Colors.white,
            ),
            // shape: TooltipShape(),
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                
                PopupMenuItem(
                    // padding: EdgeInsets.all(0),
                    child: Container(
                      width: 150,
                      child: PopListTileWidget(
                        title: 'Andri Febrian',
                        icon: Icons.person,
                        onTap: () {
                          Get.offNamed(RouteNames.loginPage);
                        },
                      ),
                    )),

                    
                PopupMenuItem(
                    // padding: EdgeInsets.all(0),
                    child: Container(
                      width: 150,
                      child: PopListTileWidget(
                        title: 'Pengukuran Tersimpan',
                        icon: Icons.local_library,
                        onTap: () {
                          Get.offNamed(RouteNames.saveMapPage);
                        },
                      ),
                    )),
                PopupMenuItem(
                    // padding: EdgeInsets.all(0),
                    child: Container(
                      width: 150,
                      child: PopListTileWidget(
                        title: 'Pengaturan',
                        icon: Icons.settings,
                        onTap: null,
                      ),
                    )),
                PopupMenuItem(
                    // padding: EdgeInsets.all(0),
                    child: Container(
                      width: 150,
                      child: PopListTileWidget(
                        title: 'Log out',
                        icon: Icons.logout,
                        onTap: null,
                      ),
                    )),
              ];
            },
          ),
        ],
        elevation: 0,
      ),
      body: Stack(
        children: [
          GetBuilder<HomePageController>(
            builder: (_) {
              return _.currentLocation == null
                  ? Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  : GoogleMap(
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      zoomControlsEnabled: true,
                      mapType: MapType.satellite,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(_.latNow, _.longNow),
                        zoom: 35.0,
                      ),
                      markers: _.markers,
                      polygons: _.polygon,
                      onCameraMove: (position) {
                        _.latManual = position.target.latitude;
                        _.longManual = position.target.longitude;
                      },
                      onTap: (LatLng) {
                        if (!_.isGps) {
                          print("manual");
                        }
                      },
                    );
            },
          ),
          Obx(() => homeC.isGps
              ? Container()
              : Align(
                  alignment: Alignment.center,
                  child: Text(
                    "+",
                    style: TextStyle(
                        fontSize: 20, color: Colors.red.withOpacity(0.9)),
                  ),
                )),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Material(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        // padding: EdgeInsetsDirectional.all(10),
                        child: Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${homeC.latNow}: ",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ],
                            )),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => homeC.isGps
                    ? FloatingActionButton(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        mini: true,
                        child: Icon(Icons.touch_app),
                        onPressed: () {
                          if (homeC.latManual == 0.0) {
                            homeC.latManual = homeC.latNow;
                            homeC.longManual = homeC.longNow;
                          }
                          homeC.isGps = false;
                        },
                      )
                    : FloatingActionButton(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        mini: true,
                        child: Icon(Icons.timeline),
                        onPressed: () {
                          homeC.isGps = true;
                        },
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 35),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GetBuilder<HomePageController>(
                      builder: (_) {
                        return Column(
                          children: [
                            FabWidget(
                              controller: _,
                              tooltip: "Simpan",
                              height: 4.0,
                              icon: Icons.save,
                              onTap: null,
                              heroTag: 'btn5',
                            ),
                            FabWidget(
                              controller: _,
                              tooltip: "Hapus",
                              height: 3.0,
                              icon: Icons.delete,
                              onTap: null,
                              heroTag: 'btn4',
                            ),
                            FabWidget(
                              controller: _,
                              tooltip: "Undo",
                              height: 2.0,
                              icon: Icons.undo,
                              onTap: () {
                                _.undoPolygon();
                              },
                              heroTag: 'btn3',
                            ),
                            FabWidget(
                              controller: _,
                              tooltip: "Tambah Point",
                              height: 1.0,
                              icon: Icons.add_location_alt,
                              onTap: () {
                                if (_.isGps) {
                                  _.addPolygon(_.latNow, _.longNow);
                                } else {
                                  _.addPolygon(_.latManual, _.longManual);
                                }
                              },
                              heroTag: 'btn2',
                            ),
                            ToggleFabWidget(
                              controller: _,
                              toolTip: "Toggle",
                            ),
                          ],
                        );
                      },
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class ToggleFabWidget extends StatelessWidget {
  final controller;
  final String toolTip;
  const ToggleFabWidget({
    Key key,
    @required this.controller,
    @required this.toolTip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        return FloatingActionButton(
          elevation: 2,
          backgroundColor: controller.animateColor.value,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          onPressed: () {
            if (!controller.isOpened) {
              controller.animationController.forward();
            } else {
              controller.animationController.reverse();
            }
            controller.isOpened = !controller.isOpened;
          },
          tooltip: 'Toggle',
          child: AnimatedBuilder(
            builder: (context, child) {
              return AnimatedIcon(
                color: controller.animateColorIcon.value,
                icon: AnimatedIcons.menu_close,
                progress: controller.animateIcon,
              );
            },
            animation: controller.animateColorIcon,
          ),
        );
      },
      animation: controller.animateColor,
    );
  }
}

class FabWidget extends StatelessWidget {
  final controller;
  final String tooltip;
  final double height;
  final IconData icon;
  final Function onTap;
  final String heroTag;

  const FabWidget({
    Key key,
    @required this.controller,
    @required this.tooltip,
    @required this.height,
    @required this.icon,
    @required this.onTap,
    @required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        return Transform(
          transform: Matrix4.translationValues(
            0.0,
            controller.translateButton.value * height,
            0.0,
          ),
          child: FloatingActionButton(
            elevation: 0.0,
            heroTag: heroTag,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            backgroundColor: Colors.lightBlue.shade600,
            onPressed: onTap,
            tooltip: '${tooltip}',
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        );
      },
      animation: controller.translateButton,
    );
  }
}

extension Ex on double {
  String toStringAsFixedNoZero(int n) =>
      double.parse(this.toStringAsFixed(n)).toString();
}
