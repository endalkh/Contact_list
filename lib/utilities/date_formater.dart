import 'package:intl/intl.dart';

dateFormatter(date){
  if(date==null){
    return "";
  }
else if(date.isEmpty==true){
    print("empty");
  return "";
}
else{
    final dateFormatter = DateFormat('yyyy-MM-dd');
    final dateString = dateFormatter.format(DateTime.parse(date));
  return dateString;
}
}

dateFormatterBack(date){
  if(date==null){
    return "";
  }
  else if(date.toString().isEmpty==true){
    return "";
  }
  else {
    return DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").format(DateTime.parse(date));
  }

}