import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:univs/core/resources/env/env.dart';
import 'package:univs/core/resources/injector/di.dart' as di;
import 'navigation_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpService {
  late Dio _dio;
  late String _authToken;
  final EnvConfig _env = di.sl<EnvConfig>();

  static HttpService? _instance;

  Dio get dio => _dio;
  String get authToken => _authToken;

  factory HttpService() => _instance ??= HttpService._internal();

  HttpService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _env.server,
        connectTimeout: const Duration(milliseconds: 300000),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'authorizationType': 'token',
        },
      ),
    );

    // _dio.interceptors.add(InterceptorsWrapper(onError: onAuthorizeErrorHandler()));

    if (!kReleaseMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 150,
        ),
      );
    }
  }

  void setToken({required String token}) {
    _dio.options.headers['Authorization'] = "Bearer $token";
    _authToken = "Bearer $token";
  }

  void removeToken() {
    _dio.options.headers['Authorization'] = null;
  }

  void setContentTypeImage() {
    _dio.options.headers['Content-Type'] = "image/jpeg";
  }

  void setContentTypeJson() {
    _dio.options.headers['Content-Type'] = "application/json";
  }

  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  // Future<String> fetchNewToken() async {
  //   return await di.sl<LoginProvider>().doRefreshToken();
  // }

  Function(DioException, ErrorInterceptorHandler)? onAuthorizeErrorHandler() {
    return (DioException e, ErrorInterceptorHandler handler) {
      if (e.response?.statusCode == 401) {
        // Redirect to login page
        di.sl<NavigationService>().navigateToLogin();
      }

      // return handler.next(e);
    };
  }
}
