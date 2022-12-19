import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? positionStream;

  LocationBloc() : super(const LocationState()) {
    on<StartFollowingUserEvent>((event, emit) {
      emit(state.copyWith(followingUser: true));
    });

    on<StopFollowingUserEvent>((event, emit) {
      emit(state.copyWith(followingUser: false));
    });

    on<OnNewUserLocationEvent>((event, emit) {
      emit(
        state.copyWith(
            lastKnownLocation: event.newLocation,
            locationHistory: [...state.locationHistory, event.newLocation]),
      );
    });
  }

  Future<Position> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    return position;
  }

  void startFollowingUser() {
    add(const StartFollowingUserEvent());
    positionStream = Geolocator.getPositionStream().listen((event) {
      final position = event;
      add(
        OnNewUserLocationEvent(
            newLocation: LatLng(position.latitude, position.longitude)),
      );
    });
  }

  void stopFollowingUser() {
    add(const StopFollowingUserEvent());
    positionStream?.cancel();
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
