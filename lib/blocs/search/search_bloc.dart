import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

import 'package:maps_and_routes/models/models.dart';
import 'package:maps_and_routes/services/services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  TrafficService trafficService;

  SearchBloc({required this.trafficService}) : super(const SearchState()) {
    on<ActivateManualMarkerEvent>(
        (event, emit) => emit(state.copyWith(displayManualMarker: true)));

    on<DeactivateManualMarkerEvent>(
        (event, emit) => emit(state.copyWith(displayManualMarker: false)));

    on<NewPlacesFoundEvent>((event, emit) {
      emit(state.copyWith(places: event.places));
    });

    on<AddLocationToHistoryEvent>((event, emit) {
      emit(state.copyWith(locationSearchHistory: [
        event.place,
        ...state.locationSearchHistory
      ]));
    });
  }

  Future<RouteDestination> getCoorsStartToEnd(LatLng start, LatLng end) async {
    final trafficResponse = await trafficService.getCoorsStartToEnd(start, end);

    final endPlace = await trafficService.getInfoByCoors(end);

    final geometry = trafficResponse.routes[0].geometry;
    final distance = trafficResponse.routes[0].distance;
    final duration = trafficResponse.routes[0].duration;

    // Decodificar
    final points = decodePolyline(geometry, accuracyExponent: 6);

    final latLngList = points
        .map((coor) => LatLng(coor[0].toDouble(), coor[1].toDouble()))
        .toList();

    return RouteDestination(
      points: latLngList,
      duration: duration,
      distance: distance,
      endPlace: endPlace,
    );
  }

  Future getPlacesByQuery(LatLng proximityLocation, String query) async {
    List<Feature> newPlaces =
        await trafficService.getResultsByQuery(proximityLocation, query);

    if (newPlaces.isEmpty) {
      newPlaces = [];
    }

    add(NewPlacesFoundEvent(places: newPlaces));
  }
}
