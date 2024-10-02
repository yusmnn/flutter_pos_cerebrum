import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/request/product.dart';

class ProductDatabase {
  static final ProductDatabase instance = ProductDatabase._init();

  static Database? _database;

  ProductDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('product.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'REAL NOT NULL';
    const intType = 'INTEGER DEFAULT 1';
    const purchased = 'INTEGER DEFAULT 0';

    await db.execute('''
      CREATE TABLE products (
        id $idType,
        imagePath $textType,
        title $textType,
        description $textType,
        price $doubleType,
        quantity $intType,
        purchased $purchased
      )
    ''');
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''ALTER TABLE products ADD COLUMN imagePath TEXT''');
    }
    if (oldVersion < 3) {
      await db.execute(
          '''ALTER TABLE products ADD COLUMN quantity INTEGER DEFAULT 1''');
    }
  }

  Future<void> insertProduct(Product product) async {
    final db = await instance.database;

    await db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Product>> fetchProducts() async {
    final db = await instance.database;

    final maps = await db.query('products');

    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  Future<void> updateProductQuantity(Product product) async {
    final db = await instance.database;
    await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
