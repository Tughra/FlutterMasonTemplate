import 'package:intl/intl.dart';

String convertCurrency({required double price,required String? currency,bool showSymbol=true}){
  final curModel = _currencyConvert(currency);
  var format = NumberFormat.currency(
    locale: curModel.locale,
    symbol: '',decimalDigits: 2,
  );
  //format.currencySymbolPosition = CurrencySymbolPosition.suffix;
  String formattedValue = '${format.format(price)}${showSymbol?' ${curModel.currencySymbol}':""}';

  return formattedValue;
}
CurrencyModel _currencyConvert(String? currency){
  final cur =  currency??"";
  switch(cur.toUpperCase()){
    case "TRY":
      return CurrencyModel(locale: 'tr_TR', currencySymbol: '₺');
    case "EUR":
      return CurrencyModel(locale: 'de_DE', currencySymbol: '€');
    case "USD":
      return CurrencyModel(locale: 'en_US', currencySymbol: '\$');
    default:
      return CurrencyModel(locale: 'tr_TR', currencySymbol: '?');
  }

}
String formatZeroDecimal(double? number,{int decimalCount=2}) {
  if(number==null)return "Veri Yok";
  if (number == number.toInt()) {
    return number.toInt().toString();} else {
    return number.toStringAsFixed(decimalCount);
  }
}
class CurrencyModel{
  final String locale;
  final String currencySymbol;
CurrencyModel({required this.locale,required this.currencySymbol});
}