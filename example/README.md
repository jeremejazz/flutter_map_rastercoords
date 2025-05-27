# Example Implementation of flutter_map_rastercoords

Demonstration of how to use the rastercoords plugin.

## Sample Local Map Server

Requirements
- gdal2tiles

1. Create Image Tiles
```sh
cd images
gdal2tiles --xyz -p raster -w none -z 0-3 treasure-map-1904523_1280.jpg map_tiles/
```
2. Start Server (example using [serve](https://www.npmjs.com/package/serve))
```sh
# --cors only aplicable for web builds
serve -p 8000 --cors .
```


