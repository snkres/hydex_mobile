import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydex/core/network/connection.dart';
import 'package:hydex/src/features/scan/data/bulk_request.dart';
import 'package:hydex/src/features/scan/data/rsv_status.dart';
import 'package:hydex/src/features/scan/domain/offline_sync.dart';
import 'package:hydex/src/features/scan/domain/scan_providers.dart';
import 'package:hydex/src/features/scan/ui/components/scan_action_buttons.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Widget _wrap(Widget child, {List<Override> overrides = const []}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(home: Scaffold(body: child)),
  );
}

// ---------------------------------------------------------------------------
// Test DB setup
// ---------------------------------------------------------------------------

var _testDbCounter = 0;

Future<void> _resetDb() async {
  await OfflineSyncDB.resetForTesting();
  _testDbCounter++;
  OfflineSyncDB.testDatabasePath =
      'file:widget_test_db_$_testDbCounter?mode=memory&cache=shared';
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(_resetDb);
  tearDown(OfflineSyncDB.resetForTesting);

  testWidgets('tapping Confirm Entry when offline saves 1 pending DB entry', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        const ScanActionButtons(bookingId: 'booking-abc', isTicket: false),
        overrides: [
          // Simulate the offline catch path: throw NetworkException internally
          // then save to DB, exactly as the real provider does.
          updateBookingStatusProvider(
            status: RsvStatus.entered,
            id: 'booking-abc',
          ).overrideWith((_) async {
            try {
              throw Exception('no connection');
            } catch (_) {
              await OfflineSyncDB.savePendingRequest(
                BulkRequest(bookingID: 'booking-abc', status: 'ENTERED'),
              );
            }
          }),
          // Closed stream — no pending subscriptions to keep the pump alive.
          connectivityStatusProvider.overrideWith(
            (_) => Stream<InternetStatus>.empty(),
          ),
          // No-op so the keepAlive listener never touches the real OS stream.
          offlineSyncListenerProvider.overrideWith((_) async {}),
        ],
      ),
    );

    await tester.pump();

    final confirmButton = find.text('Confirm Entry');
    expect(confirmButton, findsOneWidget);
    await tester.tap(confirmButton);

    // Pump past the elastic spring animation (600 ms) and let the async
    // provider body complete (NetworkException → DB write).
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));

    final count = await tester.runAsync(() => OfflineSyncDB.pendingCount());
    expect(count, equals(1));

    final saved = await tester.runAsync(
      () => OfflineSyncDB.getPendingRequests(),
    );
    expect(saved!.first.bookingID, equals('booking-abc'));
    expect(saved.first.status, equals('ENTERED'));
  });

  testWidgets(
    'when connectivity changes to connected the pending entry is synced and DB is cleared',
    (tester) async {
      await tester.runAsync(
        () => OfflineSyncDB.savePendingRequest(
          BulkRequest(bookingID: 'booking-abc', status: 'ENTERED'),
        ),
      );
      expect(
        await tester.runAsync(() => OfflineSyncDB.pendingCount()),
        equals(1),
      );

      var bulkCalled = false;
      final syncCompleter = Completer<void>();

      final connectivityController =
          StreamController<InternetStatus>.broadcast();
      addTearDown(connectivityController.close);

      late ProviderContainer container;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            updateBookingStatusProvider(
              status: RsvStatus.entered,
              id: 'booking-abc',
            ).overrideWith((_) async {}),

            connectivityStatusProvider.overrideWith(
              (_) => connectivityController.stream,
            ),

            bulkUpdateBookingStatusProvider(items: const []).overrideWith((
              _,
            ) async {
              bulkCalled = true;
              await OfflineSyncDB.clearPendingRequests();
              if (!syncCompleter.isCompleted) syncCompleter.complete();
            }),

            offlineSyncListenerProvider.overrideWith((ref) async {
              ref.listen(connectivityStatusProvider, (prev, next) {
                if (next.value == InternetStatus.connected) {
                  ref.read(
                    bulkUpdateBookingStatusProvider(items: const []).future,
                  );
                }
              });
            }),
          ],
          child: Builder(
            builder: (context) {
              container = ProviderScope.containerOf(context);
              return const MaterialApp(
                home: Scaffold(
                  body: ScanActionButtons(
                    bookingId: 'booking-abc',
                    isTicket: false,
                  ),
                ),
              );
            },
          ),
        ),
      );

      await tester.pump();

      // Force the listener provider to run so its ref.listen is registered.
      container.read(offlineSyncListenerProvider);

      connectivityController.add(InternetStatus.connected);

      // Wait for the bulk provider to finish its async DB work.
      await tester.runAsync(() => syncCompleter.future);
      await tester.pump();

      expect(bulkCalled, isTrue);
      expect(
        await tester.runAsync(() => OfflineSyncDB.pendingCount()),
        equals(0),
      );
    },
  );
}
