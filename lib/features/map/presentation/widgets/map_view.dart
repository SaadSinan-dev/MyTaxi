import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_taxi/core/colors/app_colors.dart';

class MapView extends StatelessWidget {
  final LatLng position;

  const MapView({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: position,
        initialZoom: 15,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.my_taxi', // ← أضف هذا
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: position,
              width: 48,
              height: 48,
              child: const Icon(
                Icons.location_pin,
                color: AppColors.primary,
                size: 48,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
