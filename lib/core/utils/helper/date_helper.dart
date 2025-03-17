import 'package:intl/intl.dart';

class DateHelper {
  static String getMonthNameInBahasa(DateTime date) {
    return DateFormat('MMMM yyyy', 'id').format(date);
  }
}