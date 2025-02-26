import 'dart:io';

class SendFileInfo{
  final File file;
  final String extension;
  final String name;
  final double fileSize;
  SendFileInfo({required this.file,required this.extension,required this.name,required this.fileSize});
}