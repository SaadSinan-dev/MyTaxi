import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'map.dart';
import 'package:my_taxi/core/app_colors.dart';

enum RideType { economy, comfort, xl }

class RideOption {
  final String label;
  final String price;
  final String eta;
  final IconData icon;

  const RideOption({
    required this.label,
    required this.price,
    required this.eta,
    required this.icon,
  });
}

class LocationBody extends StatefulWidget {
  const LocationBody({super.key});

  @override
  State<LocationBody> createState() => _LocationBodyState();
}

class _LocationBodyState extends State<LocationBody> {
  LatLng? _currentPosition;
  RideType _selectedRide = RideType.economy;
  bool _isLoadingLocation = true;
  String? _locationError;

  static const Map<RideType, RideOption> _rideOptions = {
    RideType.economy: RideOption(
      label: 'Economy',
      price: '\$8.50',
      eta: '3 min',
      icon: Icons.directions_car_outlined,
    ),
    RideType.comfort: RideOption(
      label: 'Comfort',
      price: '\$12.00',
      eta: '5 min',
      icon: Icons.local_taxi_outlined,
    ),
    RideType.xl: RideOption(
      label: 'XL',
      price: '\$16.00',
      eta: '7 min',
      icon: Icons.airport_shuttle_outlined,
    ),
  };

  @override
  void initState() {
    super.initState();
    _fetchUserLocation();
  }

  Future<void> _fetchUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (mounted) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
          _isLoadingLocation = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _locationError = e.toString();
          _isLoadingLocation = false;
        });
      }
    }
  }

  void _onRideSelected(RideType type) {
    setState(() => _selectedRide = type);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingLocation) {
      return const _MapSkeletonLoader();
    }

    if (_locationError != null) {
      return _LocationErrorView(
        error: _locationError!,
        onRetry: () {
          setState(() {
            _locationError = null;
            _isLoadingLocation = true;
          });
          _fetchUserLocation();
        },
      );
    }

    return Stack(
      children: [
        // ✅ Neutral background prevents black flash while tiles load
        Container(color: const Color(0xFFE8E0D5)),

        Positioned.fill(
          child: MapView(position: _currentPosition!),
        ),

        Positioned(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).padding.bottom + 16,
          child: _GlassBottomSheetUI(
            selectedRide: _selectedRide,
            rideOptions: _rideOptions,
            onRideSelected: _onRideSelected,
            selectedOptionData: _rideOptions[_selectedRide]!,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// SKELETON LOADER — mimics the real screen layout
// ─────────────────────────────────────────────
class _MapSkeletonLoader extends StatefulWidget {
  const _MapSkeletonLoader();

  @override
  State<_MapSkeletonLoader> createState() => _MapSkeletonLoaderState();
}

class _MapSkeletonLoaderState extends State<_MapSkeletonLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _shimmer;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();

    _shimmer = Tween<double>(begin: -1.5, end: 2.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );

    _pulse = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E0D5),
      body: Stack(
        children: [
          // ── Map skeleton tiles with shimmer sweep ──────────
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _shimmer,
              builder: (_, __) => CustomPaint(
                painter: _MapTilePainter(shimmerProgress: _shimmer.value),
              ),
            ),
          ),

          // ── Pulsing location pin in center ─────────────────
          Center(
            child: AnimatedBuilder(
              animation: _pulse,
              builder: (_, child) => Opacity(
                opacity: _pulse.value,
                child: child,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.35),
                          blurRadius: 20,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.my_location,
                        color: Colors.white, size: 22),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: const Text(
                      'Finding your location…',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF555555),
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Bottom sheet skeleton ───────────────────────────
          Positioned(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).padding.bottom + 16,
            child: _BottomSheetSkeleton(shimmer: _shimmer),
          ),
        ],
      ),
    );
  }
}

// Paints subtle map-like tiles + shimmer sweep + faint road lines
class _MapTilePainter extends CustomPainter {
  final double shimmerProgress;
  _MapTilePainter({required this.shimmerProgress});

  @override
  void paint(Canvas canvas, Size size) {
    const tileSize = 90.0;
    final basePaint = Paint();

    final colors = [
      const Color(0xFFE2D9CE),
      const Color(0xFFDDD3C8),
      const Color(0xFFE8DFD4),
      const Color(0xFFD8D0C4),
    ];

    int row = 0;
    for (double y = 0; y < size.height; y += tileSize) {
      int col = 0;
      for (double x = 0; x < size.width; x += tileSize) {
        basePaint.color = colors[(row + col) % colors.length];
        canvas.drawRect(
          Rect.fromLTWH(x, y, tileSize - 0.5, tileSize - 0.5),
          basePaint,
        );
        col++;
      }
      row++;
    }

    // Shimmer sweep
    final shimmerX = shimmerProgress * size.width;
    final shimmerPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withOpacity(0),
          Colors.white.withOpacity(0.18),
          Colors.white.withOpacity(0),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(shimmerX - 120, 0, 240, size.height));
    canvas.drawRect(
      Rect.fromLTWH(shimmerX - 120, 0, 240, size.height),
      shimmerPaint,
    );

    // Faint road lines
    final roadPaint = Paint()
      ..color = const Color(0xFFF5EFE8)
      ..strokeWidth = 3;
    for (double y = tileSize * 2; y < size.height; y += tileSize * 3) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), roadPaint);
    }
    for (double x = tileSize * 2; x < size.width; x += tileSize * 3) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), roadPaint);
    }
  }

  @override
  bool shouldRepaint(_MapTilePainter old) =>
      old.shimmerProgress != shimmerProgress;
}

// Bottom panel skeleton with shimmer boxes
class _BottomSheetSkeleton extends StatelessWidget {
  final Animation<double> shimmer;
  const _BottomSheetSkeleton({required this.shimmer});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 3 ride-card skeletons
              Row(
                children: List.generate(3, (i) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: i < 2 ? 10.0 : 0),
                      child: _ShimmerBox(
                          shimmer: shimmer, height: 80, radius: 16),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              _ShimmerBox(shimmer: shimmer, height: 52, radius: 12),
              const SizedBox(height: 10),
              _ShimmerBox(shimmer: shimmer, height: 52, radius: 12),
              const SizedBox(height: 20),
              _ShimmerBox(shimmer: shimmer, height: 52, radius: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final Animation<double> shimmer;
  final double height;
  final double radius;

  const _ShimmerBox({
    required this.shimmer,
    required this.height,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shimmer,
      builder: (context, _) {
        final t = shimmer.value; // ranges -1.5 → 2.5
        final normalized = ((t + 1.5) / 4.0).clamp(0.0, 1.0);
        return Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: LinearGradient(
              colors: const [
                Color(0xFFEAE4DC),
                Color(0xFFF5F0EA),
                Color(0xFFEAE4DC),
              ],
              stops: [
                math.max(0.0, normalized - 0.3),
                normalized.clamp(0.0, 1.0),
                math.min(1.0, normalized + 0.3),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// ERROR VIEW — clean retry screen
// ─────────────────────────────────────────────
class _LocationErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _LocationErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E0D5),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: const Icon(Icons.location_off_outlined,
                    color: Colors.redAccent, size: 28),
              ),
              const SizedBox(height: 16),
              const Text(
                'Location unavailable',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF222222),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error.replaceAll('Exception: ', ''),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF888888),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Try again'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// MAIN UI — unchanged
// ─────────────────────────────────────────────
class _GlassBottomSheetUI extends StatelessWidget {
  final RideType selectedRide;
  final Map<RideType, RideOption> rideOptions;
  final ValueChanged<RideType> onRideSelected;
  final RideOption selectedOptionData;

  const _GlassBottomSheetUI({
    required this.selectedRide,
    required this.rideOptions,
    required this.onRideSelected,
    required this.selectedOptionData,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _RideSelectionCards(
                selectedRide: selectedRide,
                rideOptions: rideOptions,
                onRideSelected: onRideSelected,
              ),
              const SizedBox(height: 20),
              const _LocationInputForm(),
              const SizedBox(height: 20),
              _BookingButton(selectedOption: selectedOptionData),
            ],
          ),
        ),
      ),
    );
  }
}

class _RideSelectionCards extends StatelessWidget {
  final RideType selectedRide;
  final Map<RideType, RideOption> rideOptions;
  final ValueChanged<RideType> onRideSelected;

  const _RideSelectionCards({
    required this.selectedRide,
    required this.rideOptions,
    required this.onRideSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: RideType.values.map((type) {
        final option = rideOptions[type]!;
        final isSelected = type == selectedRide;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: type != RideType.xl ? 10.0 : 0),
            child: GestureDetector(
              onTap: () => onRideSelected(type),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? AppColors.primaryLight : Colors.black12,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(option.icon,
                        color: isSelected ? Colors.white : Colors.black87,
                        size: 24),
                    const SizedBox(height: 4),
                    Text(option.label,
                        style: TextStyle(
                            fontSize: 11,
                            color:
                                isSelected ? Colors.white70 : Colors.black54)),
                    Text(option.price,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black)),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _LocationInputForm extends StatelessWidget {
  const _LocationInputForm();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _BookingButton extends StatelessWidget {
  final RideOption selectedOption;
  const _BookingButton({required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 0,
        ),
        child: Text('Confirm ${selectedOption.label}'),
      ),
    );
  }
}