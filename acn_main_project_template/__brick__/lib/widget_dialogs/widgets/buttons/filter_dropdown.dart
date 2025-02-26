import 'package:flutter/material.dart';
import 'package:{{project_file_name}}/utils/constants/values_manager.dart';


class FilterDropdownWidget<T> extends StatelessWidget {
  final T? initialValue;
  final String? hint;
  final List<DropdownMenuItem<T>>? items;
  final bool showBorder;
  final void Function()? onTap;
  final void Function(T?)? onChanged;
  final String? labelText;

  const FilterDropdownWidget({Key? key,this.labelText, this.hint, this.initialValue, this.items, this.onTap, this.onChanged,this.showBorder=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<T>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            //labelText: hint,
              label:labelText==null?null: Text(labelText??"",style:const TextStyle(color: Colors.grey,fontSize: 12)),
              //labelStyle: const TextStyle(color: Colors.grey,fontSize: 13),
              isCollapsed: showBorder,
              focusedBorder:!showBorder? InputBorder.none:  OutlineInputBorder(borderSide: BorderSide(width: .5,color: Theme.of(context).secondaryHeaderColor), borderRadius: BorderRadius.all(Radius.circular(10))),
              enabledBorder:!showBorder? InputBorder.none:  OutlineInputBorder(borderSide: BorderSide(width: .5,color: Theme.of(context).secondaryHeaderColor), borderRadius: BorderRadius.all(Radius.circular(10))),
              disabledBorder:!showBorder? InputBorder.none:const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(10))),
              errorBorder:!showBorder? InputBorder.none:const OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.all(Radius.circular(10))),
              errorStyle: const TextStyle(fontSize: 10, height: .1),
              suffixIconConstraints: const BoxConstraints(maxHeight: 18),
              contentPadding: const EdgeInsets.only(left: 8, right: 8),
              border: !showBorder? InputBorder.none:const OutlineInputBorder(borderSide: BorderSide(color: Colors.black), borderRadius: BorderRadius.all(Radius.circular(10))),
              isDense: false,
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 12, color: Colors.grey)),
            icon: const Icon(
              Icons.arrow_drop_down_sharp,
              color: Colors.black,
              size: 18,
            ),
            isExpanded: true,
            padding: EdgeInsets.zero,
            hint: Text(
              hint ?? "",
              style: const TextStyle(fontSize: 12,color: Colors.grey),
            ),
            value: initialValue,
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(ButtonRadius.middle),
            isDense: true,
            items: items,
            onTap: onTap,
            onChanged: onChanged),
      ),
    );
  }
}

class FilterDropdownMenuWidget<T> extends StatelessWidget {
  final T? initialValue;
  final String? hint;
  final List<DropdownMenuEntry<T>>? items;
  final void Function()? onTap;
  final void Function(T?)? onSelected;
  final TextEditingController? controller;

  const FilterDropdownMenuWidget({Key? key, this.controller, this.initialValue, this.hint, this.items, this.onTap, this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: FittedBox(
        child: DropdownMenu<T>(
          initialSelection: initialValue,
          controller: controller,
          hintText: "12321",
          trailingIcon: const Icon(
            Icons.arrow_drop_down_sharp,
            color: Colors.black,
          ),
          inputDecorationTheme: InputDecorationTheme(
              isCollapsed: false,
              isDense: true,
              outlineBorder: const BorderSide(width: 3, color: Colors.black),
              enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1.5, color: Colors.black), borderRadius: BorderRadius.circular(10.5)),
              focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1, color: Colors.black), borderRadius: BorderRadius.circular(10)),
              border: OutlineInputBorder(borderSide: const BorderSide(width: 1, color: Colors.black), borderRadius: BorderRadius.circular(10))),
          // requestFocusOnTap is enabled/disabled by platforms when it is null.
          // On mobile platforms, this is false by default. Setting this to true will
          // trigger focus request on the text field and virtual keyboard will appear
          // afterward. On desktop platforms however, this defaults to true.
          requestFocusOnTap: true,
          onSelected: onSelected,
          dropdownMenuEntries: items ?? [],
        ),
      ),
    );
  }
}

class CustomDropField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool showBorder;
  final bool enabled;
  final String? labelText;

  const CustomDropField({Key? key,this.labelText, this.validator, this.hint, this.enabled = true, this.controller, this.onTap, this.showBorder = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      //decoration:showBorder? BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), color: Colors.white, border: Border.all(width: 1, color: enabled?Colors.black:Colors.grey)):null,
      child: Center(
        child: TextFormField(
          enabled: enabled,
          readOnly: true,
          maxLines: null,
          minLines: null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onTap: onTap,
          validator: validator,
          expands: true,
          style: const TextStyle(fontSize: 13, color: Colors.black),
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          decoration: InputDecoration(
              label:labelText==null?null: Text(labelText??"",style: const TextStyle(color: Colors.grey,fontSize: 11),),
              focusedBorder:showBorder ? const OutlineInputBorder(borderSide: BorderSide(color: Colors.black), borderRadius: BorderRadius.all(Radius.circular(10))):InputBorder.none,
              enabledBorder: showBorder
                  ? const OutlineInputBorder(borderSide: BorderSide(color: Colors.black), borderRadius: BorderRadius.all(Radius.circular(10)))
                  :InputBorder.none,
              disabledBorder:
                  showBorder ? const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(10))) :InputBorder.none,
              errorBorder:
                  showBorder ? const OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.all(Radius.circular(10))) :InputBorder.none,
              errorStyle: const TextStyle(fontSize: 10, height: .1),
              suffixIconConstraints: const BoxConstraints(maxHeight: 18),
              contentPadding:  EdgeInsets.only(left: 8, right: 8,top: (labelText??"").isEmpty?0:8,bottom: 0),
              suffixIcon: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Colors.black,
                  size: 18,
                ),
              ),
              border: showBorder
                  ? const OutlineInputBorder(borderSide: BorderSide(color: Colors.black), borderRadius: BorderRadius.all(Radius.circular(10)))
                  : null,
              isDense: true,
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 12, color: Colors.grey)),
        ),
      ),
    );
  }
}

class CustomDropFieldWithPrefix extends StatelessWidget {
  final String? hint;
  final String title;
  final TextEditingController? controller;
  final void Function()? onTap;

  const CustomDropFieldWithPrefix({Key? key, required this.title, this.hint, this.controller, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration:
          BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), color: Colors.white, border: Border.all(width: 1, color: Colors.black)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DecoratedBox(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                  border: Border.all(color: Colors.black, width: 1)),
              child: SizedBox(
                height: 45,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              )),
          Expanded(
            child: TextField(
              readOnly: true,
              maxLines: null,
              minLines: null,
              onTap: onTap,
              expands: true,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              textAlignVertical: TextAlignVertical.center,
              controller: controller,
              decoration: InputDecoration(
                  suffixIconConstraints: const BoxConstraints(maxHeight: 18),
                  contentPadding: const EdgeInsets.only(left: 8, right: 8),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  hintText: hint,
                  hintStyle: const TextStyle(fontSize: 16, color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }
}
