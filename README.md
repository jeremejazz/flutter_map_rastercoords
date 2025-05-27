# flutter_map_rastercoords

A [flutter_map](https://pub.dev/packages/flutter_map) plugin for plain image map projection to display large images using tiles generated with [gdal2tiles](https://gdal.org/en/stable/programs/gdal2tiles.html).

Inspired from [leaflet-rastercoords](https://github.com/commenthol/leaflet-rastercoords).

## Features
- Provides utilities to convert between pixel coordinates and LatLng.
- Helper method to set up flutter_map option such as `getMaxBounds`


## Usage

1. Add `flutter_map_rastercoords` to your `pubspec.yaml`:
   ```yaml
   dependencies:
     flutter_map_rastercoords: ^0.0.1
   ```
2. Create `RasterCoords` instance:
    ```dart
      final rc = RasterCoords(width: 1280, height: 1280);
    ```

3. On your  `FlutterMap`:
   ```dart
   Widget build(BuildContext context) {
     return FlutterMap(
          options: MapOptions(
          // for non-geographical maps
          crs: CrsSimple(),
          // initialize with map on center
          initialCenter: rc.pixelToLatLng(x: 1280 / 2, y: 1280 / 2), 
          // optimal zoom
          maxZoom: rc.zoom,
          minZoom: 1,
          initialZoom: 1,
            // set max bounds 
            cameraConstraint: CameraConstraint.containCenter(
              bounds: rc.getMaxBounds(),
            ),
          ),
       children: [
         TileLayer(
           urlTemplate: 'http://localhost:8000/map_tiles/{z}/{x}/{y}.png',
         ),
       ],
     );
   }
   ```
