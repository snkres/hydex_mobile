import 'package:flutter_test/flutter_test.dart';
import 'package:hydex/src/features/scan/data/bulk_request.dart';
import 'package:hydex/src/features/scan/domain/offline_sync.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  var testDbCounter = 0;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    await OfflineSyncDB.resetForTesting();
    // Each test gets its own named in-memory DB so they don't share state.
    testDbCounter++;
    OfflineSyncDB.testDatabasePath = 'file:test_db_$testDbCounter?mode=memory&cache=shared';
  });

  tearDown(() async {
    await OfflineSyncDB.resetForTesting();
  });

  BulkRequest makeRequest({
    String bookingID = 'booking-1',
    String status = 'approved',
    String? rejectionReason,
  }) =>
      BulkRequest(
        bookingID: bookingID,
        status: status,
        rejectionReason: rejectionReason,
      );

  group('savePendingRequest', () {
    test('saves a request and it appears in getPendingRequests', () async {
      await OfflineSyncDB.savePendingRequest(makeRequest());

      final results = await OfflineSyncDB.getPendingRequests();

      expect(results, hasLength(1));
      expect(results.first.bookingID, equals('booking-1'));
      expect(results.first.status, equals('approved'));
      expect(results.first.rejectionReason, isNull);
    });

    test('saves a request with a rejectionReason', () async {
      await OfflineSyncDB.savePendingRequest(makeRequest(
        status: 'rejected',
        rejectionReason: 'over capacity',
      ));

      final results = await OfflineSyncDB.getPendingRequests();

      expect(results.first.rejectionReason, equals('over capacity'));
    });

    test('saves multiple requests', () async {
      await OfflineSyncDB.savePendingRequest(makeRequest(bookingID: 'b-1'));
      await OfflineSyncDB.savePendingRequest(makeRequest(bookingID: 'b-2'));
      await OfflineSyncDB.savePendingRequest(makeRequest(bookingID: 'b-3'));

      final results = await OfflineSyncDB.getPendingRequests();

      expect(results, hasLength(3));
    });
  });

  group('getPendingRequests', () {
    test('returns empty list when no requests have been saved', () async {
      final results = await OfflineSyncDB.getPendingRequests();
      expect(results, isEmpty);
    });

    test('returns requests ordered by createdAt ASC', () async {
      await OfflineSyncDB.savePendingRequest(makeRequest(bookingID: 'first'));
      await Future.delayed(const Duration(milliseconds: 10));
      await OfflineSyncDB.savePendingRequest(makeRequest(bookingID: 'second'));

      final results = await OfflineSyncDB.getPendingRequests();

      expect(results[0].bookingID, equals('first'));
      expect(results[1].bookingID, equals('second'));
    });

    test('maps all fields correctly', () async {
      await OfflineSyncDB.savePendingRequest(
        BulkRequest(
          bookingID: 'booking-xyz',
          status: 'rejected',
          rejectionReason: 'no show',
        ),
      );

      final result = (await OfflineSyncDB.getPendingRequests()).first;

      expect(result.bookingID, equals('booking-xyz'));
      expect(result.status, equals('rejected'));
      expect(result.rejectionReason, equals('no show'));
    });
  });

  group('clearPendingRequests', () {
    test('removes all saved requests', () async {
      await OfflineSyncDB.savePendingRequest(makeRequest(bookingID: 'b-1'));
      await OfflineSyncDB.savePendingRequest(makeRequest(bookingID: 'b-2'));

      await OfflineSyncDB.clearPendingRequests();

      final results = await OfflineSyncDB.getPendingRequests();
      expect(results, isEmpty);
    });

    test('is a no-op when the table is already empty', () async {
      await expectLater(
        OfflineSyncDB.clearPendingRequests(),
        completes,
      );
      expect(await OfflineSyncDB.getPendingRequests(), isEmpty);
    });
  });

  group('pendingCount', () {
    test('returns 0 when no requests exist', () async {
      expect(await OfflineSyncDB.pendingCount(), equals(0));
    });

    test('returns correct count after saves', () async {
      await OfflineSyncDB.savePendingRequest(makeRequest(bookingID: 'b-1'));
      await OfflineSyncDB.savePendingRequest(makeRequest(bookingID: 'b-2'));

      expect(await OfflineSyncDB.pendingCount(), equals(2));
    });

    test('returns 0 after clearing', () async {
      await OfflineSyncDB.savePendingRequest(makeRequest());
      await OfflineSyncDB.clearPendingRequests();

      expect(await OfflineSyncDB.pendingCount(), equals(0));
    });

    test('increments by 1 with each save', () async {
      for (var i = 1; i <= 5; i++) {
        await OfflineSyncDB.savePendingRequest(
            makeRequest(bookingID: 'b-$i'));
        expect(await OfflineSyncDB.pendingCount(), equals(i));
      }
    });
  });
}
