import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'dart:io' show Platform;
import 'package:flutter_map_rastercoords/flutter_map_rastercoords.dart';

void main() {
  runApp(FlutterMapApp());
}

class FlutterMapApp extends StatelessWidget {
  FlutterMapApp({super.key});

  final rc = RasterCoords(width: 1280, height: 1280);

  final String _defaultMapUrl =
      "http://localhost:8000/map_tiles/{z}/{x}/{y}.png";
  final String _androidMapUrl =
      "http://10.0.2.2:8000/map_tiles/{z}/{x}/{y}.png";

  String getMapUrl() {
    if (kIsWeb) {
      return _defaultMapUrl;
    }
    if (Platform.isAndroid) {
      return _androidMapUrl;
    }

    return _defaultMapUrl;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FlutterMap(
          options: MapOptions(
            crs: CrsSimple(),
            // initialize with map on center
            initialCenter: rc.pixelToLatLng(x: 1280 / 2, y: 1280 / 2),
            maxZoom: rc.zoom,
            minZoom: 1,
            initialZoom: 1,
            //
            cameraConstraint: CameraConstraint.containCenter(
              bounds: rc.getMaxBounds(),
            ),
          ),
          children: [
            TileLayer(urlTemplate: getMapUrl()),
            MarkerLayer(
              markers: [
                // create a marker at the center of map
                Marker(
                  point: rc.pixelToLatLng(x: 1280 / 2, y: 1280 / 2),
                  width: 30,
                  height: 30,
                  child: FlutterLogo(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
