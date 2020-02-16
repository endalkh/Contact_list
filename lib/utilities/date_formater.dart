import 'package:intl/intl.dart';

dateFormatter( date){
  return DateFormat.yMMMd().format(DateTime.parse(date));
}