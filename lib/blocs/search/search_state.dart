part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool displayManualMarker;
  final List<Feature> places;
  final List<Feature> locationSearchHistory;

  const SearchState({
    this.displayManualMarker = false,
    this.places = const [],
    this.locationSearchHistory = const [],
  });

  SearchState copyWith(
      {bool? displayManualMarker,
      List<Feature>? places,
      List<Feature>? locationSearchHistory}) {
    return SearchState(
      displayManualMarker: displayManualMarker ?? this.displayManualMarker,
      places: places ?? this.places,
      locationSearchHistory:
          locationSearchHistory ?? this.locationSearchHistory,
    );
  }

  @override
  List<Object> get props =>
      [displayManualMarker, places, locationSearchHistory];
}
