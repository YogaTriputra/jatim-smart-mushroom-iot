import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../core/app_constants.dart';
import '../models/batch_model.dart';
import '../models/harvest_model.dart';

class DatabaseHelper {
  // Singleton pattern: memastikan hanya ada 1 koneksi database di seluruh aplikasi
static final DatabaseHelper instance = DatabaseHelper._init();
static Database? _database;

DatabaseHelper._init();

Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(AppConstants.sqliteDbName);
    return _database!;
}

Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
    path,
    version: AppConstants.sqliteDbVersion,
    onCreate: _createDB,
    );
}

Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE batches (
        id TEXT PRIMARY KEY,
        kumbung_id TEXT NOT NULL,
        batch_name TEXT NOT NULL,
        baglog_count INTEGER NOT NULL,
        inoculation_date TEXT NOT NULL,
        estimated_harvest_date TEXT NOT NULL,
        growth_status TEXT NOT NULL,
        growth_progress INTEGER DEFAULT 0,
        notes TEXT,
        is_synced INTEGER NOT NULL DEFAULT 0,
        is_deleted INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE harvests (
        id TEXT PRIMARY KEY,
        batch_id TEXT NOT NULL,
        harvest_date TEXT NOT NULL,
        weight_kg REAL NOT NULL,
        quality_grade TEXT NOT NULL,
        qc_status TEXT DEFAULT 'Lokal',
        photo_path TEXT,
        notes TEXT,
        is_synced INTEGER NOT NULL DEFAULT 0,
        is_deleted INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (batch_id) REFERENCES batches (id) ON DELETE CASCADE
    )
    ''');

    await db.execute(
    'CREATE INDEX idx_batches_status ON batches (growth_status, is_deleted)',
    );
    await db.execute(
    'CREATE INDEX idx_harvests_date ON harvests (harvest_date, is_deleted)',
    );
    await db.execute('CREATE INDEX idx_harvests_batch ON harvests (batch_id)');
}

  // ==================== CRUD BATCHES ====================

Future<void> insertBatch(BatchModel batch) async {
    final db = await instance.database;
    await db.insert(
    'batches',
    batch.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
    );
}

Future<List<BatchModel>> getActiveBatches() async {
    final db = await instance.database;
    final result = await db.query(
    'batches',
    where: 'is_deleted = ?',
    whereArgs: [0],
    orderBy: 'created_at DESC',
    );
    return result.map((map) => BatchModel.fromMap(map)).toList();
}

Future<void> updateBatch(BatchModel batch) async {
    final db = await instance.database;
    await db.update(
    'batches',
    batch.toMap(),
    where: 'id = ?',
    whereArgs: [batch.id],
    );
}

  // Soft delete agar penghapusan saat offline bisa disinkronkan ke Firebase
Future<void> softDeleteBatch(String id, String updatedAt) async {
    final db = await instance.database;
    await db.update(
    'batches',
    {'is_deleted': 1, 'is_synced': 0, 'updated_at': updatedAt},
    where: 'id = ?',
    whereArgs: [id],
    );
}

  // ==================== CRUD HARVESTS ====================

Future<void> insertHarvest(HarvestModel harvest) async {
    final db = await instance.database;
    await db.insert(
    'harvests',
    harvest.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
    );
}

Future<List<HarvestModel>> getActiveHarvests() async {
    final db = await instance.database;
    final result = await db.query(
    'harvests',
    where: 'is_deleted = ?',
    whereArgs: [0],
    orderBy: 'harvest_date DESC',
    );
    return result.map((map) => HarvestModel.fromMap(map)).toList();
}
}
