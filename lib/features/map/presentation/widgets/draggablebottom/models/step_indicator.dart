import 'package:flutter/material.dart';
import 'package:my_taxi/core/colors/app_colors.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  const StepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = ['Location', 'Ride Type', 'Payment'];

    return Row(
      children: List.generate(steps.length, (i) {
        final isActive = i == currentStep;
        final isDone = i < currentStep;

        return Expanded(
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color:
                      isDone || isActive ? AppColors.primary : Colors.black12,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: isDone
                      ? const Icon(Icons.check, color: Colors.white, size: 14)
                      : Text(
                          '${i + 1}',
                          style: TextStyle(
                            color: isActive ? Colors.white : Colors.black38,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[i],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight:
                            isActive ? FontWeight.bold : FontWeight.normal,
                        color: isActive ? AppColors.primary : Colors.black38,
                      ),
                    ),
                    if (i < steps.length - 1)
                      Container(
                        height: 1,
                        margin: const EdgeInsets.only(top: 4, right: 8),
                        color: isDone ? AppColors.primary : Colors.black12,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
