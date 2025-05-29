# flutter_map_rastercoords

A [flutter_map](https://pub.dev/packages/flutter_map) plugin for displaying large, non-geographical images as tiled maps using a simple coordinate reference system. Tiles should be generated using [gdal2tiles](https://gdal.org/en/stable/programs/gdal2tiles.html) with the `--xyz` and `-p raster` options.

Inspired from [leaflet-rastercoords](https://github.com/commenthol/leaflet-rastercoords).

## Features
- Provides utilities to convert between pixel coordinates and LatLng.
- Helper utilities for `flutter_map` setup, including:
  - `getMaxBounds()` for constraining the map view.
  - `zoom` property that returns the optimal zoom level based on image dimensions.


## Usage

1. Generate map tiles from your "large" image using [gdal2tiles.py](https://gdal.org/en/stable/programs/gdal2tiles.html)
    ```sh
    gdal2tiles.py --xyz -p raster -z 0-3 -w none <image> <tiles dir>
    ```
2. Serve the generated tiles locally, for example using [serve](https://www.npmjs.com/package/serve) 
    ```
    serve -l 8000
    ```

3. Add `flutter_map_rastercoords` to your `pubspec.yaml`:
   ```yaml
   dependencies:
     flutter_map_rastercoords: ^0.0.1
   ```
4. Create a `RasterCoords` instance:
    ```dart
      final rc = RasterCoords(width: 1280, height: 1280);
    ```

5. Use it in your `FlutterMap`:
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
           // URL template for your locally hosted tiles
           urlTemplate: 'http://localhost:8000/map_tiles/{z}/{x}/{y}.png',
         ),
       ],
     );
   }
   ```
