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

String _$getBannersHash() => r'7bca1e56a0badd901beb4636e96a84a13bfd6371';

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
        isAutoDispose: false,
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
    r'1841020833a8fab5eb61264b440d45ad3172b643';

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
    required ({
      int page,
      String? categoryId,
      String? subcategoryId,
      String? country,
    })
    super.argument,
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
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Vendor>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Vendor>> create(Ref ref) {
    final argument =
        this.argument
            as ({
              int page,
              String? categoryId,
              String? subcategoryId,
              String? country,
            });
    return getVendors(
      ref,
      page: argument.page,
      categoryId: argument.categoryId,
      subcategoryId: argument.subcategoryId,
      country: argument.country,
    );
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

String _$getVendorsHash() => r'ac190fdc16cfb19e9d7c8a9ee4a3938e72df6a6c';

final class GetVendorsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<Vendor>>,
          ({
            int page,
            String? categoryId,
            String? subcategoryId,
            String? country,
          })
        > {
  const GetVendorsFamily._()
    : super(
        retry: null,
        name: r'getVendorsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetVendorsProvider call({
    int page = 1,
    String? categoryId,
    String? subcategoryId,
    String? country,
  }) => GetVendorsProvider._(
    argument: (
      page: page,
      categoryId: categoryId,
      subcategoryId: subcategoryId,
      country: country,
    ),
    from: this,
  );

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
    required ({
      int page,
      String? categoryId,
      String? subcategoryId,
      bool? happeningTonight,
      bool? nearby,
    })
    super.argument,
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
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Event>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Event>> create(Ref ref) {
    final argument =
        this.argument
            as ({
              int page,
              String? categoryId,
              String? subcategoryId,
              bool? happeningTonight,
              bool? nearby,
            });
    return getEvents(
      ref,
      page: argument.page,
      categoryId: argument.categoryId,
      subcategoryId: argument.subcategoryId,
      happeningTonight: argument.happeningTonight,
      nearby: argument.nearby,
    );
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

String _$getEventsHash() => r'0b3816d06bfba71b7886462edd8a2341de4feb10';

final class GetEventsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<Event>>,
          ({
            int page,
            String? categoryId,
            String? subcategoryId,
            bool? happeningTonight,
            bool? nearby,
          })
        > {
  const GetEventsFamily._()
    : super(
        retry: null,
        name: r'getEventsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetEventsProvider call({
    int page = 1,
    String? categoryId,
    String? subcategoryId,
    bool? happeningTonight,
    bool? nearby,
  }) => GetEventsProvider._(
    argument: (
      page: page,
      categoryId: categoryId,
      subcategoryId: subcategoryId,
      happeningTonight: happeningTonight,
      nearby: nearby,
    ),
    from: this,
  );

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

String _$getEventByIdHash() => r'4540a31ce6c349588bdf8dba392937ce5c738a9e';

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

String _$getVendorbyIDHash() => r'43d2db302eff0d6f3426f0da7e9909c95ed02910';

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
