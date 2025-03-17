import 'package:intl/intl.dart';

extension RemoveSpecialCharString on String {
  String removeSpecialCharString() {
    return replaceAll(RegExp('[^0-9]'), '');
  }
}

extension PhoneNumberMasking on String {
  String maskPhoneNumber() {
    if (length <= 3) {
      return this;
    }

    // Mask all digits except the last three
    String maskedPart = '*' * (length - 3);
    String visiblePart = substring(length - 3);

    return '$maskedPart$visiblePart';
  }
}


String handleStringNull(dynamic value) {
  if (value == null) return "";
  return value.toString();
}

String getKeyByValueFromMap(Map<String,String> map,String? value){
  return map.keys.firstWhere(
          (k) => map[k] == value, orElse: () => "");
}

String maskedPhone(String phoneNumber){
  return phoneNumber.replaceAllMapped(RegExp(r'^(\d{3})(\d*)$'), (match) => '${match[1]}${'*' * match[2]!.length}');
}

String formatDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  String formattedDate = DateFormat('EEEE, d MMMM y').format(dateTime);
  return formattedDate;
}

String formatDate2(String dateStr) {
  DateFormat inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
  DateTime parsedDate = inputFormat.parseUtc(dateStr);

  DateFormat outputFormat = DateFormat("dd MMMM yyyy - HH:mm");
  String formattedDate = outputFormat.format(parsedDate);

  return formattedDate;
}

extension NullSafeIntToString on int? {
  String checkNull() {
    return this?.toString() ?? '0';
  }
}