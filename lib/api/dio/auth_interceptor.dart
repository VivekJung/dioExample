// As request methods PUT, POST, PATCH, DELETE needs access token, (available in variable :API_KEY)
// which needs to be passed with "Authorization" header as Bearer token in each of them;
//to avoid this repetiton
// we use INTERCEPTOR clas with dio's Interceptor class.
import 'package:dio/dio.dart';
import 'package:dioapi/api/app_endPoints.dart';

class AuthorizationInterceptor extends Interceptor {
  bool _needAuthorizationHeader(RequestOptions options) {
    if (options.method == 'GET') {
      return false;
    } else {
      return true;
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // adding access-token/ apikey with bearer if not a Get request
    if (_needAuthorizationHeader(options)) {
      options.headers['Authorization'] = "Bearer $API_KEY";
    }
    //then continue with above request
    super.onRequest(options, handler);
  }
}
