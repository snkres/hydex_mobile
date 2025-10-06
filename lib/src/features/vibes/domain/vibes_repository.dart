import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/network/network.dart';
import 'package:hydex/src/features/vibes/data/category.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
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
Future<List<Event>> getEvents(Ref ref, {required EventType type}) async {
  try {
    final response = await DioHelper.get(
      '/banners',
      queryParameters: {"type": type.toValue()},
    );
    final eventsData = response.data['data'] as List<dynamic>;
    return eventsData.map((e) => EventMapper.fromMap(e)).toList();
  } catch (e) {
    throw Exception('Failed to load events: $e');
  }
}

@riverpod
Future<Event> getEventByID(Ref ref, {required String id}) async {
  try {
    final response = await DioHelper.get('/events/$id');
    return EventMapper.fromMap(response.data['data']);
  } catch (e) {
    throw Exception('Failed to load event: $e');
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
