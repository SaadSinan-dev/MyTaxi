import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_taxi/core/colors/app_colors.dart';
import 'package:my_taxi/features/map/presentation/widgets/draggablebottom/models/step_content.dart';
import 'package:my_taxi/features/map/presentation/widgets/draggablebottom/models/step_indicator.dart';
import 'package:my_taxi/features/map/presentation/widgets/order_now_bar.dart';

import '../../cubit/map_state.dart';

class DraggableBottomSheet extends StatelessWidget {
  final int currentStep;
  final RideType selectedRide;
  final ValueChanged<RideType> onRideSelected;
  final VoidCallback onNextStep;
  final VoidCallback onConfirm;
  final ScrollController scrollController;

  const DraggableBottomSheet({
    super.key,
    required this.currentStep,
    required this.selectedRide,
    required this.onRideSelected,
    required this.onNextStep,
    required this.onConfirm,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.92),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
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
              OrderNowButton(onTap: onNextStep),
              const SizedBox(height: 20),
              StepIndicator(currentStep: currentStep),
              const SizedBox(height: 20),
              StepContent(
                currentStep: currentStep,
                selectedRide: selectedRide,
                onRideSelected: onRideSelected,
                onNextStep: onNextStep,
                onConfirm: onConfirm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
