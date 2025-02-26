
extension StringExtensions on String {
  String replaceCurl(String arg) {
    String value = this;
    value = value.replaceAll("{}", arg);
    return value;
  }


  String convertCallPhoneNumber(){
    final String phoneNumber = this;
    String cleanedNumber = phoneNumber.replaceAll(RegExp(r'\s|\(|\)'), '');
    if(cleanedNumber.length==7)return cleanedNumber;
    if (!cleanedNumber.startsWith('0')) {
      cleanedNumber = "0$cleanedNumber";
    }
    return cleanedNumber;
  }
  String maskValue(){
     String value = this;
    if(value.isNotEmpty&&value.length>=3){
      value=value.replaceRange(1, value.length-1, "***********");
    }
    return value;
  }
  String formatPhoneNumber() {
    //905321777788
    //02122169191
    final String phoneNumber = this;
    final formattedNumber = StringBuffer();
    if(phoneNumber.isEmpty) return this;


    String cleanedNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
    if(cleanedNumber.length==7){
      for (var i = 0; i < cleanedNumber.length; i++) {
        if (i == 3 || i == 4) {
          formattedNumber.write(' ');
        }
        formattedNumber.write(cleanedNumber[i]);
      }
      return formattedNumber.toString();
    }else{
      if(phoneNumber.startsWith("0")){
        for (var i = 0; i < cleanedNumber.length; i++) {
          if (i == 4 || i == 7) {
            formattedNumber.write(' ');
          }
          formattedNumber.write(cleanedNumber[i]);
        }
        return formattedNumber.toString();
      }
      if(phoneNumber.startsWith("9")){
        formattedNumber.write('+');
        for (var i = 0; i < cleanedNumber.length; i++) {
          if (i == 2 || i == 5 || i==8) {
            formattedNumber.write(' ');
          }
          formattedNumber.write(cleanedNumber[i]);
        }
        return formattedNumber.toString();
      }
      else{
        formattedNumber.write('0 ');
        for (var i = 0; i < cleanedNumber.length; i++) {
          if (i == 3 || i == 6) {
            formattedNumber.write(' ');
          }
          formattedNumber.write(cleanedNumber[i]);
        }
        return formattedNumber.toString();
      }
    }


  }
  String capitalizeFirstLetter() {
    final String sentence = this;
    List<String> words = sentence.split(' ');

    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
      }
    }

    return words.join(' ');
  }
  String fileNameFromPath(){
    final path = this;
    List<String> parsedPath = path.split("/");
    if(parsedPath.isNotEmpty){
      return parsedPath.last;
    }else{
      return this;
    }
  }
  String removeUnnecessarySpace(){
    final String sentence = this;
    return  sentence.replaceAll(RegExp(r'\s+'), ' ').trim();
  }
}
/*
    String translateMap() {
    final String value = this;
    List<String> keys = value.split(".");
    late String? translated;
    try {
      translated = GetIt.instance<LanguageTranslationProvider>()
          .normalTranslation[keys.first]?[keys[1]]?[keys.last];
      if (translated != null) {
        return translated;
      } else {
        translated = GetIt.instance<LanguageTranslationProvider>()
            .fallbackTranslation[keys.first][keys[1]][keys.last];
        if (translated != null) {
          return translated;
        }else{
          return "Untranslated";
        }
      }
    } catch (e) {

      return "Untranslated";
    }
  }

 */