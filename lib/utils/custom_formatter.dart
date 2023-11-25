import 'package:intl/intl.dart';

class CustomeFormatter {
  static String indonesianDateFormat(String date) {
    print(date);
    DateTime dateTime = DateFormat('yyyy-MM-dd', 'en_US').parse(date);
    final formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }

  static String phoneNumberFormat(String phoneNumber) {
    List<String> chunks = [];
    for (int i = 0; i < phoneNumber.length; i += 4) {
      int endIndex = i + 4;
      if (endIndex > phoneNumber.length) {
        endIndex = phoneNumber.length;
      }
      chunks.add(phoneNumber.substring(i, endIndex));
    }

    // Join the chunks with spaces
    String formattedNumber = chunks.join(' ');

    return formattedNumber;
  }
}
