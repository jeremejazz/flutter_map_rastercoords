import 'dart:math' show log, Point, max;
import 'package:flutter_map/flutter_map.dart' show CrsSimple, LatLngBounds;
import 'package:latlong2/latlong.dart' show LatLng;

/// Utility class for projecting raster image coordinates onto a map
/// and vice-versa within a [FlutterMap] context.
///
/// This class helps in converting pixel coordinates of an image to geographical
/// latitude/longitude coordinates and back, considering a specific tile size
/// and the image's dimensions.
class RasterCoords {
  static const CrsSimple _crsSimple = CrsSimple();

  /// The scale factor used to convert map coordinates to pixel coordinates,
  /// derived from the calculated [zoom] level.
  final double scale;

  /// Width of the image in pixels.
  final double width;

  /// Height of the image in pixels.
  final double height;

  /// Size of the tile used in the map. Defaults to 256 pixels.
  final double tileSize;

  /// calculated zoom level based on the image [height] and [width] dimensions.
  final double zoom;

  /// Creates a [RasterCoords] instance.
  ///
  /// Requires the image [width] and [height] in pixels.
  /// The [tileSize] parameter defaults to 256 if not provided.
  RasterCoords({required this.width, required this.height, this.tileSize = 256})
      : zoom = _calculateZoomLevel(width, height, tileSize),
        scale = _calculateScale(_calculateZoomLevel(width, height, tileSize));

  /// Computes the scale based on the [zoom] level,
  static double _calculateScale(
    double zoom,
  ) {
    return _crsSimple.scale(zoom).ceil().toDouble();
  }

  /// Computes the [zoom] level based on the image [width], [height],
  /// and [tileSize].
  static double _calculateZoomLevel(
      double width, double height, double tileSize) {
    return (log(max(width, height) / tileSize) / log(2)).ceil().toDouble();
  }

  /// Converts pixel to [LatLng] based on the [x] and [y] coordinates
  /// of the raster image
  ///
  /// returns latitude and longitude
  LatLng pixelToLatLng({required double x, required double y}) {
    final (double lat, double lng) = _crsSimple.untransform(-y, -x, scale);

    return LatLng(lat, lng);
  }

  /// Converts geographical [LatLng] coordinates to pixel [Point] coordinates
  /// (relative to the top-left of the raster image).
  ///
  /// returns a [Point] object with x and y coordinates
  /// of the pixel
  Point<double> latLngToPixel(LatLng latLng) {
    final (lat, lng) = (latLng.latitude, latLng.longitude);
    final (double x, double y) = _crsSimple.transform(lng, lat, scale);

    return Point<double>(x, y);
  }

  /// Gets the geographical bounding box ([LatLngBounds]) that encompasses
  /// the entire raster image.
  LatLngBounds getMaxBounds() {
    final southWest = pixelToLatLng(x: 0, y: height);
    final northEast = pixelToLatLng(x: width, y: 0);

    return LatLngBounds(southWest, northEast);
  }
}
