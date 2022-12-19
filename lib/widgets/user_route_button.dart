import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_and_routes/blocs/blocs.dart';

class ShowUserRouteButton extends StatelessWidget {
  const ShowUserRouteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                mapBloc.add(ShowUserRouteEvent());
              },
              icon: Icon(
                state.showUserRoute
                    ? Icons.linear_scale_rounded
                    : Icons.not_interested,
              ),
            );
          },
        ),
      ),
    );
  }
}
