import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/domain/vibes_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_notifier.g.dart';

@riverpod
class EventNotifier extends _$EventNotifier {
  @override
  FutureOr<Event> build(String id) async {
    final event = await ref.watch(getEventByIdProvider(id: id).future);
    return event;
  }

  Future<void> toggleFavorite() async {
    final currentEvent = state.value;
    if (currentEvent == null) return;

    final isFavorited = currentEvent.isFavorited;
    final updatedEvent = currentEvent.copyWith(isFavorited: !isFavorited);

    // Update the state optimistically
    state = AsyncData(updatedEvent);

    try {
      // await ref.read(vibesRepositoryProvider).updateFavoriteStatus(
      //       eventId: currentEvent.id,
      //       isFavorited: !isFavorited,
      //     );
    } catch (e) {
      // If there's an error, revert the state
      state = AsyncData(currentEvent);
      rethrow;
    }
  }
}
