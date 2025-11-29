import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/src/features/profile/domain/profile_providers.dart';
import 'package:hydex/src/features/profile/ui/components/upcoming_event.dart';


class History extends ConsumerWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(getHistoryProvider);
    return history.when(
      data: (data) {
        if (data.isEmpty) {
          return Center(child: Text("Empty History"));
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: ListView.separated(
            separatorBuilder: (_, _) =>
                Column(children: [Divider(), SizedBox(height: 16)]),
            itemCount: data.length,
            itemBuilder: (context, index) =>
                UpcomingEventContainer(event: data[index]),
          ),
        );
      },
      error: (e, s) => Center(child: Text("Error")),
      loading: () => Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
