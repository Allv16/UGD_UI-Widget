import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperReservation {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE reservation(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        date TEXT,
        time TEXT,
        doctorName TEXT,
        userEmail TEXT
      )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('reservation.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> addReservation(
      String date, String time, String doctorName, String userEmail) async {
    final db = await SQLHelperReservation.db();
    final data = {
      'date': date,
      'time': time,
      'doctorName': doctorName,
      'userEmail': userEmail,
    };
    return await db.insert('reservation', data);
  }

  //read user
  static Future<List<Map<String, dynamic>>> getUser(String email) async {
    final db = await SQLHelperReservation.db();
    return db
        .query('reservation', where: 'userEmail LIKE ?', whereArgs: [email]);
  }

  static Future<List<Map<String, dynamic>>> getUserByName(
      String query, String email) async {
    final db = await SQLHelperReservation.db();
    return db.query('reservation',
        where: "userEmail = ? AND doctorName LIKE ?",
        whereArgs: [email, '%$query%']);
  }

  static Future<int> editReservation(String date, String time, int id) async {
    final db = await SQLHelperReservation.db();
    final data = {
      'date': date,
      'time': time,
    };
    return await db.update('reservation', data, where: "id = $id");
  }

  static Future<int> deleteReservation(int id) async {
    final db = await SQLHelperReservation.db();
    return await db.delete('reservation', where: "id = $id");
  }
}
