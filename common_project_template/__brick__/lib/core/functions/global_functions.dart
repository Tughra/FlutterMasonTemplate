import 'dart:async';
import 'dart:convert';
import 'package:{{project_file_name}}/utils/constants/assets_manager.dart';
import 'package:{{project_file_name}}/utils/constants/values_manager.dart';
import 'package:{{project_file_name}}/utils/print_log.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String? iconType(int? productID, {int? policyType}) {
  if (policyType == 1) return IconsAssets.heartTickRight;
  switch (productID) {
    case 344:
      return IconsAssets.basicCar;
    case 310:
      return IconsAssets.handCar;
    case 345:
      return IconsAssets.filo;
    case 131:
      return IconsAssets.homeInsurance;
    case 350:
      return IconsAssets.ferdiKaza;
    case 256:
      return IconsAssets.ferdiKaza;
    case 260:
      return IconsAssets.ferdiKaza;
    case 510:
      return IconsAssets.engineering;
    case 401:
      return IconsAssets.transport;
    case 402:
      return IconsAssets.transport;
    case 660:
      return IconsAssets.personalData;
    case 650:
      return IconsAssets.personalDefence;
    case 158:
      return IconsAssets.legalProtect;
    case 700:
      return IconsAssets.agriculture;
    case 133:
      return IconsAssets.homeInsurance;
    case 140:
      return IconsAssets.fire;
    case 141:
      return IconsAssets.fireOffice;
    case 199:
      return IconsAssets.dask;
    case 270:
      return IconsAssets.personalDefence;
    case 197:
    case 214:
    case 216:
    case 202:
    case 298:
      return IconsAssets.heartTickRight;
    default:
      return null;
  }
}
Color generateColorByIndex(int index) {
  // Renkleri üretmek için rastgele başlangıç noktası belirleyelim
  double hue = (index * 137.5) % 360; // Renk tonunu (hue) hesapla
  double saturation = 0.8; // Doyma (saturation) değeri
  double value = 0.8; // Parlaklık (value) değeri

  // HSV renk modelini kullanarak Color nesnesi oluştur
  HSVColor hsvColor = HSVColor.fromAHSV(1.0, hue, saturation, value);

  // Oluşturulan HSV renk modelini Color nesnesine dönüştür
  return hsvColor.toColor();
}
double  deviceResponsiveRatio({double minAspect=1,double maxAspect=2,required BuildContext context}){
  final double screenAspectRatio = MediaQuery.of(context).size.aspectRatio;
  // Matematiksel Formül ile Aspect Ratio Hesaplama
  const double minAspectRatio = 0.45; // Minimum eşik
  const double maxAspectRatio = 0.75; // Maksimum eşik
  final double minContainerAspect = minAspect; // Minimum Container Aspect Ratio
  final double maxContainerAspect = maxAspect; // Maksimum Container Aspect Ratio

  double containerAspectRatio;
  if (screenAspectRatio <= minAspectRatio) {
    containerAspectRatio = minContainerAspect;
  } else if (screenAspectRatio >= maxAspectRatio) {
    containerAspectRatio = maxContainerAspect;
  } else {
    // Orantısal olarak hesapla
    containerAspectRatio = minContainerAspect +
        (maxContainerAspect - minContainerAspect) *
            ((screenAspectRatio - minAspectRatio) /
                (maxAspectRatio - minAspectRatio));
  }
  return containerAspectRatio;
}

String formatNumberAbbreviation(double number) {
  final value = number.isNegative ? number * -1 : number;
  if (value >= 1000 && value < 1000000) {
    return '${number.isNegative ? "-" : ""}${(value / 1000).toStringAsFixed(1)}k';
  } else if (value >= 1000000 && value < 1000000000) {
    return '${number.isNegative ? "-" : ""}${(value / 1000000).toStringAsFixed(2)}M';
  } else if (value >= 1000000000) {
    return '${number.isNegative ? "-" : ""}${(value / 1000000000).toStringAsFixed(3)}B';
  } else {
    return value.toString();
  }
}

/*
String detectMessageType(MessageType messageType){
  switch(messageType){
    case MessageType.blockedMessage:
      return "1";
    case MessageType.textMessage:
      return "2";
    case MessageType.voiceMessage:
      return "3";
    case MessageType.imageMessage:
      return "4";
  }
}
 */
bool isNumeric(String? s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

String messageIconAccordingType(String messageType, {required String message}) {
  switch (messageType) {
    case "1":
      return "❌";
    case "2":
      return message;
    case "3":
      return "🔊";
    case "4":
      return "🏞";
    default:
      return message;
  }
}
/*
String messageIconAccordingEnumMsgType(MessageType? messageType,{required String message}){
  switch(messageType){
    case MessageType.blockedMessage:
      return "❌";
    case MessageType.textMessage:
      return message;
    case MessageType.voiceMessage:
      return "🔊";
    case MessageType.imageMessage:
      return "🏞";
    default :
      return message;
  }
}
 */
/*
MessageType detectMessageTypeFromInt(int? messageType){
  switch(messageType){
    case 1:
      return MessageType.blockedMessage;
    case 2:
      return MessageType.textMessage;
    case 3:
      return MessageType.voiceMessage;
    case 4:
      return MessageType.imageMessage;
    default:{
      return MessageType.textMessage;
    }
  }
}
 */

String getShortLangFromFullCode(String? fullCode) {
  if (fullCode == null) {
    return "en";
  } else {
    final List<String> splitLang = fullCode.split("_");
    if (splitLang.length == 2) {
      return splitLang.first;
    } else {
      return "en";
    }
  }
}

String parsePlaka(String plate) {
  try {
    // İlk numerik kısmı bul (ilk sayıları al)
    List<String> plaka = plate.split("");
    int firstNumericEndIndex = plaka.indexWhere((char) => !isNumeric(char));
    String numeric1 = plate.substring(0, firstNumericEndIndex);

    // Orta kısım (harfler) ve ikinci numerik kısmı bul
    int secondNumericStartIndex = plaka.indexWhere((char) => isNumeric(char), firstNumericEndIndex);
    String word = plate.substring(firstNumericEndIndex, secondNumericStartIndex);
    String numeric2 = plate.substring(secondNumericStartIndex);
    return "$numeric1 $word $numeric2";
  } catch (e) {
    debugShow(e);
    return plate;
  }
}

bool isKeyboardOpen() {
  return WidgetsBinding.instance.window.viewInsets.bottom > 0.0;
}

Future closeKeyboard() async {
  await SystemChannels.textInput.invokeMethod('TextInput.hide');
}

void openKeyboard() {
  SystemChannels.textInput.invokeMethod('TextInput.show');
}

Map<String, dynamic> parseJwt(String? token) {
  if (token != null && token.isNotEmpty) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = decodeBase64(parts[1]);
    final payloadMap = jsonDecode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }
    return payloadMap;
  } else {
    return {'Hata': 'Token Data Boş'};
  }
}

String decodeBase64(String str) {
  //debugPrint("DECODE BASE64 === " + str);
  var output = str.replaceAll('-', '+').replaceAll('_', '/');
  //debugPrint("DECODE BASE64 CONVERTED === " + output);

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

//  pLogDebug("DECODE IMAGE", utf8.decode(base64Url.decode(output)));
  return utf8.decode(base64Url.decode(output));
}

/*
usingPremiumFeatures(VoidCallback function){
if(MyUserInfo.isPremium){
  function();
}else{
  PremiumSheetDialog.openBottomSheet();
}
}
 */
Function throttleFunction(void Function() callback, Duration duration) {
  Timer? timer;
  return () {
    timer ??= Timer(duration, () {
      callback();
      timer?.cancel();
      timer = null;
    });
  };
}

deBouncer(Future<void> callback, Duration? duration) {
  final debounce = Debouncer(delay: duration ?? const Duration(milliseconds: 100));
  debounce.call(() {
    callback;
  });
}

bool validateTC(String tc) {
  if (tc.length != 11) {
    return false;
  } else {
    if (tc.substring(0, 1) == '0') {
      return false;
    } else {
      int o, th, f, s, n, tw, fr, sx, ei;
      o = int.parse(tc[0]);
      th = int.parse(tc[2]);
      f = int.parse(tc[4]);
      s = int.parse(tc[6]);
      n = int.parse(tc[8]);
      tw = int.parse(tc[1]);
      fr = int.parse(tc[3]);
      sx = int.parse(tc[5]);
      ei = int.parse(tc[7]);

      var calcOtfsn = (o + f + th + s + n) * 7;
      var calcTwfrsxei = tw + fr + sx + ei;

      var eleventh = (o + f + th + s + n + tw + fr + sx + ei + int.parse(tc[9])) % 10;

      var tenth = (calcOtfsn - calcTwfrsxei) % 10;
      if (int.parse(tc[9]) == tenth && int.parse(tc[10]) == eleventh) {
        return true;
      } else {
        return false;
      }
    }
  }
}

bool validateForeignIdentityNumber(String identityNumber) {
  if (identityNumber.length != 11) {
    return false; // Kimlik numarası 11 haneli olmalıdır.
  }

  List<int> digits = identityNumber.split('').map(int.parse).toList();

  // Kimlik numarasının ilk hanesi 0 olamaz.
  if (digits[0] == 0) {
    return false;
  }

  int firstDigitSum = digits[0] + digits[2] + digits[4] + digits[6] + digits[8];
  int secondDigitSum = digits[1] + digits[3] + digits[5] + digits[7];
  int tenthDigit = (firstDigitSum * 7 - secondDigitSum) % 10;

  if (digits[9] != tenthDigit) {
    return false; // Onuncu hane doğrulaması başarısız.
  }

  int eleventhDigit = (firstDigitSum + secondDigitSum + tenthDigit) % 10;

  if (digits[10] != eleventhDigit) {
    return false; // On birinci hane doğrulaması başarısız.
  }

  return true;
}

String formatDateDifference(DateTime startDate, DateTime endDate) {
  if (endDate.isBefore(startDate)) {
    /*
    final temp =startDate;
    startDate = endDate;
    endDate = temp;
     */
    return "Süre Bitti";
  }

  int months = endDate.month - startDate.month;
  int days = endDate.day - startDate.day;
  int hours = endDate.hour - startDate.hour;

  /*
  if (hours < 0) {
    days--;
    hours += 24;
  }
  if (days < 0) {
    months--;
    days += DateTime(startDate.year, startDate.month + 1, 0).day;
  }
  if (months < 0) {
    months += 12;
  }
   */

  String result = "";
  if (months > 0) {
    result += "$months ay ";
  }
  if (days > 0) {
    result += "$days gün ";
  }
  if (hours > 0) {
    result += "$hours saat";
  }

  return result.trim();
}

Color generateColor(int index, {double saturationFactor = 1.0, doublebrightnessFactor = 1.0}) {
  int baseRed = 247;
  int baseGreen = 93;
  int baseBlue = 95;

  // Index değerine göre renk değerlerini değiştir
  int red = (baseRed + (index * 10)) % 256;
  int green = (baseGreen + (index * 20)) % 256;
  int blue = (baseBlue + (index * 15)) % 256;

  return Color.fromRGBO(red, green, blue, 1.0);
}

Color hexToColor(String? hex) {
  try {
    // Eğer '#' işareti varsa, kaldırıyoruz.
    if ((hex ?? "").isEmpty) return AppColor.primaryColor;
    hex = hex!.replaceAll('#', '');

    // Eğer şeffaflık için 8 karakterlik bir hex değeri yoksa, 6 karakterlik bir değer olduğunu varsayıp şeffaflık ekliyoruz.
    if (hex.length == 6) {
      hex = 'FF' + hex; // FF -> Opaklık (255)
    }

    // 16'lık tabanda integer değere çeviriyoruz ve Color nesnesini oluşturuyoruz.
    return Color(int.parse(hex, radix: 16));
  } catch (_) {
    return AppColor.primaryColor;
  }
}

IconData iconFromString(String? hex) {
 try{
   if (hex == null) return Icons.notifications_none_outlined;
   final int? data = int.tryParse(hex);
   if (data != null) return IconData(data, fontFamily: "MaterialIcons");
   return Icons.notifications_none_outlined;
 }catch(_){
   return Icons.notifications_none_outlined;
 }
}

/*

String daysBetween(DateTime? timeStamp) {
  if (timeStamp == null) {
    return "";
  } else {
    final from =
        DateTime(timeStamp.year, timeStamp.month, timeStamp.day, timeStamp.hour, timeStamp.minute, timeStamp.second);
    DateTime to = DateTime.now();
    if (to.difference(from).inHours < 24) {
      if (to.difference(from).inMinutes < 60) {
        if (to.difference(from).inSeconds < 60) {
          return "user.msg_list.msg_time_now".translateMap();
        }
        return "${(to.difference(from).inMinutes).round()} m";
      }
      return "${(to.difference(from).inHours).round()} h";
    } else {
      return "${(to.difference(from).inHours / 24).round()} d";
    }
  }
}

String timePassed(DateTime? timeStamp) {
  if (timeStamp == null) {
    return "";
  } else {
    final from =
        DateTime(timeStamp.year, timeStamp.month, timeStamp.day, timeStamp.hour, timeStamp.minute, timeStamp.second);
    DateTime to = DateTime.now();
    if (to.difference(from).inHours < 24) {
      if (to.difference(from).inSeconds < 60) {
        return "user.msg_list.msg_time_now".translateMap();
      }
      return DateFormat("HH:mm").format(from);
    } else {
      return DateFormat("dd/MM/yyyy").format(from);
    }
  }
}
 */