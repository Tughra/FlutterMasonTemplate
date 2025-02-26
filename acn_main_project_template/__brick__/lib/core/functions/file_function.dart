

import 'dart:io';

import 'package:{{project_file_name}}/utils/print_log.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<String> getExternalDocumentPath() async {
  // To check whether permission is given for this app or not.
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    // If not we will ask for permission first
    await Permission.storage.request();
  }
  Directory directory = Directory("");
  if (Platform.isAndroid) {
    // Redirects it to download folder in android
    directory = Directory("/storage/emulated/0/Download");
  } else {
    directory = await getApplicationDocumentsDirectory();
  }

  final exPath = directory.path;
  //print("Saved Path: $exPath");
  await Directory(exPath).create(recursive: true);
  return exPath;
}
Future<File> writeFile({required List<int> bytes,required String fileName}) async {
  final path = await  getExternalDocumentPath();
  // Create a file for the path of
  // device and file name with extension
  File file= File('$path/$fileName');

  // Write the data in the file you have created
  return file.writeAsBytes(bytes);
}

Future<void> saveFileToICloudDrive() async {
  try {
    // Dosyayı seçin
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      // iCloud Drive klasörünün yolu
      String icloudDrivePath = (await getApplicationDocumentsDirectory()).path;

      // Dosya yolu
      String filePath = '$icloudDrivePath/${file.name}';

      // Dosyayı kaydedin
      File fileToSave = File(filePath);
      await fileToSave.writeAsBytes(file.bytes!);

     // print('Dosya iCloud Drive\'a kaydedildi. Yolu: $filePath');
    } else {
      // Dosya seçilmedi veya seçim iptal edildi.
      debugShow('Dosya seçilmedi veya seçim iptal edildi.');
    }

  } catch (e) {
    debugShow('Dosya kaydedilirken hata oluştu: $e');
  }
}