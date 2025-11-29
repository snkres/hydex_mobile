// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VendorNotifier)
const vendorProvider = VendorNotifierFamily._();

final class VendorNotifierProvider
    extends $AsyncNotifierProvider<VendorNotifier, Vendor> {
  const VendorNotifierProvider._({
    required VendorNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'vendorProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vendorNotifierHash();

  @override
  String toString() {
    return r'vendorProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VendorNotifier create() => VendorNotifier();

  @override
  bool operator ==(Object other) {
    return other is VendorNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vendorNotifierHash() => r'31cae24a45370c12cf1a8d4680ea7fc75bdf88c3';

final class VendorNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          VendorNotifier,
          AsyncValue<Vendor>,
          Vendor,
          FutureOr<Vendor>,
          String
        > {
  const VendorNotifierFamily._()
    : super(
        retry: null,
        name: r'vendorProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VendorNotifierProvider call(String id) =>
      VendorNotifierProvider._(argument: id, from: this);

  @override
  String toString() => r'vendorProvider';
}

abstract class _$VendorNotifier extends $AsyncNotifier<Vendor> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<Vendor> build(String id);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<Vendor>, Vendor>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Vendor>, Vendor>,
              AsyncValue<Vendor>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
