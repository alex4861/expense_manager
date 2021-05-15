
class Category {
  final String idCategory;
  final String? name;

  const Category({this.name, required this.idCategory});

  Map<String, dynamic> toMap() {
    return {
      'idCategory': idCategory,
      'name': name,
    };
  }
  static Future<List<Category>> toObject({required List<Map<String, dynamic>> maps}) async {
    return List.generate(maps.length, (i) {
      return Category(
        idCategory: maps[i]['idCategory'],
        name: maps[i]['name']
      );
    });
  }

}

class Item{
  String? idCategory;
  String? idItem;
  String? concept;
  int? estimated;
  int? real;
  int? itemCount;

  Item({this.idCategory,
      this.idItem,
      this.concept,
      this.estimated,
      this.real,
      this.itemCount});

  Map<String, dynamic> toMap(){
    return{
      'idCategory': idCategory,
      'idItem': idItem,
      'concept': concept,
      'estimated': estimated,
      'real': real,
      'itemCount': itemCount,
    };
  }
  Item copyWith({String? idCategory, String? idItem, String? concept, int? estimated, int? real, int? itemCount}){
    return Item(idCategory: idCategory, idItem: idItem, concept: concept, estimated: estimated, real: real, itemCount: itemCount);
  }
  static Future<List<Item>> toObject({required List<Map<String, dynamic>> maps}) async {
    return List.generate(maps.length, (i) {
      return Item(
        idCategory: maps[i]['idCategory'],
        idItem: maps[i]['idItem'],
        concept: maps[i]['concept'],
        estimated: maps[i]['estimated'],
        real: maps[i]['real'],
        itemCount: maps[i]['itemCount'],
      );
    });
  }
}

class DataSource{
  addCategory({required String name, required List<Item> items}){
  }
  deleteCategory({required String id}){
  }
  getCategory({required String id}){
  }

}