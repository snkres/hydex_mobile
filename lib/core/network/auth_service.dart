import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/network/auth_handler.dart';
import 'package:hydex/core/network/network.dart';
import 'package:hydex/core/network/user/user.dart';
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
        'X-App-Version': '1.0.0',
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
        'email': email,
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
  Future<String> sendOTP(String phone, OTPType type) async {
    try {
      final response = await DioHelper.post<Map<String, dynamic>>(
        '/auth/send-verification',
        data: {'identifier': phone, "type": type.name},
      );

      if (response.success && response.data != null) {
        ref.read(userNotifierProvider.notifier).create(phone: phone);
        return response.data?["message"];
      } else {
        throw ApiException(response.errorMessage ?? 'Failed to verify user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> verifyOTP({required String otp}) async {
    try {
      final phone = ref.read(userNotifierProvider)?.phone;
      final response = await DioHelper.post<Map<String, dynamic>>(
        '/auth/verify-identifier',
        data: {'identifier': phone, "otp": otp},
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
        "personalInfo": {
          "nationality": user?.personalInfo?.nationality,
          "gender": user?.personalInfo?.gender,
          "dateOfBirth": user?.personalInfo?.dateOfBirth,
          "employmentStatus": user?.personalInfo?.socialStatus,
          "instagram": user?.personalInfo?.instagram ?? "",
          "facebook": user?.personalInfo?.facebook,
        },
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

  // Delete user
  Future<bool> deleteUser(String userId) async {
    try {
      final response = await DioHelper.delete('/users/$userId');
      return response.success;
    } catch (e) {
      rethrow;
    }
  }

  // Logout
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
  UserRegister? build() {
    return null;
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
    final currentState = state;

    // If state is null, create new one
    if (currentState == null) {
      state = UserRegister(
        email: email ?? "",
        phone: phone,
        fullName: fullName ?? "",

        personalInfo: PersonalInfo(
          nationality: nationality ?? "",
          gender: gender ?? "",
          instagram: instagram,
          facebook: facebook,
          dateOfBirth: dateOfBirth ?? "",
          socialStatus: socialStatus ?? "",
        ),
        referralCode: referralCode ?? "",
        password: password ?? "",
        role: role ?? "",
      );
    } else {
      // Update existing state, preserving existing values
      state = currentState.copyWith(
        email: email ?? currentState.email,
        phone: phone ?? currentState.phone,
        fullName: fullName ?? currentState.fullName,
        personalInfo:
            currentState.personalInfo?.copyWith(
              nationality:
                  nationality ?? currentState.personalInfo?.nationality,
              gender: gender ?? currentState.personalInfo?.gender,
              instagram: instagram ?? currentState.personalInfo?.instagram,
              facebook: facebook ?? currentState.personalInfo?.facebook,
              dateOfBirth:
                  dateOfBirth ?? currentState.personalInfo?.dateOfBirth,
              socialStatus:
                  socialStatus ?? currentState.personalInfo?.socialStatus,
            ) ??
            PersonalInfo(
              nationality: nationality ?? "",
              gender: gender ?? "",
              dateOfBirth: dateOfBirth ?? "",
              socialStatus: socialStatus ?? "",
            ),
        referralCode: referralCode ?? currentState.referralCode,
        password: password ?? currentState.password,
        role: role ?? currentState.role,
      );
    }
  }
}

enum OTPType { phone, email }
