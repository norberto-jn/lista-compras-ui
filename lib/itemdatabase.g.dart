// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ItemDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorItemDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ItemDatabaseBuilder databaseBuilder(String name) =>
      _$ItemDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ItemDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$ItemDatabaseBuilder(null);
}

class _$ItemDatabaseBuilder {
  _$ItemDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$ItemDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$ItemDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<ItemDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ItemDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ItemDatabase extends ItemDatabase {
  _$ItemDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ItemDAO? _itemDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Item` (`id` INTEGER, `nome` TEXT NOT NULL, `checked` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ItemDAO get itemDao {
    return _itemDaoInstance ??= _$ItemDao(database, changeListener);
  }
}

class _$ItemDao extends ItemDAO {
  _$ItemDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _itemInsertionAdapter = InsertionAdapter(
            database,
            'Item',
            (ItemModel item) => <String, Object?>{
                  'id': item.id,
                  'nome': item.nome,
                  'checked': item.checked ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ItemModel> _itemInsertionAdapter;

  @override
  Future<List<ItemModel>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Item',
        mapper: (Map<String, Object?> row) => ItemModel(row['nome'] as String,
            (row['checked'] as int) != 0, row['id'] as int?));
  }

  @override
  Future<ItemModel?> delete(int id) async {
    return _queryAdapter.query('DELETE FROM Item WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ItemModel(row['nome'] as String,
            (row['checked'] as int) != 0, row['id'] as int?),
        arguments: [id]);
  }

  @override
  Future<ItemModel?> update(int id, bool checked) async {
    return _queryAdapter.query('UPDATE Item SET checked =?2 WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ItemModel(row['nome'] as String,
            (row['checked'] as int) != 0, row['id'] as int?),
        arguments: [id, checked ? 1 : 0]);
  }

  @override
  Future<void> create(ItemModel item) async {
    await _itemInsertionAdapter.insert(item, OnConflictStrategy.abort);
  }
}
