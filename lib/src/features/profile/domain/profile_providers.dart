import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hydex/core/network/network.dart';
import 'package:hydex/src/features/profile/data/upcoming_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'profile_providers.g.dart';

@riverpod
Future<List<UpcomingEvent>> getUpcomingEvents(Ref ref) async {
  final link = ref.keepAlive();
  Timer? timer;
  final cancelToken = CancelToken();
  ref.onDispose(() {
    timer?.cancel();
    cancelToken.cancel();
  });
  ref.onCancel(() {
    timer = Timer(const Duration(seconds: 30), () {
      link.close();
    });
  });
  ref.onResume(() {
    timer?.cancel();
  });
  try {
    final response = await DioHelper.get(
      "/profile/upcoming",
      cancelToken: cancelToken,
    );
    final data = response.data['data'] as List<dynamic>;

    return data.map((e) => UpcomingEventMapper.fromMap(e)).toList();
  } catch (e) {
    throw Exception('Failed to load upcoming events: $e');
  }
}

@riverpod
Future<List<UpcomingEvent>> getHistory(Ref ref) async {
  final link = ref.keepAlive();
  Timer? timer;
  final cancelToken = CancelToken();
  ref.onDispose(() {
    timer?.cancel();
    cancelToken.cancel();
  });
  ref.onCancel(() {
    timer = Timer(const Duration(seconds: 30), () {
      link.close();
    });
  });
  ref.onResume(() {
    timer?.cancel();
  });
  try {
    final response = await DioHelper.get(
      "/profile/history",
      cancelToken: cancelToken,
    );
    final data = response.data['data'] as List<dynamic>;
    return data.map((e) => UpcomingEventMapper.fromMap(e)).toList();
  } catch (e) {
    throw Exception('Failed to load upcoming events: $e');
  }
}
