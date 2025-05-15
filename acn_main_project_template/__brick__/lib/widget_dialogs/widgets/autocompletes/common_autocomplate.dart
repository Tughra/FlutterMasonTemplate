import 'package:flutter/services.dart';
import 'package:{{project_file_name}}/core/functions/global_functions.dart';
import 'package:{{project_file_name}}/model_view/common/auto_complete_provider.dart';
import 'package:{{project_file_name}}/models/common/base_autocomplete_model.dart';
import 'package:{{project_file_name}}/models/management.dart';
import 'package:{{project_file_name}}/utils/constants/values_manager.dart';
import 'package:{{project_file_name}}/views/common/un_loaded_page.dart';
import 'package:{{project_file_name}}/widget_dialogs/widgets/autocompletes/item/autocomplete_list_item.dart';
import 'package:{{project_file_name}}/widget_dialogs/widgets/buttons/auto_complete_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:{{project_file_name}}/widget_dialogs/widgets/customs/custom_text_form_field.dart';
import 'package:{{project_file_name}}/widget_dialogs/widgets/loadings/main_loading.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class _AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class CommonAutocomplete<T extends MainAutoCompleteProvider,E extends BaseAutoCompleteModel> extends StatefulWidget {
  final TextEditingController textEditingController;
  final T? injectedWhenNestedProvider;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final bool clearState;
  final String? hintText;
  final String? labelText;
  final AutovalidateMode? autovalidateMode;
  final void Function(E val)? onSelect;
  final void Function(String val)? handleInput;
  final bool enabled;
  final void Function(T provider) refreshRequest;
  final void Function(T provider)? initRequest;

  const CommonAutocomplete(
      {super.key,
      this.hintText,
      this.labelText,
      this.focusNode,
      this.injectedWhenNestedProvider,
      this.inputFormatters,
      required this.textEditingController,
      this.clearState = false,
      this.onSelect,
      this.handleInput,
      this.initRequest,
      this.autovalidateMode,
      required this.enabled,
      required this.refreshRequest});

  @override
  State<CommonAutocomplete<T,E>> createState() => _CommonAutocompleteState<T,E>();
}

class _CommonAutocompleteState<T extends MainAutoCompleteProvider,E extends BaseAutoCompleteModel> extends State<CommonAutocomplete<T,E>> {
  late double _padding;
  late double _areaSize;
  late final T provider;
  @override
  void initState() {
    super.initState();
    provider = widget.injectedWhenNestedProvider??context.read<T>();
    if (widget.initRequest != null) {
      widget.initRequest!(context.read<T>());
    }
  }
  @override
  Widget build(BuildContext context) {
    final textFieldHeight = maxScreenWidth(MediaQuery.sizeOf(context).width) * .11;
    _areaSize = widget.handleInput != null ? MediaQuery.sizeOf(context).height / 2 : MediaQuery.sizeOf(context).height;
    _padding = MediaQueryData.fromView(View.of(context)).padding.top;
    return Stack(
      children: [
        CustomTextFormField(
          minHeight: textFieldHeight,
          hintText: widget.hintText ?? 'Lütfen Seçiniz',
          labelText: widget.labelText ?? 'Lütfen Seçiniz',
          filled: true,inputFormatters: widget.inputFormatters,
          focusNode: widget.handleInput!=null?widget.focusNode:_AlwaysDisabledFocusNode(),
          autoValidateMode: widget.autovalidateMode,
          textInputAction: TextInputAction.done,
          onChanged: widget.handleInput,
          onTap: () {
            if(widget.handleInput==null){
              provider.resetSearched();
              showModal(context);
            }
          },
          validator: (val) {
            if (val?.isEmpty == true) {
              return "Lütfen zorunlu alanları doldurunuz.";
            } else {
              return null;
            }
          },
          enabled: widget.enabled,
          readOnly: widget.handleInput==null,
          controller: widget.textEditingController,
          suffixIcon:widget.handleInput!=null?null:Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: RotatedBox(
              quarterTurns: 1,
              child: Icon(
                FontAwesomeIcons.play,
                color: Theme.of(context).primaryColor,
                size: textFieldHeight * .25,
              ),
            ),
          ),
        )
        /*
        if (widget.textEditingController.text.isNotEmpty) buildClear(),
         */
      ],
    );
  }

  Positioned buildClear() {
    return Positioned(
      right: 0,
      top: 0,
      child: IconButton(
        icon: const Icon(Icons.clear, color: Colors.grey),
        onPressed: () {
          setState(() => widget.textEditingController.clear());
        },
        splashRadius: 24,
      ),
    );
  }

  void showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      builder: (_) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            color: Colors.transparent,
            margin: isKeyboardOpen() ? const EdgeInsets.only(bottom: 0, top: 0) : const EdgeInsets.only(top: 0.0),
            height: _areaSize,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: _padding),
                  child: const AutoCompleteButton(),
                ),
                Expanded(
                    child: ColoredBox(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: widget.handleInput != null
                      ? buildBottomHandleInput()
                      : Column(
                          children: [
                            buildBottomSheetSearchInput(context),
                            Expanded(
                              child: ColoredBox(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                child: buildBottomSheetList(),
                              ),
                            ),
                          ],
                        ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }

  //gerek kalmadı
  Widget buildBottomHandleInput() {
    return Center(
      child: TextField(
        onChanged: widget.handleInput,
        decoration: InputDecoration(hintText: "Değer Giriniz",border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
      ),
    );
  }

  Widget buildBottomSheetList() {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Consumer<T>(builder: (_, value, child) {
        if (value.autocompleteReturner.viewStatus == ViewStatus.stateError) {
          return Center(child: UnloadedPage(onPressed: () => widget.refreshRequest(value)));
        }
        if (value.autocompleteReturner.viewStatus == ViewStatus.stateLoading) {
          return const Center(child: PageLoadingWidget());
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    itemBuilder: (context, index) {
                      return AutocompleteListItem(
                        alignment: IconPosition.left,
                        title: value.searchedItemList[index].name ?? "",
                        onTap: () {
                          widget.onSelect?.call(value.searchedItemList[index] as E);
                          setState(() => widget.textEditingController.text = value.searchedItemList[index].name ?? "");
                          Navigator.pop(context);
                        },
                      );
                    },
                    itemCount: value.searchedItemList.length,
                    shrinkWrap: true,
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget buildBottomSheetSearchInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: LayoutBuilder(
        builder: (_, BoxConstraints constraints) => CustomTextFormField(
          isDense: false,
          minHeight: maxScreenWidth(constraints.maxWidth) * .18,
          labelText: 'Ara',
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
            suffixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.onSurface),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
          ),
          onChanged: (val) {
            context.read<T>().searchInList(val);
          },
        ),
      ),
    );
  }
}
