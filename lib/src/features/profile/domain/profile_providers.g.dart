// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getUpcomingEvents)
const getUpcomingEventsProvider = GetUpcomingEventsProvider._();

final class GetUpcomingEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UpcomingEvent>>,
          List<UpcomingEvent>,
          FutureOr<List<UpcomingEvent>>
        >
    with
        $FutureModifier<List<UpcomingEvent>>,
        $FutureProvider<List<UpcomingEvent>> {
  const GetUpcomingEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getUpcomingEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getUpcomingEventsHash();

  @$internal
  @override
  $FutureProviderElement<List<UpcomingEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UpcomingEvent>> create(Ref ref) {
    return getUpcomingEvents(ref);
  }
}

String _$getUpcomingEventsHash() => r'8ee31532a1a1b1b562bcfef3acbf89763e4776d0';

@ProviderFor(getHistory)
const getHistoryProvider = GetHistoryProvider._();

final class GetHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UpcomingEvent>>,
          List<UpcomingEvent>,
          FutureOr<List<UpcomingEvent>>
        >
    with
        $FutureModifier<List<UpcomingEvent>>,
        $FutureProvider<List<UpcomingEvent>> {
  const GetHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getHistoryHash();

  @$internal
  @override
  $FutureProviderElement<List<UpcomingEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UpcomingEvent>> create(Ref ref) {
    return getHistory(ref);
  }
}

String _$getHistoryHash() => r'eccbdb8096a839847a61ababca2401359e61e4f2';
