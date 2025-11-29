import 'dart:developer';

import 'package:hydex/core/network/network.dart';
import 'package:hydex/src/features/profile/data/upcoming_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'profile_providers.g.dart';

@riverpod
Future<List<UpcomingEvent>> getUpcomingEvents(Ref ref) async {
  try {
    final response = await DioHelper.get("/profile/upcoming");
    final data = response.data['data'] as List<dynamic>;

    return data.map((e)=> UpcomingEventMapper.fromMap(e)).toList();
  } catch (e) {
    throw Exception('Failed to load upcoming events: $e');
  }
}



@riverpod
Future<List<UpcomingEvent>> getHistory(Ref ref) async {
  try {
    final response = await DioHelper.get("/profile/history");
    final data = response.data['data'] as List<dynamic>;
    return data.map((e)=> UpcomingEventMapper.fromMap(e)).toList();
  } catch (e) {
    throw Exception('Failed to load upcoming events: $e');
  }
}
