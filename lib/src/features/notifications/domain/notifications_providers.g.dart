// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getNotifications)
const getNotificationsProvider = GetNotificationsProvider._();

final class GetNotificationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AppNotification>>,
          List<AppNotification>,
          FutureOr<List<AppNotification>>
        >
    with
        $FutureModifier<List<AppNotification>>,
        $FutureProvider<List<AppNotification>> {
  const GetNotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getNotificationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getNotificationsHash();

  @$internal
  @override
  $FutureProviderElement<List<AppNotification>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AppNotification>> create(Ref ref) {
    return getNotifications(ref);
  }
}

String _$getNotificationsHash() => r'90f0de9275e7d39f9252d8a0d69ff6fe23f64874';

@ProviderFor(markAllNotificationsAsRead)
const markAllNotificationsAsReadProvider =
    MarkAllNotificationsAsReadProvider._();

final class MarkAllNotificationsAsReadProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const MarkAllNotificationsAsReadProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'markAllNotificationsAsReadProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$markAllNotificationsAsReadHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return markAllNotificationsAsRead(ref);
  }
}

String _$markAllNotificationsAsReadHash() =>
    r'fc11dd53f86e744aaf27f23e637961020ec8715c';
