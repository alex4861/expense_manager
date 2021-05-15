import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';
import '../expenseCategories.dart';

class ExpenseRepository{
  Future<Database>? _database;
//Create list if not exitst
  init() async{
    List<String> execute = [
      "CREATE TABLE [IF NOT EXISTS] Category("
          "idCategory String PRIMARY KEY, "
          "name TEXT,)"
    ];
    _database = openDatabase(
      join(await getDatabasesPath(), 'expense_manager.db'),
      onCreate: (db, version){
        db.execute('PRAGMA foreign_keys = ON');
        execute.forEach((element) {
          db.execute(element);
          db.execute(
            "CREATE TABLE [IF NOT EXISTS] Items("
                "idItem TEXT PRIMARY KEY, "
                "FOREIGN KEY (idCategory) REFERENCES Category(idCategory) "
                "concept TEXT, "
                "estimated REAL, "
                "real REAL, "
                "itemCount INTEGER,)"
          );
        });
        return;
      },
      version: 1,
    );
  }


  // - MARK: CRUD Methods for Category

  //Create
  Future<void> addCategory({required String name, List<Item>? items}) async{
    String idCategory = Uuid().v1();
    Category value = Category(name: name, idCategory: idCategory);
    final db = await _database;
    db?.insert("Category", value.toMap());
    if (items != null){
      items.forEach((value) {
        addItem(idCategory: idCategory, concept: value.concept, estimated: value.estimated, real: value.real, itemCount: value.itemCount);
      });
    }
  }

  //Read
  Future<List<Category>?> getAllCategories() async {
    final db = await _database;
    if (db == null){return null;}
    final List<Map<String, dynamic>> items = await db.query('Category');
    return Category.toObject(maps: items);
  }

  //Update
  Future<void> updateCategoryName({required Category object}) async {
    final db = await _database;
    if (db == null){return null;}
    await db.update('Category', object.toMap(),  where: 'idCategory = ?', whereArgs: [object.idCategory]);
  }

  //Delete
  Future<void> removeCategory({required String id}) async{
    final db = await _database;
    await db?.delete('Items', where: 'idCategory = ?', whereArgs: [id]);
    await db?.delete('Category', where: 'idCategory = ?', whereArgs: [id]);
  }

  // - MARK: CRUD Methods for Category

  //Create
  @Deprecated('Use createItem Instead')
  Future<void> addItem({String? idCategory,
    String? concept,
    int? estimated,
    int? real,
    int? itemCount}) async{
    final value = Item(idCategory: idCategory, concept: concept, estimated: estimated, real: real, itemCount: itemCount, idItem: Uuid().v1());
    final db = await _database;
    await db?.insert('Items', value.toMap());
  }
  Future<Item?> createItem({required Item item}) async{
    final db = await _database;
    await db?.insert('Items', item.toMap());
    return await getItemForId(id: item.idItem);
  }

  //Read
  Future<List<Item>?> getAllItems() async {
    final db = await _database;
    if (db == null){return null;}
    final List<Map<String, dynamic>> items = await db.query('Items');
    return Item.toObject(maps: items);
  }

  Future<Item?> getItemForId({String? id}) async {
    if (id == null){return null;}
    final db = await _database;
    if (db == null){return null;}
    final items = await db.query('Items', where: 'idItem = ?', whereArgs: [id]);
    final item = await Item.toObject(maps: items);
    return item.first;
  }

  Future<List<Item>?> getItemsForCategoryId({required String categoryId}) async{
    final db = await _database;
    if (db == null){return null;}
    final items = await db.query('Items', where: 'idCategory = ?', whereArgs: [categoryId]);
    return Item.toObject(maps: items);
  }


  //Update
  Future<void> updateItem({required Item object}) async {
    final db = await _database;
    if (db == null){return null;}
    await db.update('Items', object.toMap(),  where: 'idItem = ?', whereArgs: [object.idItem]);
  }

  //Delete
  Future<void> removeItem({required String id}) async{
    final db = await _database;
    await db?.delete('Items', where: 'idItem = ?', whereArgs: [id]);
  }


}

