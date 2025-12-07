import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/src/features/vibes/data/event.dart';

class CreateBook {
  final String name;
  final List<Passes> passes;
  final DateTime? startTime, selectedDate, selectedSlot;
  final List<DateTime> operatingHours;
  final bool requiresApproval;
  final Passes? selectedPasses;
  final String location;
  final String image;

  CreateBook({
    required this.name,
    required this.passes,
    required this.image,

    required this.location,
    this.startTime,
    this.operatingHours = const [],
    this.requiresApproval = false,
    this.selectedDate,
    this.selectedSlot,
    this.selectedPasses,
  });

  CreateBook copyWith({
    String? name,
    List<Passes>? passes,
    DateTime? startTime,
    List<DateTime>? operatingHours,
    bool? requiresApproval,
    DateTime? selectedDate,
    Passes? selectedPasses,
    DateTime? selectedSlot,
    String? location,
    bool clearSelectedPass = false,
    String? image,
  }) {
    return CreateBook(
      location: location ?? this.location,
      name: name ?? this.name,
      passes: passes ?? this.passes,
      startTime: startTime ?? this.startTime,
      operatingHours: operatingHours ?? this.operatingHours,
      requiresApproval: requiresApproval ?? this.requiresApproval,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedSlot: selectedSlot ?? this.selectedSlot,
      image: image ?? this.image,
      selectedPasses: clearSelectedPass
          ? null
          : (selectedPasses ?? this.selectedPasses),
    );
  }

  bool get isEvent => startTime != null && operatingHours.isEmpty;

  bool get isVendor => operatingHours.isNotEmpty;
}

class CreateBookNotifier extends Notifier<CreateBook?> {
  @override
  CreateBook? build() => null;

  void clearSelectedPass() {
    state = state?.copyWith(clearSelectedPass: true);
  }

  void updateBook(CreateBook? newBook) {
    state = newBook;
  }

  void selectPasses(Passes? pass) {
    state = state?.copyWith(selectedPasses: pass);
  }

  void addDates(DateTime? selectedSlot, DateTime? selectedDate) {
    state = state?.copyWith(
      selectedDate: selectedDate,
      selectedSlot: selectedSlot,
    );
  }
}

final createBookProvider = NotifierProvider<CreateBookNotifier, CreateBook?>(
  CreateBookNotifier.new,
);
