import 'package:intl/intl.dart';

dateFormatter(date){
  if(date==null){
    return "";
  }
else if(date.toString().isEmpty){
  return date;
}
else{
  return DateFormat.yMMMd().format(DateTime.parse(date));
}
}