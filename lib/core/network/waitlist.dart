import 'package:dart_mappable/dart_mappable.dart';

part 'waitlist.mapper.dart';

@MappableClass()
class WaitlistResponse with WaitlistResponseMappable {
  final String originalPosition;
  final String referralCode;

  WaitlistResponse({
    required this.referralCode,
    required this.originalPosition,
  });
}
