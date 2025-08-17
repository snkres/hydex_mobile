import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/network/network.dart';

class AuthHandler implements AuthEventListener {
  static final AuthHandler _instance = AuthHandler._internal();
  factory AuthHandler() => _instance;
  AuthHandler._internal();

  final StreamController<AuthEvent> _authEventController =
      StreamController<AuthEvent>.broadcast();
  Stream<AuthEvent> get authEvents => _authEventController.stream;

  @override
  void onTokenRefreshed(TokenPair newTokens) {
    print('✅ Token refreshed successfully');
    _authEventController.add(AuthEvent.tokenRefreshed);
    _saveTokensToStorage(newTokens);
  }

  @override
  void onTokenRefreshFailed() {
    print('❌ Token refresh failed');
    _authEventController.add(AuthEvent.tokenExpired);
    _clearStoredTokens();
  }

  @override
  void onUnauthorized() {
    print('🚫 Unauthorized access');
    _authEventController.add(AuthEvent.unauthorized);
    _clearStoredTokens();
  }

  void _saveTokensToStorage(TokenPair tokens) {
    FlutterSecureStorage().write(
      key: 'auth_tokens',
      value: jsonEncode(tokens.toJson()),
    );
  }

  void _clearStoredTokens() {
    FlutterSecureStorage().delete(key: 'auth_tokens');
  }

  void dispose() {
    _authEventController.close();
  }
}
