import 'package:latlong2/latlong.dart';

enum MapStatus { initial, loading, loaded, error }

enum RideType { economy, comfort, xl }

class MapState {
  final MapStatus status;
  final LatLng? position;
  final RideType selectedRide;
  final String? errorMessage;
  final int currentStep;
  const MapState({
    this.status = MapStatus.initial,
    this.position,
    this.selectedRide = RideType.economy,
    this.errorMessage,
    this.currentStep = 0,
  });

  MapState copyWith({
    MapStatus? status,
    LatLng? position,
    RideType? selectedRide,
    String? errorMessage,
    int? currentStep,
  }) {
    return MapState(
      status: status ?? this.status,
      position: position ?? this.position,
      selectedRide: selectedRide ?? this.selectedRide,
      errorMessage: errorMessage ?? this.errorMessage,
      currentStep: currentStep ?? this.currentStep,
    );
  }
}
