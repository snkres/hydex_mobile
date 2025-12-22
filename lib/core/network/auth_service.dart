import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/network/network.dart';
import 'package:hydex/core/network/user/user.dart';
import 'package:hydex/core/notification/notification.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_service.g.dart';

enum AuthEvent { tokenRefreshed, tokenExpired, unauthorized }

class AuthService {
  Ref ref;
  AuthService(this.ref);
  static void initialize() {
    DioHelper().init();
  }

  Future<void> login(String email, String password) async {
    try {
      // Use the enhanced login method that handles tokens automatically
      final responseData = await DioHelper.authenticate('/auth/login', {
        'identifier': email,
        'password': password,
      });

      // Parse user data from response
      final userData = responseData['data']['user'] as Map<String, dynamic>;
      final user = UserMapper.fromMap(userData);
      ref.read(userProvider.notifier).setUser(user);
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
          ref.read(userProvider.notifier).create(email: identifier);
        } else {
          ref.read(userProvider.notifier).create(phone: identifier);
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

  Future<bool> createProfile() async {
    final user = ref.read(userProvider);
    final data = _getOnboardingData(user!);
    final response = await DioHelper.post<Map<String, dynamic>>(
      '/onboarding',
      data: data,
    );

    return response.success;
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
      final user = ref.read(userProvider);
      final data = {
        "email": user?.email,
        "phone": user?.phone,
        "password": user?.password,
        "fullName": user?.fullName,
        "role": user?.role.toValue(),
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

  Future<String> forgetPassword(String identifier, OTPType type) async {
    try {
      final response = await DioHelper.post(
        "/auth/forgot-password",
        data: {"identifier": identifier, "type": type.name},
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
        "/auth/reset-password",
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
        final user = UserMapper.fromMap(response.data['data']['user']);
        return user;
      }
      throw ApiException(response.errorMessage ?? 'Could not forget password');
    } catch (e) {
      rethrow;
    }
  }

  // Delete user
  Future<bool> deleteUser() async {
    try {
      final response = await DioHelper.delete('/auth/me');
      if (response.success) {
        DioHelper.clearTokens();
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await DioHelper.logout('/auth/logout');
      DioHelper.clearTokens();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendFCMNotification() async {
    try {
      final deviceToken = await FirebaseNotifications().getToken();
      final data = {
        "token": deviceToken,
        "platform": Platform.isAndroid ? "ANDROID" : "IOS",
      };
      await DioHelper.post('/notifications/register-device', data: data);
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _getOnboardingData(User user) {
    final socialLinks = user.socialLinks != null
        ? {
            "facebook": user.socialLinks!.facebook,
            "instagram": user.socialLinks!.instagram,
            "website": user.socialLinks!.website,
          }
        : null;
    switch (user.role) {
      case Role.seeker:
        return {
          "preferences": {
            "interests": user.interests,
            "preferredCountry": user.preferredCountry,

            "preferredAreas": user.areas,

            "groupSize": user.groupSize,
          },

          "socialLinks": socialLinks,
        };
      case Role.ambassador:
        return {
          "preferences": {
            "contentNiches": user.contentNiches,

            "audienceSizeRange": user.audienceSizeRange,

            "cityOfPrimaryActivity": user.preferredCountry,

            "contentTypes": ["videos", "photos", "stories"],

            "collaborationPreferences": {
              "preferredBrands": ["luxury", "fashion", "food"],

              "minimumEngagement": 3.5,
            },
          },

          "socialLinks": socialLinks,
        };
      case Role.owner:
        return {
          "businessName": user.businessName,

          "website": user.socialLinks?.website,
        };
      default:
        return {};
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
    Role? role,
    String? nationality,
    String? gender,
    String? dateOfBirth,
    String? socialStatus,
    String? instagram,
    String? facebook,
    List<String>? interests,
    List<String>? contentNiches,
    String? audienceSizeRange,
    String? groupSize,
    String? preferredCountry,
    String? businessName,
    List<String>? areas,
  }) {
    if (state == null) {
      state = User(
        email: email ?? "",
        phone: phone,
        status: UserStatus.pending,
        fullName: fullName ?? "",
        gender: gender ?? "",
        nationality: nationality ?? "",
        referralCode: referralCode ?? "",
        password: password ?? "",
        role: role ?? Role.seeker,
        interests: interests,
        contentNiches: contentNiches,
        audienceSizeRange: audienceSizeRange,
        groupSize: groupSize,
        preferredCountry: preferredCountry,
        businessName: businessName,
        areas: areas,
        dateOfBirth: dateOfBirth != null
            ? DateTime.tryParse(dateOfBirth)
            : null,
        socialLinks: SocialLinks(
          instagram: instagram,
          facebook: facebook,
          website: instagram,
        ),
      );
    } else {
      state = state?.copyWith(
        email: email ?? state?.email,
        status: UserStatus.pending,
        phone: phone ?? state?.phone,
        fullName: fullName ?? state?.fullName,
        gender: gender ?? state?.gender,
        dateOfBirth: dateOfBirth != null
            ? DateTime.tryParse(dateOfBirth)
            : state?.dateOfBirth,
        interests: interests ?? state?.interests,
        contentNiches: contentNiches ?? state?.contentNiches,
        audienceSizeRange: audienceSizeRange ?? state?.audienceSizeRange,
        groupSize: groupSize ?? state?.groupSize,
        preferredCountry: preferredCountry ?? state?.preferredCountry,
        businessName: businessName ?? state?.businessName,
        areas: areas ?? state?.areas,

        socialLinks: SocialLinks(
          instagram: instagram ?? state?.socialLinks?.instagram,
          facebook: facebook ?? state?.socialLinks?.facebook,
          website: instagram ?? state?.socialLinks?.website,
        ),
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
  final userState = ref.read(userProvider);
  if (userState != null) {
    return userState;
  }

  // If no user in state, fetch from auth
  final authNotifier = ref.read(authServiceProvider);
  return await authNotifier.currentUser();
}
