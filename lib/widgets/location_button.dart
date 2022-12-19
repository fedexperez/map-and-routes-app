import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_and_routes/blocs/blocs.dart';
import 'package:maps_and_routes/ui/custom_snackbar.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        child: IconButton(
          onPressed: () {
            final userLocation = locationBloc.state.lastKnownLocation;

            if (userLocation == null) {
              final snack = CustomSnackBar(text: 'No location available');
              ScaffoldMessenger.of(context).showSnackBar(snack);
              return;
            }

            mapBloc.moveCamera(userLocation);
          },
          icon: const Icon(Icons.my_location_outlined),
        ),
      ),
    );
  }
}
