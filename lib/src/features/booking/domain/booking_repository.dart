import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/network/network.dart';
import 'package:hydex/src/features/booking/data/booking.dart';
import 'package:hydex/src/features/booking/domain/guests_repo.dart';
import 'package:hydex/src/features/booking/ui/components/guests_container.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_repository.g.dart';

class BookingRepository {
  Future<String> cancelBooking({required String id}) async {
    try {
      final response = await DioHelper.patch("/bookings/$id/cancel");
      if (response.success) {
        return response.data["message"];
      }
      throw Exception("Couldn't cancel booking");
    } catch (e) {
      rethrow;
    }
  }
}

@riverpod
Future<List<Booking>> getBookings(Ref ref) async {
  try {
    final response = await DioHelper.get("/bookings");
    final responseData = response.data['data'] as List<dynamic>;
    if (responseData.isEmpty ||
        responseData.every((item) => item is Map && item.isEmpty)) {
      return [];
    }

    return responseData.map((e) => BookingMapper.fromMap(e)).toList();
  } catch (e) {
    throw Exception('Failed to load bookings: $e');
  }
}

@riverpod
Future<bool> createBooking(Ref ref) async {
  try {
    final numberOfGuests = ref.read(guestsProvider);
    final guestsFormState = await ref.read(
      guestFormProvider(numberOfGuests).future,
    );
    final guests = guestsFormState.guests;
    final List<Map<String, dynamic>> guestsData = guests
        .map(
          (e) => {
            "fullName": e!.name,
            "email": e.email,
            "phone": e.phoneNumber,
            "age": e.age,
            "gender": e.gender,
            "instagramLink": e.instagram,
          },
        )
        .toList();
    final response = await DioHelper.post(
      "/bookings",
      data: {"guests": guestsData},
    );
    return response.success;
  } catch (e) {
    throw Exception('Failed to load bookings: $e');
  }
}
