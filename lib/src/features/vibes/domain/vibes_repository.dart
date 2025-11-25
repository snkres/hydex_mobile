import 'dart:developer';

import 'package:flutter/widgets.dart' hide Banner;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/network/network.dart';
import 'package:hydex/src/features/vibes/data/category.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/data/vendor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vibes_repository.g.dart';

class VibesRepository {
  Future<bool> createBooking(
    String eventId,
    String bookingDate,
    int guests,
  ) async {
    try {
      final response = await DioHelper.post(
        '/bookings',
        data: {
          "eventId": eventId,

          "bookingDate": bookingDate,

          "numberOfGuests": guests,
        },
      );
      return response.success;
    } catch (e) {
      throw Exception('Failed to create booking: $e');
    }
  }
}

final vibesProvider = Provider<VibesRepository>((ref) => VibesRepository());

@Riverpod(keepAlive: true)
Future<List<Banner>> getBanners(Ref ref, {required BannerType type}) async {
  try {
    final response = await DioHelper.get(
      '/banners',
      queryParameters: {"type": type.toValue()},
    );
    final eventsData = response.data['data'] as List<dynamic>;
    return eventsData.map((e) => BannerMapper.fromMap(e)).toList();
  } catch (e) {
    throw Exception('Failed to load events: $e');
  }
}

@riverpod
Future<List<EventCategory>> getEventCategories(Ref ref) async {
  try {
    final response = await DioHelper.get('/categories');
    final eventsData = response.data['data'] as List<dynamic>;
    return eventsData.map((e) => EventCategoryMapper.fromMap(e)).toList();
  } catch (e) {
    throw Exception('Failed to load event categories: $e');
  }
}

@riverpod
Future<List<Vendor>> getVendors(Ref ref, {int page = 1}) async {
  try {
    final response = await DioHelper.get(
      '/vendors',
      queryParameters: {"page": page, "limit": 10},
    );
    final answer = response.data['data'] as List<dynamic>;

    final eventsData = answer.first as List<dynamic>;
    log("Vendors Data: ${eventsData.first}");

    return eventsData.map((e) => VendorMapper.fromMap(e)).toList();
  } catch (e) {
    throw Exception('Failed to load vendors: $e');
  }
}

@riverpod
Future<List<Event>> getEvents(Ref ref, {int page = 1}) async {
  try {
    final response = await DioHelper.get(
      '/events',
      queryParameters: {"page": page, "limit": 10},
    );
    final answer = response.data['data'] as List<dynamic>;

    final eventsData = answer.first as List<dynamic>;
    return eventsData.map((e) => EventMapper.fromMap(e)).toList();
  } catch (e) {
    throw Exception('Failed to load events: $e');
  }
}

@riverpod
Future<Event> getEventById(Ref ref, {required String id}) async {
  try {
    final response = await DioHelper.get('/events/$id');
    final answer = response.data['data'] as Map<String, dynamic>;

    return EventMapper.fromMap(answer);
  } catch (e) {
    throw Exception('Failed to load events: $e');
  }
}

@riverpod
Future<Vendor> getVendorbyID(Ref ref, {required String id}) async {
  try {
    final response = await DioHelper.get('/vendors/$id');
    final answer = response.data['data'] as Map<String, dynamic>;

    return VendorMapper.fromMap(answer);
  } catch (e) {
    throw Exception('Failed to load events: $e');
  }
}
