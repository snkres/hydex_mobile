// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getProfile)
const getProfileProvider = GetProfileProvider._();

final class GetProfileProvider
    extends $FunctionalProvider<AsyncValue<Profile>, Profile, FutureOr<Profile>>
    with $FutureModifier<Profile>, $FutureProvider<Profile> {
  const GetProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getProfileHash();

  @$internal
  @override
  $FutureProviderElement<Profile> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Profile> create(Ref ref) {
    return getProfile(ref);
  }
}

String _$getProfileHash() => r'e6dda16483cc30628eb6557c1a737617bf12bea8';

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

String _$getUpcomingEventsHash() => r'ae2f01741823d18b74344133c922d7a8ff65e69f';

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

String _$getHistoryHash() => r'cd9043f5704895ac5bf579336d7ac4dfed878070';

@ProviderFor(getPassport)
const getPassportProvider = GetPassportProvider._();

final class GetPassportProvider
    extends
        $FunctionalProvider<
          AsyncValue<PassportData>,
          PassportData,
          FutureOr<PassportData>
        >
    with $FutureModifier<PassportData>, $FutureProvider<PassportData> {
  const GetPassportProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPassportProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPassportHash();

  @$internal
  @override
  $FutureProviderElement<PassportData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PassportData> create(Ref ref) {
    return getPassport(ref);
  }
}

String _$getPassportHash() => r'00e4300fbd097a4dd3c52a72c9452361e0533b1b';
