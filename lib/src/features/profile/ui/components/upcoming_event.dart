import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/data/booking.dart';
import 'package:hydex/src/features/profile/data/upcoming_event.dart';
import 'package:hydex/src/features/profile/domain/profile_providers.dart';
import 'package:hydex/src/features/profile/ui/components/history.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:intl/intl.dart';
import 'package:smooth_corner/smooth_corner.dart';

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
            separatorBuilder: (_, _) =>
                Column(children: [Divider(), SizedBox(height: 16)]),
            itemCount: data.length,
            itemBuilder: (context, index) =>
                HistoryContainer(event: data[index],isHistory: false,),
          ),
        );
      },
      error: (e, s) => Center(child: Text("Error")),
      loading: () => Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
