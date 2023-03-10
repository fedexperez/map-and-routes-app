import 'package:dio/dio.dart';

const accessToken =
    'pk.eyJ1IjoiZmVkZXhwZXJleiIsImEiOiJjbDkwbzVuMzcxMjFzM3VubmkzdXhpYmIwIn0.OoYbdQheH0_jxV3mXM3oYQ';

class TrafficInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });

    super.onRequest(options, handler);
  }
}
