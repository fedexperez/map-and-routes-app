import 'package:flutter/material.dart';
import 'package:maps_and_routes/blocs/blocs.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return (!state.isGpsEnabled)
              ? const _EnableGpsMessage()
              : const _LocationPermissionButton();
        },
      )),
    );
  }
}

class _LocationPermissionButton extends StatelessWidget {
  const _LocationPermissionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
            padding: EdgeInsets.all(10),
            child: Text('Permission to active location is required')),
        MaterialButton(
          onPressed: () {
            final gpsBloc = BlocProvider.of<GpsBloc>(context);
            gpsBloc.askGpsAccess();
          },
          color: Colors.black,
          elevation: 0,
          shape: const StadiumBorder(),
          splashColor: Colors.transparent,
          child: const Text(
            'Location Permission',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Required active location',
      style: TextStyle(fontSize: 25),
    );
  }
}
