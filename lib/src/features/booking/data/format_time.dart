import 'package:intl/intl.dart';

extension FormatTime on DateTime {
  String formatDate() {
    final DateFormat formatter = DateFormat('EEE, d MMM');
    String formatted = formatter.format(this);
    return formatted;
  }

  String formatDateTime() {
    return DateFormat('d MMM, h:mm a').format(this);
  }

  String toPrettyString() {
    const weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final weekdayStr = weekDays[weekday - 1];
    final monthStr = months[month - 1];

    final hour12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);

    final minuteStr = minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? "PM" : "AM";

    return "$weekdayStr, $day $monthStr, $hour12:$minuteStr$period";
  }
}
