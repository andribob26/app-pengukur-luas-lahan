import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class HitungMap {
  final _radiusBumi = 6371009.0;

  double kalkulasiArea(List<LatLng> patch) {
    final radius = this._radiusBumi;
    final prev = patch.last;
    var prevTanLat = tan((pi / 2 - _toRadians(prev.latitude)) / 2);
    var prevLng = _toRadians(prev.longitude);

    final total = patch.fold(0.0, (val, point){
      final tanLat = tan((pi / 2 - _toRadians(point.latitude)) / 2);
      final lng = _toRadians(point.longitude);

      val += _triangleArea(tanLat, lng, prevTanLat, prevLng);
      
      prevTanLat = tanLat;
      prevLng = lng;

      return val;
    });
    return total * (radius * radius);
  }

  static _toRadians(num degrees) {
    return degrees / 180.0 * pi;
  }

  static _triangleArea(num tan1, num lng1, num tan2, num lng2) {
    final deltaLng = lng1 - lng2;
    final t = tan1 * tan2;
    return 2 * atan2(t * sin(deltaLng), 1 + t * cos(deltaLng));
  }
}
