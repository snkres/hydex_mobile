import 'package:flutter/material.dart';
import 'package:hydex/src/features/profile/ui/components/upcoming_event.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: ListView.separated(
        separatorBuilder: (_, _) => Divider(),
        itemCount: 3,
        itemBuilder: (context, index) => UpcomingEventContainer(),
      ),
    );
  }
}
