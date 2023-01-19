import 'package:intl/intl.dart';

String formatDateCus(String formattedString) {
  
DateTime now = DateTime.now();
var formatDate = DateFormat('EEEE, d MMMM y').format(DateTime.parse(formattedString));
return formatDate;
}
