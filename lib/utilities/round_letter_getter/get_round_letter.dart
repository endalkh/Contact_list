
 String getRoundLetter(String text ){
  String initialChar=text[0];
  String lastChar="";
   for(int i=0; i<text.length; i++) {
     var char = text[i];
     if(char==" "){
       i++;
       lastChar=text[i];
       break;
     }


   }
   return initialChar+lastChar;

}