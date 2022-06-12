import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'ItemModel.dart';
import 'ItemDAO.dart';

part 'itemdatabase.g.dart';

@Database(version: 1, entities: [ItemModel])
abstract class ItemDatabase extends FloorDatabase {
  ItemDAO get itemDao;
}
