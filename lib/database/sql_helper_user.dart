import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperUser {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT,
        email TEXT UNIQUE,
        noTelp TEXT,
        tglLahir TEXT
      )
    """);
  }

  //call db
  static Future<sql.Database> db() async {
    return sql.openDatabase('user.db', version: 1,
        onCreate: (sql.Database database, int version) async {
          await createTables(database);
      }
    );
  }

  //insert User
  static Future<int> addUser(String username, String email,String password, String noTelp, String tglLahir) async {
    final db = await SQLHelperUser.db();
    final data = {
      'username': username,
      'password': password,
      'email': email,
      'noTelp': noTelp,
      'tglLahir' : tglLahir,
    };
    try {
      return await db.insert('user', data);
  } catch (e) {
      return -1;
  }
  }


  //read user
  static Future<List<Map<String, dynamic>>> getUser() async {
    final db = await SQLHelperUser.db();
    return db.query('user');
  }

  //update user
  static Future<int> editUser(String username, String email, String noTelp, String tglLahir) async {
    final db = await SQLHelperUser.db();
    final data = {
      'username': username,
      'email': email,
      'noTelp': noTelp,
      'tglLahir' : tglLahir,
    };
    return await db.update('user', data, where: "email = ?", whereArgs: [email]);
  }

  //delete user
  static Future<int> deleteUser(int id) async {
    final db = await SQLHelperUser.db();
    return await db.delete('user', where: "id = $id");
  }

  //search user by email
  static Future<String?> cariUser(String username, String password) async{
    final db = await SQLHelperUser.db();

    List<Map<String, dynamic>> result = await db.query(
      'user',
      columns: ['email'],
      where: 'username = ? AND password =?',
      whereArgs: [username, password],
    );

    if (result.isNotEmpty) {
      return result.first['email'] as String;
    }

    return null; //kalau user tidak ketemu
  }

  //get user by email
  static Future<Map<String, dynamic>?> getUserEmail(String? email) async{
    final db = await SQLHelperUser.db();

    List<Map<String, dynamic>> result = await db.query(
      'user',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty){
      return result.first; 
    }
 
    return null;
  }

  // Search user by email (username) and password
static Future<int> loginUser(String username, String password) async {
  final db = await SQLHelperUser.db();

  List<Map<String, dynamic>> result = await db.query(
    'user',
    columns: ['id'],
    where: 'username = ? AND password = ?',
    whereArgs: [username, password],
  );

  if (result.isNotEmpty) {
    return result.first['id'] as int;
  }

  return -1; // Return -1 if user is not found or login fails
  }

  static Future<bool> isEmailUnique(String email) async {
    final db = await SQLHelperUser.db();

    List<Map<String, dynamic>> result = await db.query(
      'user',
      columns: ['id'],
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return false;
    }

    return true;

  }
}
