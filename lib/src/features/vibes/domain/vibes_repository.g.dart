// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vibes_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getBannersHash() => r'c95a267fb110cf92f9d2d1e9d8fdb970e2ec9a78';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getBanners].
@ProviderFor(getBanners)
const getBannersProvider = GetBannersFamily();

/// See also [getBanners].
class GetBannersFamily extends Family<AsyncValue<List<Banner>>> {
  /// See also [getBanners].
  const GetBannersFamily();

  /// See also [getBanners].
  GetBannersProvider call({required BannerType type}) {
    return GetBannersProvider(type: type);
  }

  @override
  GetBannersProvider getProviderOverride(
    covariant GetBannersProvider provider,
  ) {
    return call(type: provider.type);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getBannersProvider';
}

/// See also [getBanners].
class GetBannersProvider extends FutureProvider<List<Banner>> {
  /// See also [getBanners].
  GetBannersProvider({required BannerType type})
    : this._internal(
        (ref) => getBanners(ref as GetBannersRef, type: type),
        from: getBannersProvider,
        name: r'getBannersProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$getBannersHash,
        dependencies: GetBannersFamily._dependencies,
        allTransitiveDependencies: GetBannersFamily._allTransitiveDependencies,
        type: type,
      );

  GetBannersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final BannerType type;

  @override
  Override overrideWith(
    FutureOr<List<Banner>> Function(GetBannersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetBannersProvider._internal(
        (ref) => create(ref as GetBannersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  FutureProviderElement<List<Banner>> createElement() {
    return _GetBannersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetBannersProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetBannersRef on FutureProviderRef<List<Banner>> {
  /// The parameter `type` of this provider.
  BannerType get type;
}

class _GetBannersProviderElement extends FutureProviderElement<List<Banner>>
    with GetBannersRef {
  _GetBannersProviderElement(super.provider);

  @override
  BannerType get type => (origin as GetBannersProvider).type;
}

String _$getEventCategoriesHash() =>
    r'd272d6434ad7b55a31a0b3c89e1f2fd2334de188';

/// See also [getEventCategories].
@ProviderFor(getEventCategories)
final getEventCategoriesProvider =
    AutoDisposeFutureProvider<List<EventCategory>>.internal(
      getEventCategories,
      name: r'getEventCategoriesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getEventCategoriesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetEventCategoriesRef =
    AutoDisposeFutureProviderRef<List<EventCategory>>;
String _$getVendorsHash() => r'158476512cd5c2b6ec0c8c83ddba2ea8721823bd';

/// See also [getVendors].
@ProviderFor(getVendors)
const getVendorsProvider = GetVendorsFamily();

/// See also [getVendors].
class GetVendorsFamily extends Family<AsyncValue<void>> {
  /// See also [getVendors].
  const GetVendorsFamily();

  /// See also [getVendors].
  GetVendorsProvider call({int page = 1}) {
    return GetVendorsProvider(page: page);
  }

  @override
  GetVendorsProvider getProviderOverride(
    covariant GetVendorsProvider provider,
  ) {
    return call(page: provider.page);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getVendorsProvider';
}

/// See also [getVendors].
class GetVendorsProvider extends AutoDisposeFutureProvider<void> {
  /// See also [getVendors].
  GetVendorsProvider({int page = 1})
    : this._internal(
        (ref) => getVendors(ref as GetVendorsRef, page: page),
        from: getVendorsProvider,
        name: r'getVendorsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$getVendorsHash,
        dependencies: GetVendorsFamily._dependencies,
        allTransitiveDependencies: GetVendorsFamily._allTransitiveDependencies,
        page: page,
      );

  GetVendorsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
  }) : super.internal();

  final int page;

  @override
  Override overrideWith(
    FutureOr<void> Function(GetVendorsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetVendorsProvider._internal(
        (ref) => create(ref as GetVendorsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _GetVendorsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetVendorsProvider && other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetVendorsRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `page` of this provider.
  int get page;
}

class _GetVendorsProviderElement extends AutoDisposeFutureProviderElement<void>
    with GetVendorsRef {
  _GetVendorsProviderElement(super.provider);

  @override
  int get page => (origin as GetVendorsProvider).page;
}

String _$getEventsHash() => r'924a751789eee9e3ce74514fbe90f20899762d8a';

/// See also [getEvents].
@ProviderFor(getEvents)
const getEventsProvider = GetEventsFamily();

/// See also [getEvents].
class GetEventsFamily extends Family<AsyncValue<List<Event>>> {
  /// See also [getEvents].
  const GetEventsFamily();

  /// See also [getEvents].
  GetEventsProvider call({int page = 1}) {
    return GetEventsProvider(page: page);
  }

  @override
  GetEventsProvider getProviderOverride(covariant GetEventsProvider provider) {
    return call(page: provider.page);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getEventsProvider';
}

/// See also [getEvents].
class GetEventsProvider extends AutoDisposeFutureProvider<List<Event>> {
  /// See also [getEvents].
  GetEventsProvider({int page = 1})
    : this._internal(
        (ref) => getEvents(ref as GetEventsRef, page: page),
        from: getEventsProvider,
        name: r'getEventsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$getEventsHash,
        dependencies: GetEventsFamily._dependencies,
        allTransitiveDependencies: GetEventsFamily._allTransitiveDependencies,
        page: page,
      );

  GetEventsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
  }) : super.internal();

  final int page;

  @override
  Override overrideWith(
    FutureOr<List<Event>> Function(GetEventsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetEventsProvider._internal(
        (ref) => create(ref as GetEventsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Event>> createElement() {
    return _GetEventsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetEventsProvider && other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetEventsRef on AutoDisposeFutureProviderRef<List<Event>> {
  /// The parameter `page` of this provider.
  int get page;
}

class _GetEventsProviderElement
    extends AutoDisposeFutureProviderElement<List<Event>>
    with GetEventsRef {
  _GetEventsProviderElement(super.provider);

  @override
  int get page => (origin as GetEventsProvider).page;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
