import 'package:dio/dio.dart';

/// VibeDevEdu API Service
/// 모든 백엔드 API 통신을 담당하는 기본 서비스
class ApiService {
  final Dio _dio;
  final String baseUrl;

  ApiService({this.baseUrl = 'https://vibedevedu-backend.vercel.app'})
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        )) {
    _setupInterceptors();
  }

  /// Interceptors 설정
  void _setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // 인증 토큰 추가 (향후 구현)
        final token = _getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        print('[API Request] ${options.method} ${options.path}');
        if (options.queryParameters.isNotEmpty) {
          print('[Query Params] ${options.queryParameters}');
        }
        if (options.data != null) {
          print('[Request Body] ${options.data}');
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('[API Response] ${response.statusCode} ${response.requestOptions.path}');
        return handler.next(response);
      },
      onError: (error, handler) {
        print('[API Error] ${error.response?.statusCode} ${error.requestOptions.path}');
        print('[Error Message] ${error.message}');
        if (error.response?.data != null) {
          print('[Error Data] ${error.response?.data}');
        }

        return handler.next(error);
      },
    ));
  }

  /// 인증 토큰 가져오기 (TODO: SecureStorage에서 가져오기)
  String? _getToken() {
    // TODO: Implement secure storage
    return null;
  }

  /// GET 요청
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParams,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// POST 요청
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParams,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// PUT 요청
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParams,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// DELETE 요청
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParams,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 에러 핸들링
  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException('연결 시간 초과', statusCode: 408);

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 500;
        final message = error.response?.data['message'] ?? '서버 오류가 발생했습니다';
        return ApiException(message, statusCode: statusCode);

      case DioExceptionType.cancel:
        return ApiException('요청이 취소되었습니다');

      case DioExceptionType.connectionError:
        return ApiException('네트워크 연결을 확인해주세요');

      default:
        return ApiException('알 수 없는 오류가 발생했습니다');
    }
  }
}

/// API 예외 클래스
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}
