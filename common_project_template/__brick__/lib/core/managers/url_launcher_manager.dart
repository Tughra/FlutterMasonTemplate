import 'package:flutter/foundation.dart';
import 'package:get/route_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static Future<void> launchLink({required String link, VoidCallback? onError,LaunchMode? launchMode}) async {
    try {
      final url = link;
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url),mode: launchMode??LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e, s) {
      if (onError != null) onError();
      Get.rawSnackbar(title: 'Hata!', message: 'Link yönlendirmesi başarısız');
      if (kDebugMode) {
        print('error => ${e.toString() + s.toString()}');
      }
    }
  }

  static Future<void> call({required String telNo, VoidCallback? onError}) async {
    try {
      final url = 'tel:$telNo';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } catch (e, s) {
      if (onError != null) onError();
      Get.rawSnackbar(title: "Hata!", message: '$telNo ' "numarası aranamadı.");
      if (kDebugMode) {
        print('error => ${e.toString() + s.toString()}');
      }
    }
  }

  static Future<void> sendMail({required String eMail, VoidCallback? onError}) async {
    try {
      final emailaddress = 'mailto:$eMail?subject=&body=';
      if (await canLaunchUrl(Uri.parse(emailaddress))) {
        await launchUrl(Uri.parse(emailaddress));
      } else {
        throw 'Could not found Email';
      }
    } catch (e, s) {
      if (onError != null) onError();
      Get.rawSnackbar(title: "Hata!", message: "Mail uygulaması başlatılamadı.");
      if (kDebugMode) {
        print('error => ${e.toString() + s.toString()}');
      }
    }
  }
}
