part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showUserRoute;

  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  const MapState({
    this.isMapInitialized = false,
    this.isFollowingUser = true,
    this.showUserRoute = false,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  })  : polylines = polylines ?? const {},
        markers = markers ?? const {};

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? showUserRoute,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  }) {
    return MapState(
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        showUserRoute: showUserRoute ?? this.showUserRoute,
        polylines: polylines ?? this.polylines,
        markers: markers ?? this.markers);
  }

  @override
  List<Object> get props =>
      [isMapInitialized, isFollowingUser, showUserRoute, polylines, markers];
}

// class MapInitial extends MapState {}
