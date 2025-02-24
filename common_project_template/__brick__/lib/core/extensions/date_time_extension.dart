
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {

  String parseDate(){
    DateTime dateTime = this;
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }
  String parseDateYMDkebabCase(){
    DateTime dateTime = this;
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }
  String parseDateWithHour(){
    DateTime dateTime = this;
    String formattedDate = DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
    return formattedDate;
  }
  String parseDateDayMonth(){
    DateTime dateTime = this;
    String formattedDate = DateFormat('d MMMM EEEE', "tr").format(dateTime);
    return formattedDate;
  }
  String parseDateDayMonthYear(){
    DateTime dateTime = this;
    String formattedDate = DateFormat('d MMMM EEEE yyyy', "tr").format(dateTime);
    return formattedDate;
  }
  String parseDateDayMonthHour(){
    DateTime dateTime = this;
    String formattedDate = DateFormat('d MMMM EEEE yyyy HH:mm', "tr").format(dateTime);
    return formattedDate;
  }
}