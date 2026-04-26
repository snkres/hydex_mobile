import 'package:flutter/foundation.dart';
import 'package:hydex/src/features/scan/data/bulk_request.dart';
import 'package:sqflite/sqflite.dart';

class OfflineSyncDB {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dbPath = '${await getDatabasesPath()}/offline_sync.db';
    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE pending_requests (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            bookingId TEXT NOT NULL,
            status TEXT NOT NULL,
            rejectionReason TEXT,
            createdAt TEXT NOT NULL
          )
        ''');
      },
    );
  }

  static Future<void> savePendingRequest(BulkRequest request) async {
    final db = await database;
    await db.insert('pending_requests', {
      'bookingId': request.bookingID,
      'status': request.status,
      'rejectionReason': request.rejectionReason,
      'createdAt': DateTime.now().toIso8601String(),
    });
    if (kDebugMode) {
      print('📦 Saved pending request for booking: ${request.bookingID}');
    }
  }

  static Future<List<BulkRequest>> getPendingRequests() async {
    final db = await database;
    final rows = await db.query('pending_requests', orderBy: 'createdAt ASC');
    return rows
        .map((row) => BulkRequest(
              bookingID: row['bookingId'] as String,
              status: row['status'] as String,
              rejectionReason: row['rejectionReason'] as String?,
            ))
        .toList();
  }

  static Future<void> clearPendingRequests() async {
    final db = await database;
    await db.delete('pending_requests');
    if (kDebugMode) {
      print('🗑️ Cleared all pending requests');
    }
  }

  static Future<int> pendingCount() async {
    final db = await database;
    final result =
        await db.rawQuery('SELECT COUNT(*) as count FROM pending_requests');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
