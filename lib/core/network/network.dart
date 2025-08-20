import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Custom exception classes for better error handling
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException(this.message, {this.statusCode, this.data});

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

class NetworkException extends ApiException {
  NetworkException(super.message);
}

class TimeoutException extends ApiException {
  TimeoutException(super.message);
}

class ServerException extends ApiException {
  ServerException(super.message, {super.statusCode, super.data});
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(super.message) : super(statusCode: 401);
}

class TokenExpiredException extends ApiException {
  TokenExpiredException(super.message) : super(statusCode: 401);
}

// API Response wrapper
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? errorMessage;
  final int? statusCode;

  ApiResponse({
    required this.success,
    this.data,
    this.errorMessage,
    this.statusCode,
  });

  factory ApiResponse.success(T data, {String? message, int? statusCode}) {
    return ApiResponse(
      success: true,
      data: data,
      errorMessage: message,
      statusCode: statusCode,
    );
  }

  factory ApiResponse.error(String message, {int? statusCode}) {
    return ApiResponse(
      success: false,
      errorMessage: message,
      statusCode: statusCode,
    );
  }
}

// Token pair for authentication with secure storage
class TokenPair {
  final String accessToken;
  final String? refreshToken;
  final DateTime? expiresAt;

  TokenPair({required this.accessToken, this.refreshToken, this.expiresAt});

  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!.subtract(Duration(minutes: 5)));
  }

  factory TokenPair.fromLoginResponse(
    Map<String, dynamic> data,
    String? refreshTokenFromCookie,
  ) {
    DateTime? expiresAt;

    if (data['expires_at'] != null) {
      if (data['expires_at'] is int) {
        expiresAt = DateTime.fromMillisecondsSinceEpoch(
          data['expires_at'] * 1000,
        );
      } else if (data['expires_at'] is String) {
        expiresAt = DateTime.tryParse(data['expires_at']);
      }
    } else if (data['expires_in'] != null) {
      // Expires in seconds from now
      final expiresIn = data['expires_in'] as int;
      expiresAt = DateTime.now().add(Duration(seconds: expiresIn));
    }

    return TokenPair(
      accessToken: data['accessToken'] ?? data['access_token'] ?? '',
      refreshToken: refreshTokenFromCookie,
      expiresAt: expiresAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_at': expiresAt?.toIso8601String(),
    };
  }

  factory TokenPair.fromJson(Map<String, dynamic> json) {
    DateTime? expiresAt;
    if (json['expires_at'] != null) {
      expiresAt = DateTime.tryParse(json['expires_at']);
    }

    return TokenPair(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'],
      expiresAt: expiresAt,
    );
  }
}

// Authentication event callbacks
abstract class AuthEventListener {
  void onTokenRefreshed(TokenPair newTokens);
  void onTokenRefreshFailed();
  void onUnauthorized();
}

// Main Dio Helper Class with Token Management and Secure Storage
class DioHelper {
  static late Dio _dio;
  static TokenPair? _tokenPair;
  static String? _refreshEndpoint;
  static AuthEventListener? _authEventListener;
  static bool _isRefreshing = false;
  static final List<MapEntry<RequestOptions, Completer<Response>>>
  _pendingRequests = [];

  // Secure storage instance
  static const FlutterSecureStorage secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  // Storage keys
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _tokenExpiryKey = 'token_expiry';

  // Initialize Dio with base configuration
  static void init({
    String? refreshTokenEndpoint,
    int sendTimeout = 30000,
    Map<String, dynamic>? defaultHeaders,
    AuthEventListener? authEventListener,
  }) {
    _refreshEndpoint = refreshTokenEndpoint ?? '/auth/refresh';
    _authEventListener = authEventListener;

    BaseOptions options = BaseOptions(
      baseUrl: 'https://dev.api.hyde-x.com',
      connectTimeout: Duration(milliseconds: 30000),
      receiveTimeout: Duration(milliseconds: 30000),
      sendTimeout: Duration(milliseconds: sendTimeout),
      contentType: 'application/json',
      responseType: ResponseType.json,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        ...?defaultHeaders,
      },
    );

    _dio = Dio(options);
    _setupInterceptors();

    _loadStoredTokens();
  }

  // Load tokens from secure storage
  static Future<void> _loadStoredTokens() async {
    try {
      final accessToken = await secureStorage.read(key: _accessTokenKey);
      final refreshToken = await secureStorage.read(key: _refreshTokenKey);
      final expiryString = await secureStorage.read(key: _tokenExpiryKey);

      if (accessToken != null) {
        DateTime? expiresAt;
        if (expiryString != null) {
          expiresAt = DateTime.tryParse(expiryString);
        }

        _tokenPair = TokenPair(
          accessToken: accessToken,
          refreshToken: refreshToken,
          expiresAt: expiresAt,
        );

        if (kDebugMode) {
          print('🔐 Tokens loaded from secure storage');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error loading stored tokens: $e');
      }
    }
  }

  // Save tokens to secure storage
  static Future<void> saveTokensToStorage(TokenPair tokens) async {
    try {
      await secureStorage.write(
        key: _accessTokenKey,
        value: tokens.accessToken,
      );

      if (tokens.refreshToken != null) {
        await secureStorage.write(
          key: _refreshTokenKey,
          value: tokens.refreshToken!,
        );
      }

      if (tokens.expiresAt != null) {
        await secureStorage.write(
          key: _tokenExpiryKey,
          value: tokens.expiresAt!.toIso8601String(),
        );
      }

      if (kDebugMode) {
        print('🔐 Tokens saved to secure storage');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error saving tokens to storage: $e');
      }
    }
  }

  // Clear tokens from secure storage
  static Future<void> _clearTokensFromStorage() async {
    try {
      await secureStorage.delete(key: _accessTokenKey);
      await secureStorage.delete(key: _refreshTokenKey);
      await secureStorage.delete(key: _tokenExpiryKey);

      if (kDebugMode) {
        print('🔓 Tokens cleared from secure storage');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error clearing tokens from storage: $e');
      }
    }
  }

  // Extract refresh token from cookies
  static String? _extractRefreshTokenFromCookies(
    List<String>? setCookieHeaders,
  ) {
    if (setCookieHeaders == null) return null;

    for (String cookie in setCookieHeaders) {
      if (cookie.startsWith('refreshToken=') ||
          cookie.startsWith('refresh_token=')) {
        // Extract value between = and ; (or end of string)
        final startIndex = cookie.indexOf('=') + 1;
        var endIndex = cookie.indexOf(';');
        if (endIndex == -1) endIndex = cookie.length;

        final tokenValue = cookie.substring(startIndex, endIndex).trim();
        if (kDebugMode) {
          print('🍪 Refresh token extracted from cookie');
        }
        return tokenValue;
      }
    }
    return null;
  }

  // Setup interceptors with token management
  static void _setupInterceptors() {
    // Request interceptor for token management
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Skip token refresh for refresh endpoint
          if (options.path.contains(_refreshEndpoint!)) {
            // Add refresh token to cookie header for refresh requests
            if (_tokenPair?.refreshToken != null) {
              final existingCookies =
                  options.headers['Cookie'] as String? ?? '';
              final refreshCookie = 'refreshToken=${_tokenPair!.refreshToken}';
              options.headers['Cookie'] = existingCookies.isEmpty
                  ? refreshCookie
                  : '$existingCookies; $refreshCookie';
            }
            handler.next(options);
            return;
          }

          // Check and refresh token if needed
          if (_tokenPair != null) {
            if (_tokenPair!.isExpired && !_isRefreshing) {
              try {
                await _refreshToken();
              } catch (e) {
                if (kDebugMode) {
                  print('❌ Token refresh failed: $e');
                }
                _authEventListener?.onTokenRefreshFailed();
                handler.reject(
                  DioException(
                    requestOptions: options,
                    error: TokenExpiredException('Token refresh failed'),
                    type: DioExceptionType.unknown,
                  ),
                );
                return;
              }
            }

            // Add current access token
            options.headers['Authorization'] =
                'Bearer ${_tokenPair!.accessToken}';
          }

          // Log request in debug mode
          if (kDebugMode) {
            print('🚀 REQUEST: ${options.method} ${options.uri}');
            print('📤 Headers: ${options.headers}');
            if (options.data != null) {
              print('📤 Data: ${options.data}');
            }
          }

          handler.next(options);
        },
        onResponse: (response, handler) {
          // Extract refresh token from Set-Cookie headers if present
          if (response.headers['set-cookie'] != null) {
            final refreshToken = _extractRefreshTokenFromCookies(
              response.headers['set-cookie'],
            );
            if (refreshToken != null && _tokenPair != null) {
              _tokenPair = TokenPair(
                accessToken: _tokenPair!.accessToken,
                refreshToken: refreshToken,
                expiresAt: _tokenPair!.expiresAt,
              );
              saveTokensToStorage(_tokenPair!);
            }
          }

          // Log response in debug mode
          if (kDebugMode) {
            print(
              '✅ RESPONSE: ${response.statusCode} ${response.requestOptions.uri}',
            );
            print('📥 Data: ${response.data}');
          }
          handler.next(response);
        },
        onError: (error, handler) async {
          // Handle 401 errors with token refresh
          if (error.response?.statusCode == 401 &&
              _tokenPair != null &&
              !error.requestOptions.path.contains(_refreshEndpoint!) &&
              !_isRefreshing) {
            try {
              if (kDebugMode) {
                print('🔄 Attempting token refresh due to 401 error');
              }

              await _refreshToken();

              // Retry original request with new token
              final newOptions = error.requestOptions;
              newOptions.headers['Authorization'] =
                  'Bearer ${_tokenPair!.accessToken}';

              final response = await _dio.fetch(newOptions);
              handler.resolve(response);
              return;
            } catch (refreshError) {
              if (kDebugMode) {
                print('❌ Token refresh failed during retry: $refreshError');
              }
              _authEventListener?.onTokenRefreshFailed();
              await _clearTokens();
            }
          }

          // Log error in debug mode
          if (kDebugMode) {
            print('❌ ERROR: ${error.message}');
            print('❌ Response: ${error.response?.data}');
          }

          handler.next(error);
        },
      ),
    );

    // Add pretty logger interceptor for debug mode
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          responseHeader: false,
          error: true,
        ),
      );
    }
  }

  // Set authentication tokens from login/register response
  static Future<void> setTokensFromAuthResponse(
    Map<String, dynamic> responseData,
    Response response,
  ) async {
    // Extract refresh token from cookies
    final refreshToken = _extractRefreshTokenFromCookies(
      response.headers['set-cookie'],
    );

    // Create token pair from response data and cookies
    _tokenPair = TokenPair.fromLoginResponse(responseData, refreshToken);

    // Save to secure storage
    await saveTokensToStorage(_tokenPair!);

    // Trigger auth event
    _authEventListener?.onTokenRefreshed(_tokenPair!);

    if (kDebugMode) {
      print(
        '🔐 Tokens set from auth response. Access token from data, refresh token from cookies',
      );
      print('🔐 Expires at: ${_tokenPair!.expiresAt}');
    }
  }

  // Get current tokens
  static Future<String?> getAccessToken() async {
    return secureStorage.read(key: _accessTokenKey);
  }

  // Check if user is authenticated
  static bool get isAuthenticated => _tokenPair != null;

  // Check if token is expired
  static bool get isTokenExpired => _tokenPair?.isExpired ?? true;

  // Clear authentication tokens
  static Future<void> clearTokens() async {
    await _clearTokens();
  }

  static Future<void> _clearTokens() async {
    _tokenPair = null;
    _isRefreshing = false;
    _pendingRequests.clear();
    await _clearTokensFromStorage();
    if (kDebugMode) {
      print('🔓 Tokens cleared');
    }
  }

  // Refresh access token using refresh token from cookies
  static Future<void> _refreshToken() async {
    if (_isRefreshing) {
      // Wait for ongoing refresh
      return _waitForRefresh();
    }

    if (_tokenPair?.refreshToken == null) {
      throw TokenExpiredException('No refresh token available');
    }

    _isRefreshing = true;

    try {
      if (kDebugMode) {
        print('🔄 Refreshing token using refresh token from cookies...');
      }

      // Prepare cookies with refresh token
      final cookieHeader = 'refreshToken=${_tokenPair!.refreshToken}';

      final response = await _dio.post(
        _refreshEndpoint!,
        options: Options(headers: {'Cookie': cookieHeader}),
      );

      if (response.statusCode == 200 && response.data != null) {
        // Extract new access token from response data
        final newAccessToken =
            response.data['accessToken'] ?? response.data['access_token'];
        if (newAccessToken == null) {
          throw ApiException('No access token in refresh response');
        }

        // Check if new refresh token is provided in cookies
        final newRefreshToken =
            _extractRefreshTokenFromCookies(response.headers['set-cookie']) ??
            _tokenPair!.refreshToken;

        // Create new token pair
        final newTokens = TokenPair(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
          expiresAt: _tokenPair!
              .expiresAt, // Keep existing expiry or update if provided
        );

        _tokenPair = newTokens;
        await saveTokensToStorage(newTokens);
        _authEventListener?.onTokenRefreshed(newTokens);

        if (kDebugMode) {
          print('✅ Token refreshed successfully');
        }

        // Process pending requests
        await _processPendingRequests();
      } else {
        throw ApiException('Token refresh failed');
      }
    } catch (e) {
      await _clearTokens();
      _authEventListener?.onUnauthorized();
      throw TokenExpiredException('Token refresh failed: $e');
    } finally {
      _isRefreshing = false;
    }
  }

  // Wait for ongoing refresh to complete
  static Future<void> _waitForRefresh() async {
    while (_isRefreshing) {
      await Future.delayed(Duration(milliseconds: 100));
    }
  }

  // Process requests that were queued during token refresh
  static Future<void> _processPendingRequests() async {
    final requests = List.from(_pendingRequests);
    _pendingRequests.clear();

    for (final entry in requests) {
      try {
        final options = entry.key;
        final completer = entry.value;

        options.headers['Authorization'] = 'Bearer ${_tokenPair!.accessToken}';
        final response = await _dio.fetch(options);
        completer.complete(response);
      } catch (e) {
        // Handle individual request failures
        if (kDebugMode) {
          print('❌ Failed to process pending request: $e');
        }
      }
    }
  }

  // GET Request
  static Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // POST Request
  static Future<ApiResponse<T>> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // PUT Request
  static Future<ApiResponse<T>> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE Request
  static Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // PATCH Request
  static Future<ApiResponse<T>> patch<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.patch(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Upload file
  static Future<ApiResponse<T>> uploadFile<T>(
    String endpoint,
    File file, {
    String fieldName = 'file',
    Map<String, dynamic>? data,
    ProgressCallback? onSendProgress,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(file.path, filename: fileName),
        ...?data,
      });

      final response = await _dio.post(
        endpoint,
        data: formData,
        onSendProgress: onSendProgress,
        options: Options(contentType: 'multipart/form-data'),
      );

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Enhanced auth method that handles both login and register
  static Future<Map<String, dynamic>> authenticate(
    String endpoint,
    Map<String, dynamic> authData,
  ) async {
    try {
      final response = await _dio.post(endpoint, data: authData);

      if (response.statusCode == 201 && response.data != null ||
          response.statusCode == 200) {
        // Set tokens from auth response (access token from data, refresh token from cookies)
        await setTokensFromAuthResponse(response.data["data"], response);

        return response.data;
      } else {
        throw ApiException('Authentication failed');
      }
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Enhanced login method that handles tokens from response data and cookies
  static Future<Map<String, dynamic>> login(
    String endpoint,
    Map<String, dynamic> credentials,
  ) async {
    return authenticate(endpoint, credentials);
  }

  // Enhanced register method that handles tokens from response data and cookies
  static Future<Map<String, dynamic>> register(
    String endpoint,
    Map<String, dynamic> registrationData,
  ) async {
    return authenticate(endpoint, registrationData);
  }

  // Enhanced logout method
  static Future<void> logout([String? logoutEndpoint]) async {
    try {
      if (logoutEndpoint != null && _tokenPair != null) {
        // Send logout request with both tokens
        final cookieHeader = _tokenPair!.refreshToken != null
            ? 'refreshToken=${_tokenPair!.refreshToken}'
            : '';

        await _dio.post(
          logoutEndpoint,
          options: Options(
            headers: cookieHeader.isNotEmpty ? {'Cookie': cookieHeader} : null,
          ),
        );
      }
    } catch (e) {
      // Ignore logout errors - we'll clear tokens anyway
      if (kDebugMode) {
        print('⚠️ Logout request failed: $e');
      }
    } finally {
      await _clearTokens();
      _authEventListener?.onUnauthorized();
    }
  }

  // Handle successful responses
  static ApiResponse<T> _handleResponse<T>(
    Response response,
    T Function(dynamic)? fromJson,
  ) {
    final data = response.data;

    if (fromJson != null && data != null) {
      return ApiResponse.success(
        fromJson(data),
        statusCode: response.statusCode,
      );
    }

    return ApiResponse.success(data as T, statusCode: response.statusCode);
  }

  // Handle errors and convert them to appropriate exceptions
  static ApiException _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return TimeoutException(
            'Request timeout. Please check your connection.',
          );

        case DioExceptionType.connectionError:
          return NetworkException(
            'No internet connection. Please check your network.',
          );

        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          final message = _getErrorMessage(error.response?.data);

          switch (statusCode) {
            case 401:
              if (error.requestOptions.path.contains(_refreshEndpoint ?? '')) {
                return TokenExpiredException('Refresh token expired');
              }
              return UnauthorizedException(
                'Unauthorized access. Please login again.',
              );
            case 403:
              return ServerException(
                'Access forbidden.',
                statusCode: statusCode,
              );
            case 404:
              return ServerException(
                'Resource not found.',
                statusCode: statusCode,
              );
            case 422:
              return ServerException(
                message ?? 'Validation failed.',
                statusCode: statusCode,
              );
            case 500:
              return ServerException(
                'Internal server error. Please try again later.',
                statusCode: statusCode,
              );
            default:
              return ServerException(
                message ?? 'Something went wrong. Please try again.',
                statusCode: statusCode,
                data: error.response?.data,
              );
          }

        case DioExceptionType.cancel:
          return ApiException('Request was cancelled.');

        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            return NetworkException('No internet connection.');
          }
          if (error.error is TokenExpiredException) {
            return error.error as TokenExpiredException;
          }
          return ApiException('An unexpected error occurred: ${error.message}');

        default:
          return ApiException('An unexpected error occurred.');
      }
    }

    return ApiException('An unexpected error occurred: $error');
  }

  // Extract error message from response data
  static String? _getErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      if (data.containsKey('error') && data['error'] is Map) {
        final errors = data['error'] as Map<String, dynamic>;
        final firstError = errors.values.first;
        if (firstError is List && firstError.isNotEmpty) {
          return firstError.first.toString();
        }
        return firstError.toString();
      }

      if (data.containsKey("message") && data["message"] is String) {
        return data["message"] as String;
      }
    }
    return null;
  }

  static Dio get instance => _dio;
}
