part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  final GoogleMapController controller;

  const OnMapInitializedEvent({required this.controller});
}

class OnStopFollowingUserEvent extends MapEvent {}

class OnStartFollowingUserEvent extends MapEvent {}

class UpdateUserPolylinesEvent extends MapEvent {
  final List<LatLng> userLocationsHistory;

  const UpdateUserPolylinesEvent({required this.userLocationsHistory});
}

class ShowUserRouteEvent extends MapEvent {}

class DisplayPolylinesEvent extends MapEvent {
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  const DisplayPolylinesEvent({required this.polylines, required this.markers});
}
