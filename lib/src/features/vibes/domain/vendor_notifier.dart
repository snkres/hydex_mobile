import 'package:hydex/src/features/vibes/data/vendor.dart';
import 'package:hydex/src/features/vibes/domain/vibes_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vendor_notifier.g.dart';

@riverpod
class VendorNotifier extends _$VendorNotifier {
  @override
  FutureOr<Vendor> build(String id) async {
    final vendor = await ref.watch(getVendorbyIDProvider(id: id).future);
    return vendor;
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
