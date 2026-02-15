import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/network/network.dart';
import 'package:hydex/src/features/booking/data/booking.dart';
import 'package:hydex/src/features/booking/data/create_book.dart';
import 'package:hydex/src/features/booking/data/format_time.dart';
import 'package:hydex/src/features/booking/domain/guests_repo.dart';
import 'package:hydex/src/features/booking/ui/components/guests_container.dart';
import 'package:intl/intl.dart';
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
  final numberOfGuests = ref.read(guestsProvider);

  final guestsFormState = await ref.read(
    guestFormProvider(numberOfGuests).future,
  );

  final booking = ref.watch(createBookProvider);
  final isVendor = booking?.isVendor ?? false;

  final formGuests = guestsFormState.guests;

  final guests = formGuests.skip(1).toList();

  final List<Map<String, dynamic>> guestsData = guests.map((e) {
    final guestMap = {
      "fullName": e!.name,
      "email": e.email,
      "phone": e.phoneNumber,
      "age": e.age,
      "gender": e.gender,
    };

    if (e.instagram != null && e.instagram!.isNotEmpty) {
      guestMap["instagramLink"] = e.instagram!;
    }

    return guestMap;
  }).toList();

  final data = {"guests": guestsData, "passId": booking!.selectedPasses?.id};
  if (isVendor) {
    data["date"] = booking.selectedDate?.toIso8601String();
    data["timeSlot"] = booking.selectedSlot?.toFullTime();
  }
  log(data.toString());

  final response = await DioHelper.post("/bookings", data: data);
  log(response.toString());
  return response.success;
}

final totalPriceProvider = Provider<double>((ref) {
  // Watch the dependencies: the selected pass and the guest count
  final selectedPass = ref.watch(
    // Changed to watch for recalculation if selectedPass changes
    createBookProvider.select((v) => v?.selectedPasses),
  );
  final guestCount = ref.watch(guestsProvider);

  double totalPrice = 0;

  // Perform the calculation only if a pass is selected and count is > 0
  if (selectedPass != null && guestCount > 0) {
    // 1. Calculate the base price
    final passPrice = selectedPass.price;
    double basePrice = passPrice * guestCount;

    final discountPercentage = selectedPass.discountPercentage ?? 0.0;

    final discountMultiplier = 1.0 - (discountPercentage / 100.0);

    // 4. Apply the discount to the base price
    totalPrice = basePrice * discountMultiplier;
  }

  return totalPrice;
});

final formattedTotalPriceProvider = Provider<String>((ref) {
  final rawPrice = ref.watch(totalPriceProvider);

  // Replace 'en_US' with your desired locale if different.
  final formatter = NumberFormat('#,##0', 'en_US');
  return formatter.format(rawPrice);
});

@riverpod
Future<bool> cancelBooking(
  Ref ref, {
  required String id,
  required String reason,
}) async {
  try {
    final response = await DioHelper.patch(
      "/bookings/$id/cancel",
      data: {"cancellationReason": reason},
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (e) {
    throw Exception('Failed to load bookings: $e');
  }
}
