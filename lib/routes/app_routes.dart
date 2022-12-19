import 'package:flutter/material.dart';

import 'package:maps_and_routes/screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'loading';

  static final Map<String, Widget Function(BuildContext)> routes = {
    'access': (BuildContext context) => const GpsAccessScreen(),
    'map': (BuildContext context) => const MapScreen(),
    'loading': (BuildContext context) => const LoadingScreen(),
  };
}
