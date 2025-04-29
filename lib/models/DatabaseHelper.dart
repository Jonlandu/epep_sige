import 'package:get_storage/get_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  //
  var box = GetStorage();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'school_forms.db');

    print('Database path: $path'); // Debugging line

    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE forms(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idannee INTEGER,
        idetablissement INTEGER,
        nom_etablissement TEXT,
        form_data TEXT NOT NULL,
        is_synced BOOLEAN DEFAULT 0,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT,
        sync_attempts INTEGER DEFAULT 0
      )
    ''');
    await db.execute('CREATE INDEX idx_forms_sync ON forms(is_synced)');
    await db.execute(
        'CREATE INDEX idx_forms_etablissement ON forms(idetablissement)');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
          'ALTER TABLE forms ADD COLUMN sync_attempts INTEGER DEFAULT 0');
    }
  }

  Future<List<Map<String, dynamic>>> getAllForms() async {
    final db = await database;
    return await db.query('forms', orderBy: 'created_at DESC');
  }

  Future<List<Map<String, dynamic>>> getUnsyncedForms({int limit = 5}) async {
    final db = await database;
    return await db.query(
      'forms',
      where: 'is_synced = ? AND sync_attempts < ?',
      whereArgs: [0, 3],
      limit: limit,
    );
  }

  Future<int> deleteForm(int id) async {
    final db = await database;
    return await db.delete(
      'forms',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> saveForm(Map<String, dynamic> formData) async {
    //
    List list = box.read("formData") ?? [];
    //
    list.add(formData);
    //
    final db = await database;

    final data = {
      'idannee': formData['idannee'],
      'idetablissement': formData['idetablissement'],
      'nom_etablissement': formData['nom_etablissement'],
      'form_data': jsonEncode(formData),
      'is_synced': 0,
      'updated_at': DateTime.now().toIso8601String(),
    };

    return await db.insert('forms', data);
  }

  Future<void> markAsSynced(int id) async {
    final db = await database;
    await db.update(
      'forms',
      {
        'is_synced': 1,
        'sync_attempts': 0,
        'last_sync': DateTime.now().toString(),
        'needs_sync': 0,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> incrementSyncAttempts(int id) async {
    final db = await database;
    await db.rawUpdate(
      'UPDATE forms SET sync_attempts = sync_attempts + 1 WHERE id = ?',
      [id],
    );
  }

  Future<void> markFormAsSynced(int id) async {
    final db = await database;
    await db.update(
      'forms',
      {
        'is_synced': 1,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateFormData(int id, Map<String, dynamic> formData) async {
    final db = await database;
    await db.update(
      'forms',
      {
        'form_data': jsonEncode(formData),
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> scheduleSync(int id, {int maxAttempts = 3}) async {
    final db = await database;

    // Vérifie d'abord si on n'a pas déjà trop d'essais
    final form = await db.query(
      'forms',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (form.isNotEmpty && (form.first['sync_attempts'] as int) < maxAttempts) {
      await db.update(
        'forms',
        {
          'needs_sync': 1,
          'sync_attempts': (form.first['sync_attempts'] as int) + 1,
          'updated_at': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }
}
