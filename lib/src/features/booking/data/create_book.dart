import 'package:flutter_riverpod/legacy.dart';
import 'package:hydex/src/features/vibes/data/event.dart';

class CreateBook {
  final String name;
  final List<Passes> passes;
  final DateTime? startTime;
  final Map<String, OperatingHours>? operatingHours;

  CreateBook({
    required this.name,
    required this.passes,
    this.startTime,
    this.operatingHours,
  });
}

final createBookProvider = StateProvider<CreateBook?>((ref) => null);
