import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_taxi/core/app_colors.dart';
import 'package:my_taxi/core/constants.dart';

class MapView extends StatefulWidget {
  final LatLng position;

  const MapView({
    super.key,
    required this.position,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  bool _mapReady = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ✅ Placeholder يظهر حتى تتحمل الخريطة
        if (!_mapReady)
          Container(
            color: const Color(0xFFE8E0D5), // لون قريب من لون الخريطة
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          ),

        // الخريطة
        AnimatedOpacity(
          opacity: _mapReady ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 400),
          child: FlutterMap(
            options: MapOptions(
              initialCenter: widget.position,
              initialZoom: 16,
              onMapReady: () {
                // ✅ يُشغَّل حين تكون الخريطة جاهزة هيكلياً
                if (mounted) setState(() => _mapReady = true);
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=${AppConstants.mapKey}',
                userAgentPackageName: 'com.example.my_taxi',
                tileDisplay: const TileDisplay.fadeIn(
                  duration: Duration(milliseconds: 500),
                ),
                // ✅ fallback إذا فشل تحميل أي tile
                errorTileCallback: (tile, error, stackTrace) {
                  debugPrint('Tile error: $error');
                },
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: widget.position,
                    width: 50,
                    height: 50,
                    child: const Icon(
                      Icons.location_pin,
                      size: 45,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}