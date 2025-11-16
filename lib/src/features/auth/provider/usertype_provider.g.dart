// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usertype_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserTypeNotifier)
const userTypeProvider = UserTypeNotifierProvider._();

final class UserTypeNotifierProvider
    extends $NotifierProvider<UserTypeNotifier, Role> {
  const UserTypeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userTypeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userTypeNotifierHash();

  @$internal
  @override
  UserTypeNotifier create() => UserTypeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Role value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Role>(value),
    );
  }
}

String _$userTypeNotifierHash() => r'dadcaae4bd2ab4edc717256cfeada0e43fa64c27';

abstract class _$UserTypeNotifier extends $Notifier<Role> {
  Role build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Role, Role>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Role, Role>,
              Role,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
