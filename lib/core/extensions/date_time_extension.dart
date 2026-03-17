import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  /// Formats DateTime to "MMM yyyy" format (e.g., "May 2025")
  String toMonthYear() {
    return DateFormat('MMM yyyy').format(this);
  }
}
