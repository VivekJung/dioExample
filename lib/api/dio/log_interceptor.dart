/*
Using this another interceptor to handle errors before they are handled by then() or catchError().

In order to use interceptors for logging purposes, this "logger" package is used for printing beautiful logs.
Procedure: 
Start by creating a new class named LoggerInterceptor that extends the Interceptor class and here we are going to utilize all the three callback methods to print logs: onRequest(), onResponse() and onError().

https://towardsdev.com/dio-package-in-flutter-http-requests-and-interceptors-2c3d6ef3e9a3#032b
*/

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LogerInterceptor extends Interceptor {
  Logger logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    printTime: false,
  ));

  //overriding existing methods of Interceptor class (onError, onRequest, onResponse)
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request=> $requestPath');
    logger.d('Error: ${err.error}, Message: ${err.message}');
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    logger.i('${options.method} request => $requestPath'); // Info log
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(
        'StatusCode: ${response.statusCode}, Data: ${response.data}'); // Debug log
    return super.onResponse(response, handler);
  }
}
