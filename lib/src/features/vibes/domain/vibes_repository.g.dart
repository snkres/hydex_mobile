// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vibes_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getEventsHash() => r'b4664593cbcc80729be59b6c25aef9817f8948b2';

/// See also [getEvents].
@ProviderFor(getEvents)
final getEventsProvider = AutoDisposeFutureProvider<List<Event>>.internal(
  getEvents,
  name: r'getEventsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getEventsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetEventsRef = AutoDisposeFutureProviderRef<List<Event>>;
String _$getEventByIDHash() => r'1e30921a2af9ea5408a72b6f26479f161a64a119';

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

/// See also [getEventByID].
@ProviderFor(getEventByID)
const getEventByIDProvider = GetEventByIDFamily();

/// See also [getEventByID].
class GetEventByIDFamily extends Family<AsyncValue<Event>> {
  /// See also [getEventByID].
  const GetEventByIDFamily();

  /// See also [getEventByID].
  GetEventByIDProvider call({required String id}) {
    return GetEventByIDProvider(id: id);
  }

  @override
  GetEventByIDProvider getProviderOverride(
    covariant GetEventByIDProvider provider,
  ) {
    return call(id: provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getEventByIDProvider';
}

/// See also [getEventByID].
class GetEventByIDProvider extends AutoDisposeFutureProvider<Event> {
  /// See also [getEventByID].
  GetEventByIDProvider({required String id})
    : this._internal(
        (ref) => getEventByID(ref as GetEventByIDRef, id: id),
        from: getEventByIDProvider,
        name: r'getEventByIDProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$getEventByIDHash,
        dependencies: GetEventByIDFamily._dependencies,
        allTransitiveDependencies:
            GetEventByIDFamily._allTransitiveDependencies,
        id: id,
      );

  GetEventByIDProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Event> Function(GetEventByIDRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetEventByIDProvider._internal(
        (ref) => create(ref as GetEventByIDRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Event> createElement() {
    return _GetEventByIDProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetEventByIDProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetEventByIDRef on AutoDisposeFutureProviderRef<Event> {
  /// The parameter `id` of this provider.
  String get id;
}

class _GetEventByIDProviderElement
    extends AutoDisposeFutureProviderElement<Event>
    with GetEventByIDRef {
  _GetEventByIDProviderElement(super.provider);

  @override
  String get id => (origin as GetEventByIDProvider).id;
}

String _$getEventCategoriesHash() =>
    r'2840796914d453c9d12b9ee24fea62a590f3dae0';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
