import 'package:intl/intl.dart';

class FormattedDate {
  static String getCurrentDate({required String date}) {
    final parse = DateTime.parse(date).toLocal();
    final formatter = DateFormat('dd-MMMM-yyyy');
    return formatter.format(parse);
  }

  static String getCurrentTimes({required String date}) {
    final parse = DateTime.parse(date).toLocal();
    final formatter = DateFormat('HH:mm');
    return formatter.format(parse);
  }
}
