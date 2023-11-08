import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperReservation {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE reservation(
        id TEXT PRIMARY KEY,
        date TEXT,
        time TEXT,
        doctorName TEXT,
        userEmail TEXT,
        bpjs TEXT
      )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('reservation.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> addReservation(String id, String date, String time,
      String doctorName, String userEmail, String bpjs) async {
    final db = await SQLHelperReservation.db();
    final data = {
      'id': id,
      'date': date,
      'time': time,
      'doctorName': doctorName,
      'userEmail': userEmail,
      'bpjs': bpjs,
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
        where: "doctorName LIKE ? AND userEmail = ?",
        whereArgs: ['%$query%', email]);
  }

  static Future<int> editReservation(
      String date, String time, String id, String bpjs) async {
    final db = await SQLHelperReservation.db();
    final data = {'date': date, 'time': time, 'bpjs': bpjs};
    return await db
        .update('reservation', data, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteReservation(String id) async {
    final db = await SQLHelperReservation.db();
    return await db.delete('reservation', where: 'id = ?', whereArgs: [id]);
  }
}
