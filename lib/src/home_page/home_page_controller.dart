import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePageController {
  defineBottomPadding(BuildContext context) {
    if (MediaQuery.of(context).size.aspectRatio <= 0.5) {
      return MediaQuery.of(context).size.height * .08;
    } else {
      return MediaQuery.of(context).size.height * .13;
    }
  }

  double contentWidth(BuildContext context) {
    final double mediaHeight = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;
    return mediaHeight;
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double minLat = list.first.latitude;
    double maxLat = list.first.latitude;
    double minLng = list.first.longitude;
    double maxLng = list.first.longitude;

    for (LatLng latLng in list) {
      if (latLng.latitude < minLat) {
        minLat = latLng.latitude;
      }
      if (latLng.latitude > maxLat) {
        maxLat = latLng.latitude;
      }
      if (latLng.longitude < minLng) {
        minLng = latLng.longitude;
      }
      if (latLng.longitude > maxLng) {
        maxLng = latLng.longitude;
      }
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }
}
