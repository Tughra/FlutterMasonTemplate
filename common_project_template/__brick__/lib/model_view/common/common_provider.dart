import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:{{project_file_name}}/model_view/mixins/list_func_mixin.dart';
import 'package:{{project_file_name}}/models/management.dart';
import 'package:{{project_file_name}}/repository/services/common/common_service.dart';
import 'package:{{project_file_name}}/utils/enums.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:{{project_file_name}}/utils/print_log.dart';
import 'package:tuple/tuple.dart';

class CommonProvider extends ChangeNotifier with SaveFileMixin {
  final _commonService = CommonService();

  Future<File?> getPdf(String url) async {
    File? file;
    Uint8List? bytes = await _commonService.getPdfDocument(url: url);
    if (bytes != null) {
      file = await downloadAndSavePdf(fileName: url.split("/").last, bytes: bytes);
    }
    return file;
  }
}

class QueueProvider extends ChangeNotifier {
  Returner<Tuple2<String,String>> _incompleteProcessReturner = Returner(data: const Tuple2("", ""), viewStatus: ViewStatus.stateInitial);
  CancelToken pdfCancelToken = CancelToken();
  Returner<Tuple2<String,String>> get incompleteProcessReturner => _incompleteProcessReturner;
  IncompleteProcess<File?>? incompleteProcess;
  Future<T?> assignReturner<T>(Tuple2<Future<Returner<T>>, QueueItem> process) async {
    _incompleteProcessReturner = Returner(data: Tuple2("", process.item2.getProcessState(PdfQueueProcessString.pdfPreparing)), viewStatus: ViewStatus.stateLoading);
    notifyListeners();
    final data = await process.item1;
    if (data.data != null) {
      _incompleteProcessReturner = Returner(data: Tuple2(process.item2.processItem, process.item2.getProcessState(PdfQueueProcessString.pdfReady)), viewStatus: ViewStatus.stateLoaded);
    } else {
      _incompleteProcessReturner = Returner(data: Tuple2("", process.item2.getProcessState(PdfQueueProcessString.pdfNull)), viewStatus: data.viewStatus);
    }
    notifyListeners();
    return data.data;
  }
  Future<T?> assignCallbackReturner<T>(Tuple2<IncompleteProcessCallback<Returner<T?>>, QueueItem> process) async {
    _incompleteProcessReturner = Returner(data: Tuple2("", process.item2.getProcessState(PdfQueueProcessString.pdfPreparing)), viewStatus: ViewStatus.stateLoading);
    notifyListeners();
    final data = await process.item1();
    if (data?.data != null) {
      _incompleteProcessReturner = Returner(data: Tuple2(process.item2.processItem, process.item2.getProcessState(PdfQueueProcessString.pdfReady)), viewStatus: ViewStatus.stateLoaded);
    } else {
      _incompleteProcessReturner = Returner(data: Tuple2("", process.item2.getProcessState(PdfQueueProcessString.pdfNull)), viewStatus: ViewStatus.stateError);
    }
    debugShow("assignCallbackReturner from QueueProvider class");
    notifyListeners();
    return data?.data;
  }

  void assignIncomplete<T>(IncompleteProcess<T> process) {
    incompleteProcess = process as IncompleteProcess<File?>?;
  }



  void removeAllProcesses({bool cancel = false}) {
    if(cancel)pdfCancelToken.cancel();
    if(pdfCancelToken.isCancelled)pdfCancelToken = CancelToken();
    incompleteProcess = null;
    _incompleteProcessReturner = Returner(data: const Tuple2("", ""), viewStatus: ViewStatus.stateInitial);
    notifyListeners();
  }

  //for singOut
  void disposeProcesses() {
    if(pdfCancelToken.isCancelled)pdfCancelToken = CancelToken();
    incompleteProcess = null;
    _incompleteProcessReturner = Returner(data: const Tuple2("", ""), viewStatus: ViewStatus.stateInitial);
  }

}
typedef IncompleteProcessCallback<T> = Future<T?> Function();


class IncompleteProcess<T> {
  final Future<T?> processCallback;
  final IncompleteProcessCallback<T>? processRefreshCallback;
 // final Function refreshProcessCallback;
  final QueueProcessType queueProcessType;
  T? data;

  IncompleteProcess({required this.queueProcessType, required this.processCallback,required this.processRefreshCallback}) {
    processCallback.then((value) {
      data = value;
    });
  }
  void refreshProcess()async{
    debugShow("refreshProcess from IncompleteProcess class");
    if(processRefreshCallback!=null){
      data = await processRefreshCallback!();
    }
  }

}
class QueueItem extends QueueProcessContent{
  final QueueProcessType queueProcessType;
  final String itemName;
  QueueItem({required this.queueProcessType,required this.itemName}):super(itemName,queueProcessType);
}
abstract class QueueProcessContent{
  final String processItem;
  final QueueProcessType queueProcess;
  QueueProcessContent(this.processItem,this.queueProcess);

  String getProcessState(PdfQueueProcessString processString){
    switch(queueProcess){
      case QueueProcessType.pdf:
        return "$processItem ${processString.content}";
    }
  }

}
