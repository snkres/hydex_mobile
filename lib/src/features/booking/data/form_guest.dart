
import 'package:hydex/src/features/booking/data/guest.dart';

class GuestFormState {
  final List<Guest?> guests;   // length = number of total guests
  final int currentIndex;

  GuestFormState({
    required this.guests,
    required this.currentIndex,
  });

  GuestFormState copyWith({
    List<Guest?>? guests,
    int? currentIndex,
  }) {
    return GuestFormState(
      guests: guests ?? this.guests,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
