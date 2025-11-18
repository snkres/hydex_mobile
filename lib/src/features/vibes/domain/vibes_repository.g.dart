// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vibes_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getBanners)
const getBannersProvider = GetBannersFamily._();

final class GetBannersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Banner>>,
          List<Banner>,
          FutureOr<List<Banner>>
        >
    with $FutureModifier<List<Banner>>, $FutureProvider<List<Banner>> {
  const GetBannersProvider._({
    required GetBannersFamily super.from,
    required BannerType super.argument,
  }) : super(
         retry: null,
         name: r'getBannersProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getBannersHash();

  @override
  String toString() {
    return r'getBannersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Banner>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Banner>> create(Ref ref) {
    final argument = this.argument as BannerType;
    return getBanners(ref, type: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetBannersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getBannersHash() => r'c95a267fb110cf92f9d2d1e9d8fdb970e2ec9a78';

final class GetBannersFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Banner>>, BannerType> {
  const GetBannersFamily._()
    : super(
        retry: null,
        name: r'getBannersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  GetBannersProvider call({required BannerType type}) =>
      GetBannersProvider._(argument: type, from: this);

  @override
  String toString() => r'getBannersProvider';
}

@ProviderFor(getEventCategories)
const getEventCategoriesProvider = GetEventCategoriesProvider._();

final class GetEventCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EventCategory>>,
          List<EventCategory>,
          FutureOr<List<EventCategory>>
        >
    with
        $FutureModifier<List<EventCategory>>,
        $FutureProvider<List<EventCategory>> {
  const GetEventCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getEventCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getEventCategoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<EventCategory>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EventCategory>> create(Ref ref) {
    return getEventCategories(ref);
  }
}

String _$getEventCategoriesHash() =>
    r'd272d6434ad7b55a31a0b3c89e1f2fd2334de188';

@ProviderFor(getVendors)
const getVendorsProvider = GetVendorsFamily._();

final class GetVendorsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Vendor>>,
          List<Vendor>,
          FutureOr<List<Vendor>>
        >
    with $FutureModifier<List<Vendor>>, $FutureProvider<List<Vendor>> {
  const GetVendorsProvider._({
    required GetVendorsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'getVendorsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getVendorsHash();

  @override
  String toString() {
    return r'getVendorsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Vendor>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Vendor>> create(Ref ref) {
    final argument = this.argument as int;
    return getVendors(ref, page: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetVendorsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getVendorsHash() => r'1f1458aa0b5f42a6b79e0aba0756f6f148450538';

final class GetVendorsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Vendor>>, int> {
  const GetVendorsFamily._()
    : super(
        retry: null,
        name: r'getVendorsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetVendorsProvider call({int page = 1}) =>
      GetVendorsProvider._(argument: page, from: this);

  @override
  String toString() => r'getVendorsProvider';
}

@ProviderFor(getEvents)
const getEventsProvider = GetEventsFamily._();

final class GetEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Event>>,
          List<Event>,
          FutureOr<List<Event>>
        >
    with $FutureModifier<List<Event>>, $FutureProvider<List<Event>> {
  const GetEventsProvider._({
    required GetEventsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'getEventsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getEventsHash();

  @override
  String toString() {
    return r'getEventsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Event>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Event>> create(Ref ref) {
    final argument = this.argument as int;
    return getEvents(ref, page: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetEventsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getEventsHash() => r'f0c90457b060d89d08b71b8d88dd6e4d3a6ef453';

final class GetEventsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Event>>, int> {
  const GetEventsFamily._()
    : super(
        retry: null,
        name: r'getEventsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetEventsProvider call({int page = 1}) =>
      GetEventsProvider._(argument: page, from: this);

  @override
  String toString() => r'getEventsProvider';
}
