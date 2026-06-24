import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_taxi/features/map/data/repositories/location_repository_impl.dart';

import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final LocationRepository _locationRepository;

  MapCubit(this._locationRepository) : super(const MapState());

  Future<void> fetchLocation() async {
    emit(state.copyWith(status: MapStatus.loading));
    try {
      final position = await _locationRepository.getCurrentLocation();
      emit(state.copyWith(
        status: MapStatus.loaded,
        position: position,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: MapStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void nextStep() {
    if (state.currentStep < 2) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void resetSteps() {
    emit(state.copyWith(currentStep: 0));
  }

  void selectRide(RideType type) {
    emit(state.copyWith(selectedRide: type));
  }

  Future<void> retry() async {
    emit(state.copyWith(status: MapStatus.loading, errorMessage: null));
    await fetchLocation();
  }
}
