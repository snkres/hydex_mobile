// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guests_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GuestFormNotifier)
const guestFormProvider = GuestFormNotifierFamily._();

final class GuestFormNotifierProvider
    extends $AsyncNotifierProvider<GuestFormNotifier, GuestFormState> {
  const GuestFormNotifierProvider._({
    required GuestFormNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'guestFormProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$guestFormNotifierHash();

  @override
  String toString() {
    return r'guestFormProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  GuestFormNotifier create() => GuestFormNotifier();

  @override
  bool operator ==(Object other) {
    return other is GuestFormNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$guestFormNotifierHash() => r'f01ddee7ae3c6bd4f124305c8ae1742007f718f8';

final class GuestFormNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          GuestFormNotifier,
          AsyncValue<GuestFormState>,
          GuestFormState,
          FutureOr<GuestFormState>,
          int
        > {
  const GuestFormNotifierFamily._()
    : super(
        retry: null,
        name: r'guestFormProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  GuestFormNotifierProvider call(int totalGuests) =>
      GuestFormNotifierProvider._(argument: totalGuests, from: this);

  @override
  String toString() => r'guestFormProvider';
}

abstract class _$GuestFormNotifier extends $AsyncNotifier<GuestFormState> {
  late final _$args = ref.$arg as int;
  int get totalGuests => _$args;

  FutureOr<GuestFormState> build(int totalGuests);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<GuestFormState>, GuestFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<GuestFormState>, GuestFormState>,
              AsyncValue<GuestFormState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
