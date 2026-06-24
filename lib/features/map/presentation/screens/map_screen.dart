import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_taxi/features/map/data/repositories/location_repository_impl.dart';
import 'package:my_taxi/features/map/presentation/widgets/draggablebottom/draggable_bottom_sheet.dart';
import 'package:my_taxi/features/map/presentation/widgets/map_skeleton_loader.dart';

import '../cubit/map_cubit.dart';
import '../cubit/map_state.dart';
import '../widgets/map_view.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapCubit(LocationRepository())..fetchLocation(),
      child: const _MapScreenBody(),
    );
  }
}

class _MapScreenBody extends StatelessWidget {
  const _MapScreenBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        final cubit = context.read<MapCubit>();

        if (state.status == MapStatus.loading ||
            state.status == MapStatus.initial) {
          return const MapSkeletonLoader();
        }

        if (state.status == MapStatus.error) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_off_outlined,
                      color: Colors.redAccent, size: 48),
                  const SizedBox(height: 12),
                  Text(state.errorMessage ?? 'Location error'),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: cubit.retry,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try again'),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          body: Stack(
            children: [
              // ── الخريطة ──
              Positioned.fill(
                child: MapView(position: state.position!),
              ),

              // ── Bottom Sheet ──
              DraggableScrollableSheet(
                initialChildSize: 0.15,
                minChildSize: 0.15,
                maxChildSize: 0.6,
                snap: true,
                snapSizes: const [0.15, 0.6],
                expand: true,
                builder: (context, scrollController) {
                  return DraggableBottomSheet(
                    currentStep: state.currentStep,
                    selectedRide: state.selectedRide,
                    onRideSelected: cubit.selectRide,
                    onNextStep: () => cubit.nextStep(),
                    onConfirm: () {},
                    scrollController: scrollController,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
