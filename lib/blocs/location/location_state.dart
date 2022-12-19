part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? lastKnownLocation;
  final List<LatLng> locationHistory;
  //history

  const LocationState(
      {this.followingUser = false, this.lastKnownLocation, locationHistory})
      : locationHistory = locationHistory ?? const [];

  LocationState copyWith(
      {bool? followingUser,
      LatLng? lastKnownLocation,
      List<LatLng>? locationHistory}) {
    return LocationState(
      followingUser: followingUser ?? this.followingUser,
      lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
      locationHistory: locationHistory ?? this.locationHistory,
    );
  }

  @override
  List<Object?> get props =>
      [followingUser, lastKnownLocation, locationHistory];
}

// class LocationInitial extends LocationState {
//   LocationInitial({required super.followingUser});
// }
