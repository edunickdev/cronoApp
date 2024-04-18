import 'package:cronoapp/domain/entities/person_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static Future<Database> _openDB() async {
    String tableName = 'customs';

    return openDatabase(join(await getDatabasesPath(), 'CustomDB.db'),
        onCreate: (db, version) {
      return db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY, 
            title TEXT, 
            exerciseDurationTime TEXT, 
            breakDurationTime TEXT, 
            cycles INTEGER
          )
        ''');
    }, version: 1);
  }

  static Future<int> addConfig(PersonConfig newPerson) async {
    Database myDB = await _openDB();

    return myDB.insert(
      'customs',
      newPerson.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deleteConfig(PersonConfig newPerson) async {
    Database myDB = await _openDB();

    return myDB.delete('customs', where: 'id = ?', whereArgs: [newPerson.id]);
  }

  static Future<int> updateConfig(PersonConfig newPerson) async {
    Database myDB = await _openDB();

    return myDB.update('customs', newPerson.toMap(),
        where: 'id = ?', whereArgs: [newPerson.id]);
  }

  static Future<List<PersonConfig>> getCustoms() async {
    Database myDB = await _openDB();

    final myData = await myDB.query('customs');

    return List.generate(
      myData.length,
      (index) => PersonConfig(
        id: myData[index]['id'] as int,
        title: myData[index]['title'] as String, 
        exerciseDurationTime: myData[index]['exerciseDurationTime'] as String, 
        breakDurationTime: myData[index]['breakDurationTime'] as String, 
        cycles: myData[index]['cycles'] as int,
      )
    );
  }
}
