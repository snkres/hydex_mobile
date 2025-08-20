import 'package:hydex/core/network/network.dart';
import 'package:hydex/core/network/waitlist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final waitlistProvider = FutureProvider<WaitlistResponse>((ref) async {
  try {
    final response = await DioHelper.get<Map<String, dynamic>>(
      '/waitlist/position',
    );

    if (response.success && response.data != null) {
      final data = response.data?["data"];
      return WaitlistResponseMapper.fromJson(data);
    } else {
      throw ApiException(response.errorMessage ?? 'Failed to verify user');
    }
  } catch (e) {
    rethrow;
  }
});
