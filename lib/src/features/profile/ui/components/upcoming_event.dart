import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/src/features/profile/domain/profile_providers.dart';
import 'package:hydex/src/features/profile/ui/components/history.dart';

class UpcomingEventSection extends ConsumerWidget {
  const UpcomingEventSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingEvents = ref.watch(getUpcomingEventsProvider);
    return upcomingEvents.when(
      data: (data) {
        if (data.isEmpty) {
          return Center(child: Text("No Upcoming Event"));
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.separated(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 80,
            ),

            separatorBuilder: (_, _) =>
                Column(children: [Divider(), SizedBox(height: 16)]),
            itemCount: data.length,
            itemBuilder: (context, index) =>
                HistoryContainer(event: data[index], isHistory: false),
          ),
        );
      },
      error: (e, s) {
        log("UpcomingEVent Error", error: e, stackTrace: s);
        return Center(child: Text("Error"));
      },
      loading: () => Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
