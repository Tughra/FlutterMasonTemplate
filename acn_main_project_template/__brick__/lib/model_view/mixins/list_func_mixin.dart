import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:{{project_file_name}}/core/services/image_picker_service.dart';
import 'package:{{project_file_name}}/models/common/file_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:{{project_file_name}}/widget_dialogs/dialogs/loading_dialog.dart';
import 'package:path_provider/path_provider.dart';

mixin PaginationMixin {
  final int pgnItemLimit = 20;
  int paginationCurrentPage = 1;
  int paginationTotalPage = 1;
  bool allowPagination = true;
  resetPaginationCurrentPage() {
    paginationCurrentPage = 1;
  }
}

mixin LoadingDialogMixin {
  showLoadingDialog() {
    LoadingDialog.show(
        hasTimeOut: false,
        backgroundColor: Colors.black.withOpacity(0.5),
        blurEffect: true,
        indicatorColor: Colors.white);
  }
  showLoadingViaContext(BuildContext context){
    LoadingDialog.showViaContext(context);
  }
   closeLoadingViaContext(BuildContext context) {
    Navigator.pop(context);
  }
   closeLoadingViaLastRoot(String rootName) {
     LoadingDialog.closeViaLastRoot(rootName);
  }
   closeLoadingAllDialogs() {
     LoadingDialog.closeAllDialogs();
  }
  closeLoadingDialog() {
    LoadingDialog.close();
  }
}

mixin SaveFileMixin {
  Future<File> downloadAndSavePdf({required String fileName,required List<int>bytes}) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = fileName.split(".").last!="pdf"?'$fileName.pdf':fileName;
    final file = File('${directory.path}/$name');//final file = File('${directory.path}/${url.substring(url.length - 11)}.pdf');
    /*if (await file.exists()) {
      return file;
    }
     */
    await file.writeAsBytes(bytes);
    return file;
  }
  Uint8List base64ToUint8List(String base64String) {
    final List<int> bytes = base64.decode(base64String);
    return Uint8List.fromList(bytes);
  }
}
mixin FilePickerMixin on ChangeNotifier{
  final List<PlatformFile> _platformFiles = List.empty(growable: true);
  final List<String> _allowedFileExtensions = ["jpeg","png","pdf","jpg"];
  final List<SendFileInfo> _selectedFiles = List.empty(growable: true);
  List<SendFileInfo> get selectedFiles => _selectedFiles;
  final ImagePickerService _pickerService = ImagePickerService.instance;
  bool _checkFileExtension(String extension){
    return _allowedFileExtensions.contains(extension);
  }
  disposeFileAll(){
    _selectedFiles.clear();
    _platformFiles.clear();
  }
  removeFiles(int index) {

    _platformFiles.removeAt(index);
    _selectedFiles.removeAt(index);
    notifyListeners();
  }
  /// 1 is image 2 is file
  Future<bool> selectFiles(int fileType,Function(String errorText) onError) async {
    final pickedFiles = await _pickerService.pickFile(fileType);
    List<PlatformFile> tempPlatformFiles = [];
    int totalSize = 0;
    // max 3 total 10 mb
    if (pickedFiles != null) {
      tempPlatformFiles = [..._platformFiles, ...pickedFiles.files];
      if (tempPlatformFiles.length > 3) {
        onError.call("En fazla 3 dosya seçebilirsiniz");
      } else {
        if (_platformFiles.isEmpty) {
          for (var element in pickedFiles.files) {
            totalSize += element.size;
            if (_pickerService.convertToMegabytes(totalSize) > 10) {
              onError.call("Seçtiğiniz dosyalar 10Mb sınırını geçmemeli");
            } else {
              if(element.extension!=null&&_checkFileExtension(element.extension!)){
                _platformFiles.add(element);
                final directory = await getApplicationDocumentsDirectory();
                final file = File('${directory.path}/${element.name}')
                  ..writeAsBytes(element.bytes!);
                _selectedFiles.add(SendFileInfo(file: file,extension: element.extension??"",name: element.name,fileSize:_pickerService.formatBytesToKB(element.size)));
                notifyListeners();
              }else{
                onError.call("Seçtiğiniz dosya 'jpg,jpeg,png,pdf' formatlarından biri olmalı.");
              }
            }
          }
        } else {
          for (var element in pickedFiles.files) {
            var tempList = List.from(_platformFiles);
            totalSize += element.size;
              if (_pickerService.convertToMegabytes(totalSize) > 10) {
                onError.call("Seçtiğiniz dosyalar 10Mb sınırını geçmemeli");
              } else {
                if (tempList.indexWhere((pElement) => pElement.name==element.name)<0) {
                  if(element.extension!=null&&_checkFileExtension(element.extension!)){
                    _platformFiles.add(element);
                    final directory = await getApplicationDocumentsDirectory();
                    final file = File('${directory.path}/${element.name}')
                      ..writeAsBytes(element.bytes!);
                    _selectedFiles.add(SendFileInfo(file: file,extension: element.extension??"",name: element.name, fileSize: _pickerService.formatBytesToKB(element.size)));
                    notifyListeners();
                    break;
                  }else{
                    onError.call("Seçtiğiniz dosya 'jpg,jpeg,png,pdf' formatlarından biri olmalı.");
                  }
                }else{
                  onError.call("Bu dosya zaten seçili");
                }
              }

          }
        }
      }
    }
    /*
        for (var element in _platformFiles) {
      print(element.name);
    }
     */
    return (_platformFiles.isEmpty) ? false : true;
  }
}
