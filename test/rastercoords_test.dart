


import 'package:flutter_map_rastercoords/flutter_map_rastercoords.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

void main(){

  test("Should Get the zoom level", (){
    var rc = RasterCoords(width: 1024, height: 1024);
    expect(rc.zoom, 2.0);

  });

  test("Lat/Lng to Pixel Coordinates", (){
    var rc = RasterCoords(width: 1280, height: 1280);
    final pixelCoords =  rc.latLngToPixel(LatLng(-0.338867,0.28125));
    expect(pixelCoords.x.round(), 576.0);
    expect(pixelCoords.y.round(), 694.0);

    final pixelCoords2 =  rc.latLngToPixel(LatLng(-0.288086,0.140625));
    expect(pixelCoords2.x.round(), 288.0);
    expect(pixelCoords2.y.round(), 590.0);
  });

  test("Pixel Coordinates to Lat/Lng", (){
    var rc = RasterCoords(width: 1280, height: 1280);

    final latLng =  rc.pixelToLatLng(x: 608.0, y: 686.0);
    expect(latLng.latitude.toStringAsFixed(5) , (-0.334961).toStringAsFixed(5));
    expect(latLng.longitude.toStringAsFixed(5), 0.296875.toStringAsFixed(5));

  });


}