import 'dart:convert';
import 'package:{{project_file_name}}/core/managers/dio_manager/network_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CommonService {

  Future<Uint8List?> getPdfDocument({required String url}) async {
    try {
      final response = await NetworkManager.instance.dio.get(url, options: Options(responseType: ResponseType.bytes)); //http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }
}
