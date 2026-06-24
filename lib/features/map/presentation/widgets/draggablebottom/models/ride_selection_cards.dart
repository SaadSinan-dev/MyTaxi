import 'package:flutter/material.dart';
import 'package:my_taxi/core/colors/app_colors.dart';
import 'package:my_taxi/features/map/presentation/cubit/map_state.dart';

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

const Map<RideType, RideOption> rideOptions = {
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

class RideSelectionCards extends StatelessWidget {
  final RideType selectedRide;
  final ValueChanged<RideType> onRideSelected;

  const RideSelectionCards({
    super.key,
    required this.selectedRide,
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
                  color: isSelected ? AppColors.primary : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? AppColors.primaryLight : Colors.black12,
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
                          color: isSelected ? Colors.white70 : Colors.black54,
                        )),
                    Text(option.price,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black,
                        )),
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
