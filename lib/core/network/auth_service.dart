import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/network/auth_handler.dart';
import 'package:hydex/core/network/network.dart';
import 'package:hydex/core/network/user/user.dart';
import 'package:hydex/src/features/auth/provider/usertype_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_service.g.dart';

enum AuthEvent { tokenRefreshed, tokenExpired, unauthorized }

class AuthService {
  Ref ref;
  AuthService(this.ref);
  static void initialize() {
    DioHelper.init(
      refreshTokenEndpoint: '/auth/refresh',
      defaultHeaders: {
        'X-App-Version': '0.1.4',
        'X-Platform': Platform.isAndroid ? 'android' : 'ios',
      },
      authEventListener: AuthHandler(),
    );
  }

  // Login and get user profile with enhanced token handling
  Future<User> login(String email, String password) async {
    try {
      // Use the enhanced login method that handles tokens automatically
      final responseData = await DioHelper.login('/auth/login', {
        'identifier': email,
        'password': password,
      });

      // Parse user data from response
      final userData =
          responseData['user'] ?? responseData['data'] ?? responseData;
      final user = UserMapper.fromMap(userData);

      if (kDebugMode) {
        print('✅ Login successful for user: ${user.email}');
        print('🔐 Access token stored from response data');
        print('🍪 Refresh token stored from cookies');
      }

      return user;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Login failed: $e');
      }
      rethrow;
    }
  }

  // Update user profile
  Future<User> updateUser(User user) async {
    try {
      final response = await DioHelper.put<Map<String, dynamic>>(
        '/users/${user.id}',
        data: user.toMap(),
      );

      if (response.success && response.data != null) {
        return UserMapper.fromMap(response.data!);
      } else {
        throw ApiException(response.errorMessage ?? 'Failed to update user');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Verify user
  Future<String> sendOTP(String identifier, OTPType type) async {
    try {
      final response = await DioHelper.post<Map<String, dynamic>>(
        '/auth/send-verification',
        data: {'identifier': identifier, "type": type.name},
      );

      if (response.success && response.data != null) {
        if (type == OTPType.email) {
          ref.read(userNotifierProvider.notifier).create(email: identifier);
        } else {
          ref.read(userNotifierProvider.notifier).create(phone: identifier);
        }
        return response.data?["message"];
      } else {
        throw ApiException(response.errorMessage ?? 'Failed to verify user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> verifyOTP({
    required String otp,
    required String identifier,
  }) async {
    try {
      final response = await DioHelper.post<Map<String, dynamic>>(
        '/auth/verify-identifier',
        data: {'identifier': identifier, "otp": otp},
      );

      if (response.success && response.data != null) {
        return response.data?["message"];
      } else {
        throw ApiException(response.errorMessage ?? 'Failed to verify user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> verifyReferalCode({required String referralCode}) async {
    try {
      final response = await DioHelper.post<Map<String, dynamic>>(
        '/waitlist/check-referral',
        data: {'referralCode': referralCode},
      );

      if (response.success && response.data != null) {
        return response.data?["message"];
      } else {
        throw ApiException(response.errorMessage ?? 'Failed to verify user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> register() async {
    try {
      final user = ref.read(userNotifierProvider);
      final data = {
        "email": user?.email,
        "phone": user?.phone,
        "password": user?.password,
        "fullName": user?.fullName,
        "role": user?.role,
        "gender": user?.gender,
        "nationality": user?.nationality,
        "dateOfBirth": user?.dateOfBirth,
      };
      if (user!.referralCode!.isNotEmpty) {
        data["referralCode"] = user.referralCode;
      }

      final response = await DioHelper.authenticate('/auth/register', data);

      return response.keys.first;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> forgetPassword(String email) async {
    try {
      final response = await DioHelper.post(
        "/auth/forgot-password",
        data: {"email": email},
      );
      if (response.success && response.data != null) {
        return response.data?["message"];
      }
      throw ApiException(response.errorMessage ?? 'Could not forget password');
    } catch (e) {
      rethrow;
    }
  }

  Future<String> resetPassword(String newPassword, String token) async {
    try {
      final response = await DioHelper.post(
        "auth/reset-password",
        data: {"newPassword": newPassword, "token": token},
      );
      if (response.success && response.data != null) {
        return response.data?["message"];
      }
      throw ApiException(response.errorMessage ?? 'Could not forget password');
    } catch (e) {
      rethrow;
    }
  }

  Future<User> currentUser() async {
    try {
      final response = await DioHelper.get("/auth/me");
      if (response.success && response.data != null) {
        print("Success Current User");
        final user = UserMapper.fromMap(response.data['data']['user']);
        return user;
      }
      throw ApiException(response.errorMessage ?? 'Could not forget password');
    } catch (e) {
      rethrow;
    }
  }

  // Delete user
  Future<bool> deleteUser(String userId) async {
    try {
      final response = await DioHelper.delete('/users/$userId');
      return response.success;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await DioHelper.logout('/auth/logout');
    } catch (e) {
      rethrow;
    }
  }
}

final authServiceProvider = Provider<AuthService>(AuthService.new);

@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
  @override
  User? build() {
    return null;
  }

  void setUser(User user) {
    state = user;
  }

  void create({
    String? email,
    String? phone,
    String? referralCode,
    String? fullName,
    String? password,
    String? role,
    String? nationality,
    String? gender,
    String? dateOfBirth,
    String? socialStatus,
    String? instagram,
    String? facebook,
  }) {
    if (state == null) {
      state = User(
        email: email ?? "",
        phone: phone,
        fullName: fullName ?? "",
        gender: gender ?? "",
        nationality: nationality ?? "",
        referralCode: referralCode ?? "",
        password: password ?? "",
        role: role ?? "",
      );
    } else {
      state = state?.copyWith(
        email: email ?? state?.email,
        phone: phone ?? state?.phone,
        fullName: fullName ?? state?.fullName,
        gender: gender ?? state?.gender,
        referralCode: referralCode ?? state?.referralCode,
        nationality: nationality ?? state?.nationality,
        password: password ?? state?.password,
        role: role ?? state?.role,
      );
    }
  }
}

enum OTPType { phone, email }

@Riverpod(keepAlive: true)
Future<User?> currentUser(Ref ref) async {
  final userState = ref.watch(userNotifierProvider);

  if (userState != null) {
    return userState;
  }

  // If no user in state, fetch from auth
  final authNotifier = ref.watch(authServiceProvider);
  return await authNotifier.currentUser();
}
