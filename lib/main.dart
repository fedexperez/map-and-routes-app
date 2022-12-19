import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_and_routes/blocs/blocs.dart';
import 'package:maps_and_routes/routes/app_routes.dart';
import 'package:maps_and_routes/services/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GpsBloc()),
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(
          create: (context) =>
              MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context)),
        ),
        BlocProvider(
            create: (context) => SearchBloc(trafficService: TrafficService())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Maps and Routes',
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
      ),
    );
  }
}
