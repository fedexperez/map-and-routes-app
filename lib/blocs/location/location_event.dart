part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class OnNewUserLocationEvent extends LocationEvent {
  final LatLng newLocation;

  const OnNewUserLocationEvent({required this.newLocation});
}

class StartFollowingUserEvent extends LocationEvent {
  const StartFollowingUserEvent();
}

class StopFollowingUserEvent extends LocationEvent {
  const StopFollowingUserEvent();
}
