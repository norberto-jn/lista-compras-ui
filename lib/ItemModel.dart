import 'package:floor/floor.dart';

@entity
class ItemModel {

  @primaryKey
  final int? id;
  final String nome;
  late final bool checked;

  ItemModel(this.nome, this.checked, this.id);
  
}
