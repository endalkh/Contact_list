prefixRemover(val){
  String pattern = r'(^(?:[+])[0-9]{10,12}$)';
  RegExp regExp = new RegExp(pattern);
  String number=val;
  if (regExp.hasMatch(number)) {
    number = val.replaceAll(RegExp(r'\+'), '');
    number = number.substring(1);
    number = number.replaceAll(RegExp(r'[^\w\s\g]+'), '');
    number = number.replaceAll(RegExp(' '), '');
  }
  else{
    number = number.replaceAll(RegExp(r'[^\w\s\g]+'), '');
    number = number.replaceAll(RegExp(' '), '');
  }
  return number;
}