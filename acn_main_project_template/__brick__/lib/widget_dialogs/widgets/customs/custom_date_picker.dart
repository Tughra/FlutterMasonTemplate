import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:{{project_file_name}}/utils/constants/values_manager.dart';
import 'package:{{project_file_name}}/utils/print_log.dart';
import 'custom_text_form_field.dart';

///todo Cupertino date picker la sürekli time degistirince kasmaya ve sonra ui kitlenmeye basliyor
enum DateType { DMY, YMD }

enum StartDate { TODAY, CUSTOM }

class CustomDatePicker extends StatefulWidget {
  final DateType dateType;
  final void Function(String)? onSelect;
  final Function()? onTab;
  final FocusNode? focusNode;
  final Widget? widget;
  final TextAlign textAlign;
  final double? minHeight;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final CupertinoDatePickerMode pickerMode;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool enabled;
  final bool showInitialDate;
  final EdgeInsets? padding;
  final BorderType borderType;
  final DateTime? initialDate;
  final bool filled;
  final bool isEnabled;
  final bool isMinDate;
  final bool isMaxDate;
  final int addMaxDay, addMaxMonth, addMaxYear;
  final int? day, month, year;

  const CustomDatePicker(
      {Key? key,
      this.dateType = DateType.DMY,
      this.onSelect,
      this.onTab,
        this.filled=false,
      this.textAlign = TextAlign.start,
      required this.controller,
      this.label = "",
      this.validator,
        this.focusNode,
      this.minHeight = 54,
      this.pickerMode = CupertinoDatePickerMode.date,
      this.isEnabled = true,
      this.initialDate,
      this.showInitialDate=false,
      this.onChanged,
      this.widget,
      this.startDate,
      this.hintText = "",
      this.borderType = BorderType.rounded,
      this.padding,
      this.enabled = true,
      this.isMinDate = false,
      this.isMaxDate = false,
      this.day,
      this.month,
      this.year,
      this.addMaxDay = 0,
      this.addMaxMonth = 0,
      this.addMaxYear = 0,
      this.endDate})
      : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late FocusNode _focusNode;
  final inputDateHourFrmt = DateFormat('dd-MM-yyyy-HH-mm');
  String selectedDate = "";

  void widgetListener() {
    if (_focusNode.hasFocus && mounted) {
      showPicker();
      _focusNode.unfocus();
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode??FocusNode();
    _focusNode.addListener(widgetListener);
    if (widget.showInitialDate && widget.initialDate != null && widget.pickerMode == CupertinoDatePickerMode.date) {
      var d = widget.initialDate?.day.toString().padLeft(2, '0');
      var m = widget.initialDate?.month.toString().padLeft(2, '0');
      var y = widget.initialDate?.year;
      if (widget.dateType == DateType.YMD) {
        widget.controller.text = '$y-$m-$d';
      } else {
        widget.controller.text = '$d-$m-$y';
      }
    }
    /*
    if (widget.initialDate != null && widget.pickerMode == CupertinoDatePickerMode.date) {
      var d = widget.initialDate?.day.toString().padLeft(2, '0');
      var m = widget.initialDate?.month.toString().padLeft(2, '0');
      var y = widget.initialDate?.year;
      if (widget.dateType == DateType.YMD) {
        widget.controller.text = '$y-$m-$d';
      } else {
        widget.controller.text = '$d-$m-$y';
      }
    } else if (widget.initialDate != null && widget.pickerMode == CupertinoDatePickerMode.dateAndTime) {
      String formattedDate = inputDateHourFrmt.format(widget.initialDate!);
      // if(formattedDate.contains("AM")) formattedDate=formattedDate.replaceAll("AM", "Öğleden Önce");
      // else formattedDate=formattedDate.replaceAll("PM", "Öğleden Sonra");
      print(formattedDate);
     // widget.controller.text = formattedDate;

      debugPrint(widget.controller.text);
      debugPrint("---1-1-1--1-1--");
    }
    */
  }
 @override
  void didUpdateWidget(covariant CustomDatePicker oldWidget) {
   if(widget.showInitialDate) {
     WidgetsBinding.instance.addPostFrameCallback((_){
     if (widget.initialDate != null && widget.pickerMode == CupertinoDatePickerMode.date) {
       var d = widget.initialDate?.day.toString().padLeft(2, '0');
       var m = widget.initialDate?.month.toString().padLeft(2, '0');
       var y = widget.initialDate?.year;
       if (widget.dateType == DateType.YMD) {
         widget.controller.text = '$y-$m-$d';
       } else {
         widget.controller.text = '$d-$m-$y';
       }}
   });
   }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if(widget.focusNode==null)_focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final textFieldHeight = maxScreenWidth(width) * .11;
    return CustomTextFormField(
      minHeight: widget.minHeight??textFieldHeight,
      onTap: widget.onTab,
      isDense: true,
      labelText: widget.label,
      hintText: widget.hintText,
      onChanged: widget.onSelect,
      //onChanged:(text){widget.controller.text=text;},
      enabled: widget.enabled,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      readOnly: true,
      controller: widget.controller,
      focusNode: _focusNode,
      validator: widget.validator,
      filled: widget.filled,
    );  }

  void showPicker() {
    final pickerHeight = MediaQuery.of(context).size.height * .45;
    showCupertinoModalPopup(
        barrierDismissible: false,
        context: context,
        builder: (_) => Material(
              child: Container(
                padding: const EdgeInsets.all(8),
                height:pickerHeight ,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            widget.label,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        const Spacer(),
                        Container(
                            alignment: Alignment.topRight,
                            margin: const EdgeInsets.only(right: 8),
                            child: TextButton(
                                onPressed: () {
                                  final date = widget.isMinDate == true
                                      ? DateTime(widget.year!, widget.month!, widget.day!, DateTime.now().hour,
                                          DateTime.now().minute, 0)
                                      : widget.initialDate ??
                                          DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
                                  var y = int.parse(DateFormat.y().format(date));
                                  var m = int.parse(DateFormat.M().format(date)).toString().padLeft(2, '0');
                                  var d = int.parse(DateFormat.d().format(date)).toString().padLeft(2, '0');
                                  String initialDate = "";
                                  switch (widget.dateType) {
                                    case DateType.DMY:
                                      initialDate = '$d-$m-$y';
                                      break;
                                    case DateType.YMD:
                                      initialDate = '$y-$m-$d';
                                      break;
                                    default:
                                      initialDate = '$d-$m-$y';
                                      break;
                                  }
                                  if (selectedDate.isEmpty || selectedDate == initialDate) {
                                    widget.onSelect?.call(initialDate);
                                    widget.controller.text = initialDate;
                                  } else {
                                    widget.onSelect?.call(selectedDate);
                                    widget.controller.text = selectedDate;
                                  }
                                  Get.back();
                                },
                                child: Text(
                                  "Tamam",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.normal),
                                ))),
                      ],
                    ),
                    const Divider(
                      height: 4,
                      color: Colors.black54,
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * .3, //MediaQuery.of(context).size.width*.9,
                      child: Localizations.override(
                        locale: const Locale("tr", "TR"),
                        context: context,
                        child: CupertinoDatePicker(
                          use24hFormat: true,
                          mode: widget.pickerMode,
                          initialDateTime: widget.isMinDate == true
                              ? DateTime(widget.year!, widget.month!, widget.day!, DateTime.now().hour,
                                  DateTime.now().minute, 0)
                              : widget.initialDate ??
                                  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                          minimumYear: widget.isMinDate == true ? widget.year! : widget.startDate?.year ?? 2018,
                          maximumYear: widget.endDate?.year ?? DateTime.now().year,
                          // gereksiz düzelt
                          minimumDate: widget.isMinDate == true
                              ? DateTime(widget.year!, widget.month!, widget.day!, DateTime.now().hour,
                                  DateTime.now().minute, 0)
                              : DateTime(2020, 1, 1),
                          maximumDate: widget.endDate ??
                              (widget.isMaxDate == true && widget.year != null
                                  ? DateTime(widget.year!, widget.month! + ((widget.addMaxMonth)), widget.day!)
                                  : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)),
                          onDateTimeChanged: (date) {
                            if (widget.pickerMode == CupertinoDatePickerMode.date) {
                              var y = int.parse(DateFormat.y().format(date));
                              var m = int.parse(DateFormat.M().format(date)).toString().padLeft(2, '0');
                              var d = int.parse(DateFormat.d().format(date)).toString().padLeft(2, '0');
                              switch (widget.dateType) {
                                case DateType.DMY:
                                  selectedDate = '$d-$m-$y';
                                  break;
                                case DateType.YMD:
                                  selectedDate = '$y-$m-$d';
                                  break;
                                default:
                                  selectedDate = '$d-$m-$y';
                                  break;
                              }
                              widget.controller.text = selectedDate;
                              if (widget.onSelect != null) {
                                widget.onSelect!(selectedDate);
                              }
                            } else {
                              String formattedDate = inputDateHourFrmt.format(date);
                              // if(formattedDate.contains("AM")) formattedDate=formattedDate.replaceAll("AM", "Öğleden Önce");
                              // else formattedDate=formattedDate.replaceAll("PM", "Öğleden Sonra");
                              debugShow(formattedDate);
                              widget.controller.text = formattedDate;
                              debugShow("*******---********");
                            }
                            //  unFocusScope(context);
                            //  closeKeyboard();
                          },
                          //initialDateTime: DateTime.now(),
                          //locale: EasyLocalization.of(context).locale==LocalizationManager.instance.trLocale?LocaleType.tr  : LocaleType.en,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
