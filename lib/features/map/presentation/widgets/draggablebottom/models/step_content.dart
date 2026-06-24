import 'package:flutter/material.dart';
import 'package:my_taxi/core/colors/app_colors.dart';
import 'package:my_taxi/features/map/presentation/cubit/map_state.dart';
import 'package:my_taxi/features/map/presentation/widgets/draggablebottom/models/location_field.dart';
import 'package:my_taxi/features/map/presentation/widgets/draggablebottom/models/next_button.dart';
import 'package:my_taxi/features/map/presentation/widgets/draggablebottom/models/ride_selection_cards.dart';

class StepContent extends StatelessWidget {
  final int currentStep;
  final RideType selectedRide;
  final ValueChanged<RideType> onRideSelected;
  final VoidCallback onNextStep;
  final VoidCallback onConfirm;

  const StepContent({
    super.key,
    required this.currentStep,
    required this.selectedRide,
    required this.onRideSelected,
    required this.onNextStep,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    switch (currentStep) {
      // ── Step 1: Location + Horizontal Ride Scroll ──
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pickup Field
            LocationField(
              icon: Icons.my_location,
              iconColor: AppColors.primary,
              hint: 'Your current location',
            ),

            const SizedBox(height: 8),

            // Destination Field
            LocationField(
              icon: Icons.location_on,
              iconColor: Colors.redAccent,
              hint: 'Where to?',
            ),

            const SizedBox(height: 20),

            const Text(
              'Choose ride type',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: RideType.values.map((type) {
                  final option = rideOptions[type]!;
                  final isSelected = type == selectedRide;

                  return GestureDetector(
                    onTap: () => onRideSelected(type),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 100,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryLight
                              : Colors.black12,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(option.icon,
                              color: isSelected ? Colors.white : Colors.black87,
                              size: 28),
                          const SizedBox(height: 6),
                          Text(
                            option.label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                          Text(
                            option.price,
                            style: TextStyle(
                              fontSize: 11,
                              color:
                                  isSelected ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            NextButton(
              label: 'Next → Ride Type',
              onTap: onNextStep,
            ),
          ],
        );

      case 1:
        final selected = rideOptions[selectedRide]!;
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(selected.icon, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(selected.label,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        Text('ETA: ${selected.eta}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            )),
                      ],
                    ),
                  ),
                  Text(
                    selected.price,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            NextButton(
              label: 'Next → Payment',
              onTap: onNextStep,
            ),
          ],
        );

      case 2:
        return Column(
          children: [
            ...['Cash', 'Credit Card', 'Apple Pay'].map((method) {
              final icons = {
                'Cash': Icons.money,
                'Credit Card': Icons.credit_card,
                'Apple Pay': Icons.apple,
              };
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black12),
                ),
                child: ListTile(
                  leading: Icon(icons[method], color: AppColors.primary),
                  title: Text(method),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 14, color: Colors.black38),
                  onTap: () {},
                ),
              );
            }),
            const SizedBox(height: 8),
            NextButton(
              label: 'Confirm Booking 🚕',
              onTap: onConfirm,
            ),
          ],
        );

      default:
        return const SizedBox();
    }
  }
}
