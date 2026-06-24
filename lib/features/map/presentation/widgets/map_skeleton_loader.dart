import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:my_taxi/core/colors/app_colors.dart';

class MapSkeletonLoader extends StatefulWidget {
  const MapSkeletonLoader({super.key});

  @override
  State<MapSkeletonLoader> createState() => _MapSkeletonLoaderState();
}

class _MapSkeletonLoaderState extends State<MapSkeletonLoader>
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
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _shimmer,
              builder: (_, __) => CustomPaint(
                painter: _MapTilePainter(shimmerProgress: _shimmer.value),
              ),
            ),
          ),
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
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _BottomSheetSkeleton(shimmer: _shimmer),
          ),
        ],
      ),
    );
  }
}

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

    final shimmerX = shimmerProgress * size.width;
    final shimmerPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withOpacity(0),
          Colors.white.withOpacity(0.18),
          Colors.white.withOpacity(0),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(
        Rect.fromLTWH(shimmerX - 120, 0, 240, size.height),
      );
    canvas.drawRect(
      Rect.fromLTWH(shimmerX - 120, 0, 240, size.height),
      shimmerPaint,
    );

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

class _BottomSheetSkeleton extends StatelessWidget {
  final Animation<double> shimmer;
  const _BottomSheetSkeleton({required this.shimmer});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            _ShimmerBox(shimmer: shimmer, height: 56, radius: 20),
          ],
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
        final t = shimmer.value;
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
