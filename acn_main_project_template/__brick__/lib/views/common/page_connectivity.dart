import 'package:flutter/material.dart';
import 'package:{{project_file_name}}/core/extensions/int_extension.dart';
import 'package:{{project_file_name}}/utils/constants/assets_manager.dart' show GeneralAssets;

class PageFailConnection extends StatelessWidget {
  final VoidCallback onRefresh;
  final String? errorMsg;

  const PageFailConnection({Key? key, required this.onRefresh, this.errorMsg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              GeneralAssets.noConnection,
              width: 150,
              height: 150,
            ),
            8.heightIntMargin,
            const Text(
              "İnternet bağlantısı yok",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            8.heightIntMargin,
            const Center(
                child: Text(
                  "Bağlantınızı kontrol edin, ardından sayfayı yenileyin.",
                  textAlign: TextAlign.center,
                )),
            24.heightIntMargin,
            InkWell(
                overlayColor: MaterialStateProperty.all(Colors.blue),
                borderRadius: BorderRadius.circular(15),
                onTap: onRefresh,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 1.2),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Text(
                    "Yenile",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Text buildDynamicErrorMsg() {
    return Text(
      '${errorMsg?.toUpperCase()}',
      style: const TextStyle(fontSize: 10, color: Colors.black26),
      textScaleFactor: 1,
      maxLines: 5,
      textAlign: TextAlign.center,
    );
  }

  Text get buildErrorTitle => const Text('Hata!',
      textScaleFactor: 1,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 22, color: Colors.black54));

  Text buildErrorMsg() {
    return const Text(
      'Bir hata oluştu, buraya dokunarak sayfayı tekrar yüklemeyi deneyin.',
      textScaleFactor: 1,
      maxLines: 6,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black45),
    );
  }
}
