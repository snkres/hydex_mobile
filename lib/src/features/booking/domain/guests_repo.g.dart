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
    extends $NotifierProvider<GuestFormNotifier, GuestFormState> {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GuestFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GuestFormState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GuestFormNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$guestFormNotifierHash() => r'17d006e109bf3b62f08b009c030081115576bb17';

final class GuestFormNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          GuestFormNotifier,
          GuestFormState,
          GuestFormState,
          GuestFormState,
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

abstract class _$GuestFormNotifier extends $Notifier<GuestFormState> {
  late final _$args = ref.$arg as int;
  int get totalGuests => _$args;

  GuestFormState build(int totalGuests);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<GuestFormState, GuestFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GuestFormState, GuestFormState>,
              GuestFormState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
