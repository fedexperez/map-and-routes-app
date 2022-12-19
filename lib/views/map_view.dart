import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_and_routes/blocs/blocs.dart';

class MapView extends StatelessWidget {
  const MapView({
    super.key,
    required this.initialLocation,
    required this.polylinesSet,
    required this.markersSet,
  });

  final LatLng initialLocation;
  final Set<Polyline> polylinesSet;
  final Set<Marker> markersSet;

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final Size size = MediaQuery.of(context).size;

    final CameraPosition initialCameraPosition =
        CameraPosition(target: initialLocation, zoom: 15);

    return SizedBox(
        width: size.width,
        height: size.height,
        child: Listener(
          onPointerMove: (event) => mapBloc.add(OnStopFollowingUserEvent()),
          child: GoogleMap(
            initialCameraPosition: initialCameraPosition,
            compassEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            polylines: polylinesSet,
            zoomControlsEnabled: false,
            onMapCreated: ((controller) {
              return mapBloc.add(OnMapInitializedEvent(controller: controller));
            }),
            onCameraMove: (position) {
              mapBloc.mapCenter = position.target;
            },
            markers: markersSet,
            mapToolbarEnabled: false,
          ),
        ));
  }
}
