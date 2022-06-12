import 'package:floor/floor.dart';

import 'ItemModel.dart';

@dao
abstract class ItemDAO {

  @Query('SELECT * FROM Item')
  Future<List<ItemModel>> findAll();

  @insert
  Future<void> create(ItemModel item);
  
  @Query('UPDATE Item SET checked =:checked WHERE id = :id')
  Future<ItemModel?> update(int id, bool checked);

  @Query('DELETE FROM Item WHERE id = :id')
  Future<ItemModel?> delete(int id);

}
