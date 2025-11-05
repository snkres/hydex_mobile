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
}
