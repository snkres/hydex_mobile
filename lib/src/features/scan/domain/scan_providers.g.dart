// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getScanDetails)
const getScanDetailsProvider = GetScanDetailsFamily._();

final class GetScanDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<ScanResponse>,
          ScanResponse,
          FutureOr<ScanResponse>
        >
    with $FutureModifier<ScanResponse>, $FutureProvider<ScanResponse> {
  const GetScanDetailsProvider._({
    required GetScanDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'getScanDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getScanDetailsHash();

  @override
  String toString() {
    return r'getScanDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ScanResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ScanResponse> create(Ref ref) {
    final argument = this.argument as String;
    return getScanDetails(ref, id: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetScanDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getScanDetailsHash() => r'351af00ebd9c970094efb0d51ab59f76c7f69adf';

final class GetScanDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ScanResponse>, String> {
  const GetScanDetailsFamily._()
    : super(
        retry: null,
        name: r'getScanDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetScanDetailsProvider call({required String id}) =>
      GetScanDetailsProvider._(argument: id, from: this);

  @override
  String toString() => r'getScanDetailsProvider';
}

@ProviderFor(updateBookingStatus)
const updateBookingStatusProvider = UpdateBookingStatusFamily._();

final class UpdateBookingStatusProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const UpdateBookingStatusProvider._({
    required UpdateBookingStatusFamily super.from,
    required ({RsvStatus status, String id, String? rejectionReason})
    super.argument,
  }) : super(
         retry: null,
         name: r'updateBookingStatusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$updateBookingStatusHash();

  @override
  String toString() {
    return r'updateBookingStatusProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument =
        this.argument
            as ({RsvStatus status, String id, String? rejectionReason});
    return updateBookingStatus(
      ref,
      status: argument.status,
      id: argument.id,
      rejectionReason: argument.rejectionReason,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateBookingStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$updateBookingStatusHash() =>
    r'2ca0f0d16ad24018a7830d382f9708a51f2bcc4c';

final class UpdateBookingStatusFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<void>,
          ({RsvStatus status, String id, String? rejectionReason})
        > {
  const UpdateBookingStatusFamily._()
    : super(
        retry: null,
        name: r'updateBookingStatusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UpdateBookingStatusProvider call({
    required RsvStatus status,
    required String id,
    String? rejectionReason,
  }) => UpdateBookingStatusProvider._(
    argument: (status: status, id: id, rejectionReason: rejectionReason),
    from: this,
  );

  @override
  String toString() => r'updateBookingStatusProvider';
}

@ProviderFor(bulkUpdateBookingStatus)
const bulkUpdateBookingStatusProvider = BulkUpdateBookingStatusFamily._();

final class BulkUpdateBookingStatusProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const BulkUpdateBookingStatusProvider._({
    required BulkUpdateBookingStatusFamily super.from,
    required List<BulkRequest> super.argument,
  }) : super(
         retry: null,
         name: r'bulkUpdateBookingStatusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bulkUpdateBookingStatusHash();

  @override
  String toString() {
    return r'bulkUpdateBookingStatusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument = this.argument as List<BulkRequest>;
    return bulkUpdateBookingStatus(ref, items: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BulkUpdateBookingStatusProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bulkUpdateBookingStatusHash() =>
    r'2c3f191bb4e60111d381f6754185bb9bedd54f8b';

final class BulkUpdateBookingStatusFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<void>, List<BulkRequest>> {
  const BulkUpdateBookingStatusFamily._()
    : super(
        retry: null,
        name: r'bulkUpdateBookingStatusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BulkUpdateBookingStatusProvider call({required List<BulkRequest> items}) =>
      BulkUpdateBookingStatusProvider._(argument: items, from: this);

  @override
  String toString() => r'bulkUpdateBookingStatusProvider';
}

@ProviderFor(offlineSyncListener)
const offlineSyncListenerProvider = OfflineSyncListenerProvider._();

final class OfflineSyncListenerProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const OfflineSyncListenerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'offlineSyncListenerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$offlineSyncListenerHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return offlineSyncListener(ref);
  }
}

String _$offlineSyncListenerHash() =>
    r'300791023f7ff6bfee53db58f3f4d7e01f47ef0f';
