import 'package:hydex/src/features/booking/data/form_guest.dart';
import 'package:hydex/src/features/booking/data/guest.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'guests_repo.g.dart';

@Riverpod(keepAlive: true)
class GuestFormNotifier extends _$GuestFormNotifier {
  @override
  GuestFormState build(int totalGuests) {
    return GuestFormState(
      guests: List.filled(totalGuests, null),
      currentIndex: 0,
    );
  }

  void saveGuest(Guest guest, {int? selectedIndex}) {
    final updated = [...state.guests];

    if (selectedIndex != null) {
      updated[selectedIndex] = guest;
      state = state.copyWith(guests: updated);
      return;
    }
    updated[state.currentIndex] = guest;
    state = state.copyWith(guests: updated);
  }

  void next() {
    if (state.currentIndex < state.guests.length - 1) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    }
  }

  void back() {
    if (state.currentIndex > 0) {
      state = state.copyWith(currentIndex: state.currentIndex - 1);
    }
  }
}
