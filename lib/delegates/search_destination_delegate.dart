import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_and_routes/blocs/blocs.dart';
import 'package:maps_and_routes/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {
  SearchDestinationDelegate() : super(searchFieldLabel: 'Search');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        final result = SearchResult(cancel: true);
        close(context, result);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final proximityLocation =
        BlocProvider.of<LocationBloc>(context).state.lastKnownLocation;

    searchBloc.getPlacesByQuery(proximityLocation!, query);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final places = state.places;
        return ListView.separated(
          itemCount: places.length,
          itemBuilder: (context, index) {
            final place = places[index];
            return ListTile(
              title: Text(place.text),
              subtitle: Text(place.placeName),
              leading: const Icon(
                Icons.place_outlined,
                color: Colors.black,
              ),
              onTap: () {
                final result = SearchResult(
                  cancel: false,
                  manual: false,
                  position: LatLng(place.center[1], place.center[0]),
                  name: place.text,
                  description: place.placeName,
                );

                searchBloc.add(AddLocationToHistoryEvent(place: place));

                close(context, result);
              },
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final locatonHistory =
        BlocProvider.of<SearchBloc>(context).state.locationSearchHistory;

    return ListView(
      children: [
        ListTile(
            leading:
                const Icon(Icons.location_on_outlined, color: Colors.black),
            title: const Text(
              'Put location manually',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              final result = SearchResult(cancel: false, manual: true);
              close(context, result);
            }),
        ...locatonHistory.map((place) {
          return ListTile(
            leading: const Icon(Icons.history, color: Colors.black),
            title: Text(place.text),
            subtitle: Text(place.placeName),
            onTap: () {
              final result = SearchResult(
                cancel: false,
                manual: false,
                position: LatLng(place.center[1], place.center[0]),
                name: place.text,
                description: place.placeName,
              );

              close(context, result);
            },
          );
        }),
      ],
    );
  }
}
