import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();

  static AppDatabase? _instance;
  static AppDatabase get instance => _instance ??= AppDatabase._();

  Database? _db;

  Future<Database> get database async => _db ??= await _init();

  static const _dbName = 'ikuji_kiroku.db';
  static const _dbVersion = 2;

  Future<Database> _init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_createChildren);
    await db.execute(_createDailyRecords);
    await db.execute(_createSleepLogs);
    await db.execute(_createMealLogs);
    await db.execute(_createTherapyNotes);   // 将来の療育ノート機能用
    await db.execute(_createTags);           // 将来のタグ機能用
    await db.execute(_createTherapyNoteTags);
    await db.execute(_createTherapySchedules);
    await db.execute(_createAbsenceTemplates);

    // 初期データ: デフォルト子供レコード
    await db.execute('''
      INSERT INTO children (id, name, birthDate, createdAt)
      VALUES ('default_child', 'お子さん', '', '${DateTime.now().toIso8601String()}')
    ''');
  }

  /// マイグレーション: バージョンアップ時にここに追加する
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // daily_records に therapyMemo カラム追加
      await db.execute(
          'ALTER TABLE daily_records ADD COLUMN therapyMemo TEXT');
      // therapy_schedules に繰り返し関連カラム追加
      await db.execute(
          "ALTER TABLE therapy_schedules ADD COLUMN repeatType TEXT NOT NULL DEFAULT 'none'");
      await db.execute(
          'ALTER TABLE therapy_schedules ADD COLUMN repeatDayOfWeek INTEGER');
      await db.execute(
          'ALTER TABLE therapy_schedules ADD COLUMN repeatUntil TEXT');
    }
  }

  // ─────────────────────────────────────────────
  // DDL
  // ─────────────────────────────────────────────

  static const _createChildren = '''
    CREATE TABLE children (
      id        TEXT PRIMARY KEY,
      name      TEXT NOT NULL,
      birthDate TEXT NOT NULL,
      createdAt TEXT NOT NULL
    )
  ''';

  static const _createDailyRecords = '''
    CREATE TABLE daily_records (
      id           TEXT PRIMARY KEY,
      childId      TEXT NOT NULL,
      date         TEXT NOT NULL,
      mood         INTEGER NOT NULL,
      notes        TEXT,
      achievements TEXT,
      cuteMoments  TEXT,
      concerns     TEXT,
      therapyMemo  TEXT,
      createdAt    TEXT NOT NULL,
      updatedAt    TEXT NOT NULL,
      UNIQUE(childId, date)
    )
  ''';

  static const _createSleepLogs = '''
    CREATE TABLE sleep_logs (
      id               TEXT PRIMARY KEY,
      dailyRecordId    TEXT NOT NULL,
      childId          TEXT NOT NULL,
      bedtimeStartTime TEXT,
      sleepStartTime   TEXT NOT NULL,
      sleepEndTime     TEXT
    )
  ''';

  static const _createMealLogs = '''
    CREATE TABLE meal_logs (
      id            TEXT PRIMARY KEY,
      dailyRecordId TEXT NOT NULL,
      childId       TEXT NOT NULL,
      mealTime      TEXT NOT NULL,
      content       TEXT NOT NULL
    )
  ''';

  /// 将来実装: 療育ノート機能
  static const _createTherapyNotes = '''
    CREATE TABLE therapy_notes (
      id            TEXT PRIMARY KEY,
      dailyRecordId TEXT NOT NULL,
      childId       TEXT NOT NULL,
      content       TEXT NOT NULL,
      createdAt     TEXT NOT NULL,
      updatedAt     TEXT NOT NULL
    )
  ''';

  /// 将来実装: タグ機能
  static const _createTags = '''
    CREATE TABLE tags (
      id        TEXT PRIMARY KEY,
      childId   TEXT NOT NULL,
      name      TEXT NOT NULL,
      color     TEXT NOT NULL,
      createdAt TEXT NOT NULL
    )
  ''';

  /// 将来実装: therapy_notes × tags 中間テーブル
  static const _createTherapyNoteTags = '''
    CREATE TABLE therapy_note_tags (
      therapyNoteId TEXT NOT NULL,
      tagId         TEXT NOT NULL,
      PRIMARY KEY (therapyNoteId, tagId)
    )
  ''';

  static const _createTherapySchedules = '''
    CREATE TABLE therapy_schedules (
      id               TEXT PRIMARY KEY,
      childId          TEXT NOT NULL,
      date             TEXT NOT NULL,
      startTime        TEXT NOT NULL,
      endTime          TEXT NOT NULL,
      facilityName     TEXT NOT NULL,
      memo             TEXT,
      repeatType       TEXT NOT NULL DEFAULT 'none',
      repeatDayOfWeek  INTEGER,
      repeatUntil      TEXT,
      createdAt        TEXT NOT NULL,
      updatedAt        TEXT NOT NULL
    )
  ''';

  static const _createAbsenceTemplates = '''
    CREATE TABLE absence_templates (
      id        TEXT PRIMARY KEY,
      childId   TEXT NOT NULL,
      title     TEXT NOT NULL,
      template  TEXT NOT NULL,
      createdAt TEXT NOT NULL,
      updatedAt TEXT NOT NULL
    )
  ''';
}
