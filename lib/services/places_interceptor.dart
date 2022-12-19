import 'package:dio/dio.dart';

class PlacesInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'access_token':
          'pk.eyJ1IjoiZmVkZXhwZXJleiIsImEiOiJjbDkwbzVuMzcxMjFzM3VubmkzdXhpYmIwIn0.OoYbdQheH0_jxV3mXM3oYQ',
      'language': 'es',
    });

    super.onRequest(options, handler);
  }
}
