import 'package:flutter/material.dart';
import 'package:sqlcool/sqlcool.dart';

class DBUtil {
  static DBUtil of(BuildContext context) {
    return Localizations.of<DBUtil>(context, DBUtil);
  }

  static Future<DBUtil> initialize() async {
    DBUtil dbUtil = DBUtil();
    Db db = Db();
// define the database schema
    DbTable category = DbTable("aseets")..varchar("name", unique: true);
    DbTable product = DbTable("pictures")
      ..varchar("name", unique: true)
      ..integer("price")
      ..text("descripton", nullable: true)
      ..foreignKey("category", onDelete: OnDelete.cascade)
      ..index("name");
    List<DbTable> schema = [category, product];

    String dbpath = "db.sqlite"; // relative to the documents directory
    db.init(path: dbpath, schema: schema).catchError((e) {
      throw ("Error initializing the database: ${e.message}");
    });

    return dbUtil;
  }
}
