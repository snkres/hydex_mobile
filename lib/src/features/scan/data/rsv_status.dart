import 'package:flutter/material.dart';

enum RsvStatus {
  pending(
    label: 'Pending Approval',
    subLabel: 'Review the reservation details and take action.',
    svgPath: 'img/svg/pending.svg',
    backgroundColor: Color(0xff302617),
    textColor: Color(0xffffb020),
  ),
  confirmed(
    label: 'Confirmed',
    subLabel: 'This is an upcoming guest',
    svgPath: 'img/svg/rsv_correct.svg',
    backgroundColor: Color(0xff172921),
    textColor: Color(0xff2ecc71),
  ),
  cancelled(
    label: 'Cancelled',
    subLabel: 'This booking has been cancelled',
    svgPath: 'img/svg/cancelled.svg',
    backgroundColor: Color(0xff1e1e20),
    textColor: Color(0xff89898f),
  ),
  noShow(
    label: 'No Entry',
    subLabel: 'Customer did not enter',
    svgPath: 'img/svg/no_entry.svg',
    backgroundColor: Color(0xff301113),
    textColor: Color(0xffff0003),
  ),
  rejected(
    label: 'Rejected',
    subLabel: "You've declined this booking.",
    svgPath: 'img/svg/rejected.svg',
    backgroundColor: Color(0xff301113),
    textColor: Color(0xffff0003),
  ),
  entered(
    label: 'Entered',
    subLabel: 'Customer checked in successfully.',
    svgPath: 'img/svg/enterred.svg',
    backgroundColor: Color(0xff1f1037),
    textColor: Color(0xffa25bff),
  );

  const RsvStatus({
    required this.label,
    required this.subLabel,
    required this.svgPath,
    required this.backgroundColor,
    required this.textColor,
  });

  final String label;
  final String subLabel;
  final String? svgPath;
  final Color backgroundColor;
  final Color textColor;
}
