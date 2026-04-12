// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(connectivityStatus)
const connectivityStatusProvider = ConnectivityStatusProvider._();

final class ConnectivityStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<InternetStatus>,
          InternetStatus,
          Stream<InternetStatus>
        >
    with $FutureModifier<InternetStatus>, $StreamProvider<InternetStatus> {
  const ConnectivityStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectivityStatusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectivityStatusHash();

  @$internal
  @override
  $StreamProviderElement<InternetStatus> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<InternetStatus> create(Ref ref) {
    return connectivityStatus(ref);
  }
}

String _$connectivityStatusHash() =>
    r'cbecbac4a85dfc13d6fdc733ee54075bed03fc5c';
