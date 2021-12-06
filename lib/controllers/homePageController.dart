import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomePageController extends GetxController
    with SingleGetTickerProviderMixin {
  // final _polygonPoints = Rx<List<LatLng>>([
  //   // LatLng(-6.91862726258146, 107.65024121850729),
  //   // LatLng(-6.9185443867279135, 107.65018053352833),
  // ]);
  final _markers = Rx<Set<Marker>>({});
  Set<Marker> get markers => _markers.value;
  final _polyPoins = Rx<List<LatLng>>([]);
  List<LatLng> get polyPoins => _polyPoins.value;
  final _polygon = Rx<Set<Polygon>>({});
  Set<Polygon> get polygon => _polygon.value;

  final _testing = Rx<String>('okecoy');
  String get testing => _testing.value;

  //animasi button
  final _isOpened = Rx<bool>(false);
  bool get isOpened => _isOpened.value;
  set isOpened(val) => _isOpened.value = val;
  AnimationController animationController;
  Animation<Color> animateColor;
  Animation<Color> animateColorIcon;
  Animation<double> animateIcon;
  Animation<double> translateButton;
  Curve _curve = Curves.easeOut;
  final _fabHeight = Rx<double>(56.0);
  double get fabHeight => _fabHeight.value;
  set fabHeight(val) => _fabHeight.value = val;

  //map
  final _isGps = Rx<bool>(true);
  bool get isGps => _isGps.value;
  set isGps(val) => _isGps.value = val; 
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  final _currentLocation = Rx<LocationData>(null);
  LocationData get currentLocation => _currentLocation.value;
  final _latNow = Rx<double>(0.0);
  double get latNow => _latNow.value;
  final _longNow = Rx<double>(0.0);
  double get longNow => _longNow.value;
  final _latManual = Rx<double>(0.0);
  double get latManual => _latManual.value;
  set latManual(val) => _latManual.value = val;
  final _longManual = Rx<double>(0.0);
  double get longManual => _longManual.value;
  set longManual(val) => _longManual.value = val;
  StreamSubscription<LocationData> _locationSubscription;

  @override
  void onInit() async {
    super.onInit();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    animateColor = ColorTween(
      begin: Colors.lightBlue.shade600,
      end: Colors.white,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));
    animateColorIcon = ColorTween(
      begin: Colors.white,
      end: Colors.black,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));
    translateButton = Tween<double>(
      begin: fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));

    //location
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationSubscription = location.onLocationChanged.listen((LocationData currentLocation) {
      _currentLocation.value = currentLocation;
      _latNow.value = currentLocation.latitude;
      _longNow.value = currentLocation.longitude;
      print("tes");
      update();
    });
  }

  @override
  void onReady() {
    print('onReady');
    super.onReady();
  }

  @override
  void update([List<Object> ids, bool condition = true]) {
    print('polyline ' + _polyPoins.value.length.toString());
    print('marker' + _markers.value.length.toString());
    super.update(ids, condition);
  }

  @override
  void onClose() {
    print('onClose');
    super.onClose();
  }

  @override
  void dispose() {
    print('dispose');
    _locationSubscription.cancel();
    animationController.dispose();
    super.dispose();
  }

  void undoPolygon() {
    if(_polyPoins.value.length > 1){
      print(_polyPoins.value.last.toString());
      _markers.value.removeWhere((element) => element.markerId == MarkerId(_polyPoins.value.last.toString()));
      _polyPoins.value.removeLast();
    _drawPolygon(_polyPoins.value);
      print("habis");
    }else if(_polyPoins.value.isEmpty){
        Get.snackbar("hi", "sudah habis");
    }
    else{
      _polyPoins.value.removeLast();
      _drawPolygon(_polyPoins.value);
      _markers.value = {};
    }
    update();
  }

  void addPolygon(lat, long) {
    if (_polyPoins.value.contains(LatLng(lat, long))) {
      Get.snackbar("title", 'Pindah ke titik selanjutnya');
    } else {
      _polyPoins.value.add(LatLng(lat, long));
      _drawPolygon(_polyPoins.value);
      _markers.value.add(
        Marker(
          draggable: false,
          markerId: MarkerId(LatLng(lat, long).toString()),
          position: LatLng(lat, long),
          icon: BitmapDescriptor.defaultMarkerWithHue(0.5),
          onDragEnd: (LatLng latLng) {
            print(latLng);
            print(latLng.toString());
          },
        ),
      );
    }
    update();
    // _polygon.value.add(Polygon(
    //       polygonId: PolygonId('123'),
    //       points: polyline,
    //       fillColor: Colors.transparent,
    //       strokeColor: Colors.greenAccent),
    //       );
  }

  void _drawPolygon(polyPoints) {
    _polygon.value.add(
      Polygon(
          polygonId: PolygonId('123'),
          points: polyPoints,
          fillColor: Colors.red.withOpacity(0.5),
          strokeColor: Colors.blue.withOpacity(0.5),
          strokeWidth: 3,
          geodesic: true,
          ),
          
    );
    update();
  }
}
