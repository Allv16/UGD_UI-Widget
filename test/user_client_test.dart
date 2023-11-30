import 'package:flutter_test/flutter_test.dart';
import 'package:ugd_ui_widget/model/user.dart';
import 'package:ugd_ui_widget/client/userClient.dart';

void main() {
  test('login success', () async {
    final hasil = await UserClient.login('1@', '12345');
    expect(hasil?.email, equals('1@'));
    expect(hasil?.password, '12345');
  });
  test('login failed', () async {
    final hasil = await UserClient.login('invalid', '12345');
    expect(hasil, null);
  });

  test('register success', () async {
    final hasil = await UserClient.register(User(
        email: 'testing@',
        username: 'testing',
        password: '12345',
        noTelp: '12345',
        tglLahir: '2021-01-01',
        profilePath: '-1'));
    expect(hasil.statusCode, 200);
  });

  test('email exists', () async {
    final hasil = await UserClient.checkEmail('testing@');
    expect(hasil, true);
  });
}
