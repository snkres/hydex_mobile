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

@ProviderFor(getEventById)
const getEventByIdProvider = GetEventByIdFamily._();

final class GetEventByIdProvider
    extends $FunctionalProvider<AsyncValue<Event>, Event, FutureOr<Event>>
    with $FutureModifier<Event>, $FutureProvider<Event> {
  const GetEventByIdProvider._({
    required GetEventByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'getEventByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getEventByIdHash();

  @override
  String toString() {
    return r'getEventByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Event> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Event> create(Ref ref) {
    final argument = this.argument as String;
    return getEventById(ref, id: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetEventByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getEventByIdHash() => r'3eb6110a41d26f41c26f49528e8669a1e46d40f3';

final class GetEventByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Event>, String> {
  const GetEventByIdFamily._()
    : super(
        retry: null,
        name: r'getEventByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetEventByIdProvider call({required String id}) =>
      GetEventByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'getEventByIdProvider';
}

@ProviderFor(getVendorbyID)
const getVendorbyIDProvider = GetVendorbyIDFamily._();

final class GetVendorbyIDProvider
    extends $FunctionalProvider<AsyncValue<Vendor>, Vendor, FutureOr<Vendor>>
    with $FutureModifier<Vendor>, $FutureProvider<Vendor> {
  const GetVendorbyIDProvider._({
    required GetVendorbyIDFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'getVendorbyIDProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getVendorbyIDHash();

  @override
  String toString() {
    return r'getVendorbyIDProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Vendor> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Vendor> create(Ref ref) {
    final argument = this.argument as String;
    return getVendorbyID(ref, id: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetVendorbyIDProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getVendorbyIDHash() => r'e4e049920d70ccb1895699d1ea670684d339f892';

final class GetVendorbyIDFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Vendor>, String> {
  const GetVendorbyIDFamily._()
    : super(
        retry: null,
        name: r'getVendorbyIDProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetVendorbyIDProvider call({required String id}) =>
      GetVendorbyIDProvider._(argument: id, from: this);

  @override
  String toString() => r'getVendorbyIDProvider';
}

@ProviderFor(getEventByVendor)
const getEventByVendorProvider = GetEventByVendorFamily._();

final class GetEventByVendorProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Event>>,
          List<Event>,
          FutureOr<List<Event>>
        >
    with $FutureModifier<List<Event>>, $FutureProvider<List<Event>> {
  const GetEventByVendorProvider._({
    required GetEventByVendorFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'getEventByVendorProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getEventByVendorHash();

  @override
  String toString() {
    return r'getEventByVendorProvider'
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
    final argument = this.argument as String;
    return getEventByVendor(ref, vendorID: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetEventByVendorProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getEventByVendorHash() => r'ea659d065c21b978eeb3dcb222454a79fe1d26f1';

final class GetEventByVendorFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Event>>, String> {
  const GetEventByVendorFamily._()
    : super(
        retry: null,
        name: r'getEventByVendorProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetEventByVendorProvider call({required String vendorID}) =>
      GetEventByVendorProvider._(argument: vendorID, from: this);

  @override
  String toString() => r'getEventByVendorProvider';
}
