import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:path_provider/path_provider.dart';

class ImagePickerService {
  static ImagePickerService get instance =>
      _instance ??= ImagePickerService._init();
  ImagePickerService._init();
  static ImagePickerService? _instance;
  //final PermissionManager _permissionManager = PermissionManager();

  Future<File?> pickOriginalImage()async{
    try{
      final photo = await ImagePicker()
          .pickImage(source: ImageSource.gallery, requestFullMetadata: false);
      if(photo==null){
        return null;
      }else{
        final imageTemporary = File(photo.path);
        return imageTemporary;
      }
    }catch(_){
      return null;
    }
  }
  Future<File?> pickOriginalCamera()async{
    try{
      final photo = await ImagePicker().pickImage(source: ImageSource.camera);
      if(photo==null){
        return null;
      }else{
        final imageTemporary = File(photo.path);
        return imageTemporary;
      }
    }catch(_){
      return null;
    }
  }
  Future<File?> pickImage({VoidCallback? onError}) async {
    try {
      final photo = await ImagePicker()
          .pickImage(source: ImageSource.gallery, requestFullMetadata: false);
      if (photo == null) {
        return null;
      } else {
        final imageTemporary = File(photo.path);
        return imageTemporary;
      }
    } on PlatformException catch (_) {
      onError?.call();
      return null;
    }catch(_){
      onError?.call();
      return null;
    }
  }

  Future<File?> pickCamera({VoidCallback? onError}) async {
    try {
      final photo = await ImagePicker().pickImage(source: ImageSource.camera);
      if (photo == null) {
        return null;
      } else {
        final imageTemporary = File(photo.path);
        return imageTemporary;
      }
    } on PlatformException catch (_) {
      onError?.call();
      return null;
    }catch(_){
      onError?.call();
      return null;
    }
  }
  /// 1 is image 2 is file
  Future<FilePickerResult?>pickFile(int fileType,{VoidCallback? onError}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          withData: true,
          withReadStream: false,
          allowedExtensions:fileType==1?null:['jpg','jpeg', 'pdf', 'png'],
          type: fileType==1?FileType.image:FileType.custom);
      if (result != null) {

        return result;
      }else {
        onError?.call();
        return null;
      }
    }
    catch (e) {
      onError?.call();
      return null;
    }
  }
  double convertToMegabytes(int bytes) {
    double megabytes = bytes / (1024 * 1024);
    return megabytes;
  }
  double formatBytesToKB(int bytes) {
    double kilobytes = bytes / 1024;
    var value = kilobytes.toStringAsFixed(2);
    return double.parse(value);
  }

}

/*
  pickFile({required int index}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        withData: true,
        withReadStream: true,
        allowedExtensions: ['jpg', 'pdf', 'png'],
        type: FileType.custom);
    try {
      if (result != null) {
        if ((pickedFile
            .map((e) =>
        e!=null&&e.path.split("/").last == result.files.last.name)
            .toList()
            .indexOf(true) >
            -1 ==
            true)) {
          showBanner("Lütfen farklı bir dosya seçiniz.");
          return;
        }
        final directory = await getApplicationDocumentsDirectory();
        print("------------------>" + directory.path);
        final file = await File('${directory.path}/${result.files.last.name}')
          ..writeAsBytes(result.files.last.bytes!);
        //log(result.toString());
        pickedFile[index] = file;
        print("------------------*");
        print(pickedFile
            .map((e) =>
        e!=null&&e.path.split("/").last != result.files.last.name)
            .toList());
        notifyListeners();
      }
    } catch (_) {
      showBanner("Dosya seçilemedi. Lütfen tekrar deneyiniz.");
    }
  }

 */