import 'package:lista_tarefas_flutter_floor/ItemModel.dart';
import 'package:lista_tarefas_flutter_floor/ItemDatabase.dart';

class ItemManager {

  Future<List<ItemModel>> findAll() async {
    final database = await $FloorItemDatabase.databaseBuilder("item_database.db").build();
    final itemDao = database.itemDao;
    return itemDao.findAll();
  }

  Future<void> create(ItemModel item) async {
    final database = await $FloorItemDatabase.databaseBuilder("item_database.db").build();
    final itemDao = database.itemDao;
    await itemDao.create(item);
  }

  Future<void> update(int id, bool checked) async {
    final database = await $FloorItemDatabase.databaseBuilder("item_database.db").build();
    final itemDao = database.itemDao;
    await itemDao.update(id, checked);
  }

  Future<void> delete(int id) async {
    final database = await $FloorItemDatabase.databaseBuilder("item_database.db").build();
    final itemDao = database.itemDao;
    await itemDao.delete(id);
  }

}
