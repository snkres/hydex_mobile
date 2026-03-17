import 'dart:developer';

import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/network/user/user.dart';
import 'package:hydex/src/features/booking/data/form_guest.dart';
import 'package:hydex/src/features/booking/data/guest.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'guests_repo.g.dart';

@Riverpod(keepAlive: true)
class GuestFormNotifier extends _$GuestFormNotifier {
  @override
  Future<GuestFormState> build(int totalGuests) async {
    final user = await ref.watch(currentUserProvider.future);

    final guests = List<Guest?>.filled(totalGuests, null);
    guests[0] = user?.toGuest();

    return GuestFormState(guests: guests, currentIndex: 0);
  }

  Future<void> saveGuest(Guest guest, {int? selectedIndex}) async {
    if (state.isLoading) {
      await future; 
    }
    final current = state.requireValue;
    log(
      "Guest: ${guest.name}, Index: ${selectedIndex ?? current.currentIndex}",
    );
    final index = selectedIndex ?? (current.currentIndex + 1);
    log("Saving guest at index: $index");
    final updatedGuests = [...current.guests];
    updatedGuests[index] = guest;
    log("updatedGuests: ${updatedGuests.map((e) => e?.name).toList()}");

    state = AsyncData(current.copyWith(guests: updatedGuests));
  }

  void next() {
    final current = state.value;
    if (current == null) return;

    if (current.currentIndex < current.guests.length - 1) {
      state = AsyncData(
        current.copyWith(currentIndex: current.currentIndex + 1),
      );
    }
  }

  void back() {
    final current = state.value;
    if (current == null) return;

    if (current.currentIndex > 0) {
      state = AsyncData(
        current.copyWith(currentIndex: current.currentIndex - 1),
      );
    }
  }
}
