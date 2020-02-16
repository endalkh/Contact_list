
 String getRoundLetter(String val ){
  String text=val!=null?val:"";
  if(text.length>0) {
    String initialChar = text[0];
    String lastChar = "";
    for (int i = 0; i < text.length; i++) {
      var char = text[i];
      if (char == " ") {
        i++;
        lastChar = text[i];
        break;
      }
    }
    return initialChar + lastChar;
  }
  else{
    return "";
  }

}