import 'package:intl/intl.dart';

dateFormatter(date){
  if(date==null){
    return "";
  }
else if(date.toString().isEmpty){
  return date;
}
else{
    final dateFormatter = DateFormat('yyyy-MM-dd');
    final dateString = dateFormatter.format(DateTime.now());
  return dateString;
}
}

dateFormatterBack(date){
  if(date==null){
    return "";
  }
  else if(date.toString().isEmpty){
    return date;
  }
  else {
    return DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").format(DateTime.parse(date));
  }

}