import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:{{project_file_name}}/core/notifications/channel_const.dart';
import 'package:{{project_file_name}}/utils/constants/values_manager.dart';
import 'package:{{project_file_name}}/utils/print_log.dart';
import 'package:path_provider/path_provider.dart';

Future<AndroidNotificationDetails> getAndroidNotificationDetail(NotificationChannelID channel, {String? image}) async {
  FilePathAndroidBitmap? largeIconBitMap;
  if ((image ?? "").isNotEmpty) {
    final largeIconPath = await downloadAndSaveImage(image!);
    largeIconBitMap = largeIconPath != null ? FilePathAndroidBitmap(largeIconPath) : null;
  }
  switch (channel) {
    case NotificationChannelID.general:
      return AndroidNotificationDetails(
          channel.channelID, // id
          channel.channelName,
          importance: Importance.max,
          priority: Priority.max,
          largeIcon: largeIconBitMap,
          groupKey: NotificationGroupID.commonCategory.categoryID,
          color: AppColor.primaryColor);
  }
}

Future<DarwinNotificationDetails> getIosNotificationDetail(NotificationChannelID channel, {String? image}) async {
  List<DarwinNotificationAttachment>? attachments;
  if ((image ?? "").isNotEmpty) {
    final largeIconPath = await downloadAndSaveImage(image!);
    attachments = largeIconPath != null
        ? <DarwinNotificationAttachment>[
            DarwinNotificationAttachment(
              largeIconPath,
              hideThumbnail: false,
              thumbnailClippingRect:
                  // lower right quadrant of the attachment
                  const DarwinNotificationAttachmentThumbnailClippingRect(
                x: 0.5,
                y: 0.5,
                height: 0.5,
                width: 0.5,
              ),
            )
          ]
        : null;
  }
  switch (channel) {
    case NotificationChannelID.general:
      return DarwinNotificationDetails(
        attachments: attachments,
        threadIdentifier: channel.channelID,
        subtitle: channel.channelName,
        categoryIdentifier: NotificationGroupID.commonCategory.categoryID,
        presentBadge: false,
        presentAlert: true, // id
      );
  }
}

Future<String?> downloadAndSaveImage(String url) async {
  try {
    List<int>? bytes;
    late final File file;

    final response = await Dio().get<List<int>>(url, options: Options(responseType: ResponseType.bytes));
    bytes = response.data;
    if (bytes != null) {
      Uri val = Uri.parse(url);
      String fileName = val.pathSegments.last;
      List<String> parts = fileName.split('.');
      if (parts.length > 1) {
        String fileExtension = parts.last.toLowerCase();
        List<String> validExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp', 'avif'];
        if (validExtensions.contains(fileExtension)) {
          debugShow('Dosya uzantısı: $fileExtension');
          final documentDirectory = await getTemporaryDirectory();
          final filePath = '${documentDirectory.path}/$fileName';
          file = File(filePath);
          file.writeAsBytesSync(response.data!);
          return file.path;
        } else {
          debugShow('Geçersiz dosya uzantısı: $fileExtension');
          return null;
        }
      } else {
        debugShow('Dosya uzantısı bulunamadı');
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    debugShow(e);
    return null;
  }
}
/*
Future<String?> _downloadAndSavePicture(String? url, String fileName) async {
  if (url == null) return null;
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';
  final response = await Dio().get<List<int>>(url,options: Options(responseType: ResponseType.bytes));
  final File file = File(filePath);
  await file.writeAsBytes(response.data??[]);
  return filePath;
}
BigPictureStyleInformation? _buildBigPictureStyleInformation(
    String title,
    String body,
    String? picturePath,
    bool showBigPicture,
    ) {
  if (picturePath == null) return null;
  final FilePathAndroidBitmap filePath = FilePathAndroidBitmap(picturePath);
  return BigPictureStyleInformation(
    showBigPicture ? filePath : const FilePathAndroidBitmap("empty"),
    largeIcon: filePath,
    contentTitle: title,
    htmlFormatContentTitle: true,
    summaryText: body,
    htmlFormatSummaryText: true,
  );
}
 */
