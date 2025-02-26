import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:{{project_file_name}}/utils/constants/assets_manager.dart';
import 'package:{{project_file_name}}/utils/print_log.dart';

Future<ByteData> loadFontAsByteData() async {
  // Fontun asset klasöründen yüklenmesi
  ByteData fontData = await rootBundle.load('fonts/Nunito/Nunito-Medium.ttf');
  return fontData;
}
Future<Uint8List> loadAssetImageAsByteData() async {
  // Fontun asset klasöründen yüklenmesi
  ByteData imageData = await rootBundle.load(LogosAssets.acnLogo);
  Uint8List audioUint8List = imageData.buffer.asUint8List(imageData.offsetInBytes, imageData.lengthInBytes);
  //List<int> audioListInt = audioUint8List.cast<int>();
  return audioUint8List;
}
/*
Future<Uint8List> loadFontAsUint8List() async {
  ByteData fontData = await rootBundle.load('assets/fonts/MyCustomFont.ttf');
  return fontData.buffer.asUint8List();
}
 */
Future<void> saveAsPdf({
  required List<String> columns,
  required List<List<List<String>>> rows,
  required double titleSize,
  required double contentSize,
  required List<int> flexIndexes,
  required List<int> fittedIndexes,
  required BuildContext context,
  required String fileName,
  required String tableTitle,
  Map<String, String>? extras,
}) async {
  try {
    final pdf = pw.Document();
    List<pw.Widget> extraContent = [];
    ByteData fontData = await loadFontAsByteData();
    Uint8List imageData = await loadAssetImageAsByteData();
    final pw.Image logo =pw.Image(pw.MemoryImage(imageData), height: 25,fit: pw.BoxFit.scaleDown);
    if (extras != null) {
      extraContent = extras.entries
          .map((val) => pw.Align(alignment: pw.Alignment.centerLeft,child: pw.Padding(
          padding: const pw.EdgeInsets.only(left: 10,top: 10),
          child: pw.RichText(
              text: pw.TextSpan(
                  style: pw.TextStyle(fontSize: 11, color: PdfColors.grey600, fontWeight: pw.FontWeight.bold,font: pw.Font.ttf(fontData)),
                  text: val.key,
                  children: [
                    pw.TextSpan(
                        text: val.value,
                        style: pw.TextStyle(fontSize: 11, color: PdfColors.black, fontWeight: pw.FontWeight.normal,font: pw.Font.ttf(fontData)))
                  ])))))
          .toList();
    }
    for (int allRowsIndex = 0; allRowsIndex < rows.length; allRowsIndex++) {
      pdf.addPage(
        pw.Page(
          theme: pw.ThemeData(defaultTextStyle: pw.TextStyle(font: pw.Font.ttf(fontData))),
          orientation: pw.PageOrientation.portrait,
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.zero,
          build: (context) {
            return pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.center, children: [
              if (extraContent.isNotEmpty) ...[
                ...extraContent,
              ],
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 10.0),
                child: pw.Text(
                  tableTitle,
                  style: pw.TextStyle(fontSize: 16, color: PdfColors.black, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: () {
                  List<pw.Widget> list = [];
                  for (int i = 0; i < columns.length; i++) {
                    if (i % 2 == 1 || i == 0) {
                      list.add(pw.SizedBox(
                        width: 4,
                      ));
                    }
                    list.add(pw.Expanded(
                        flex: flexIndexes[i],
                        child: pw.Text(
                          columns[i],
                          textAlign: i == 0 ? pw.TextAlign.start : pw.TextAlign.center,
                          style: pw.TextStyle(fontSize: titleSize),
                        )));
                    if (i == columns.length - 1) {
                      list.add(pw.SizedBox(
                        width: 4,
                      ));
                    }
                  }
                  return list;
                }(),
              ),
              ...List.generate(
                rows[allRowsIndex].length,
                    (index) {
                  return pw.DecoratedBox(
                      decoration: pw.BoxDecoration(color: index.isEven ? PdfColors.grey200 : null),
                      child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: () {
                          List<pw.Widget> list = [];
                          for (int i = 0; i < rows[allRowsIndex][index].length; i++) {
                            pw.Widget item = pw.Padding(
                              padding: pw.EdgeInsets.only(left: (i % 2 == 1 || i == 0) ? 4 : 0),
                              child: pw.Text(
                                  textAlign: (i == 0) ? pw.TextAlign.start : pw.TextAlign.center,
                                  rows[allRowsIndex][index][i],
                                  style: pw.TextStyle(fontSize: contentSize)),
                            );
                            list.add(
                              pw.Expanded(
                                flex: flexIndexes[i],
                                child: fittedIndexes.contains(i)
                                    ? pw.SizedBox(
                                  height: 32,
                                  child: pw.FittedBox(
                                    fit: pw.BoxFit.scaleDown,
                                    child: item,
                                  ),
                                )
                                    : item,
                              ),
                            );
                          }
                          return list;
                        }(),
                      ));
                },
              ),
              pw.Align(alignment: pw.Alignment.bottomRight,child: pw.SizedBox(height: 25,child: logo))
            ]);
          },
        ),
      );
    }
    Directory dir = await getTemporaryDirectory();
    final Uint8List data = await pdf.save();
    final String fulPath = "${dir.path}/pdfCache";
    if (Directory(fulPath).existsSync() == false) await Directory(fulPath).create();

    final path = "$fulPath/$fileName.pdf";
    final file = File(path);
    await file.writeAsBytes(data);
    debugShow(file.path);
    final box = context.findRenderObject() as RenderBox?;
    Share.shareXFiles(
      [XFile(path)],
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  } catch (e) {
    print(e);
  }
}

Future<void> saveWidgetAsPdf(List<GlobalKey> pageKeys,
    {required BuildContext context, required String fileName,VoidCallback? onDone,VoidCallback? onError}) async {
  try {
    final pdf = pw.Document();
    for (int i = 0; i < pageKeys.length; i++) {
      RenderRepaintBoundary boundary = pageKeys[i].currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      pdf.addPage(
        pw.Page(
          build: (context) {
            return pw.Center(
              child: pw.Image(pw.MemoryImage(pngBytes), width: 595, height: 842),
            );
          },
        ),
      );
    }
//hafızada değil diski aç oraya yaz

    /*
  img.Image? imageTemp = img.decodeImage(pngBytes);
  PdfImage(
                pdf.document,
                image: imageTemp!.getBytes(),
                width: imageTemp.width,
                height: imageTemp.height,
              )
   */

    Directory dir = await getTemporaryDirectory();
    final Uint8List data = await pdf.save();
    final String fulPath = "${dir.path}/pdfCache";
    if (Directory(fulPath).existsSync() == false) await Directory(fulPath).create();

    final path = "$fulPath/$fileName.pdf";
    final file = File(path);
    await file.writeAsBytes(data);
    debugShow(file.path);
    final box = context.findRenderObject() as RenderBox?;
    if(onDone!=null){
      onDone.call();
    }
    else{
      Share.shareXFiles(
        [XFile(path)],
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
    //await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
    // final output = await getExternalStorageDirectory();
    // final file = File('${output!.path}/example.pdf');
    // await file.writeAsBytes(await pdf.save());
  } catch (_) {
    onError?.call();
  }
}

/*
Sayfaları Birer Birer İşleyip Belleği Serbest Bırakın
ui.Image image = await boundary.toImage(pixelRatio: 2);
ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
Uint8List pngBytes = byteData!.buffer.asUint8List();

// Ekleme işleminden sonra resmi serbest bırakın
image.dispose();

pdf.addPage(
  pw.Page(
    build: (context) {
      return pw.Center(
        child: pw.Image(pw.MemoryImage(pngBytes), width: 595, height: 842),
      );
    },
  ),
);

pngBytes = null; // Belleği serbest bırak
byteData = null; // ByteData'yı serbest bırak
 */
/*
 Disk Üzerine Yazma (Streaming)
Directory tempDir = await getTemporaryDirectory();
for (int i = 0; i < pageKeys.length; i++) {
  RenderRepaintBoundary boundary = pageKeys[i].currentContext!.findRenderObject() as RenderRepaintBoundary;
  ui.Image image = await boundary.toImage(pixelRatio: 2);
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List pngBytes = byteData!.buffer.asUint8List();

  // Görseli geçici bir PNG dosyasına kaydedin
  File tempFile = File('${tempDir.path}/temp_image_$i.png');
  await tempFile.writeAsBytes(pngBytes);

  // PNG dosyasını PDF sayfasına ekleyin
  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Center(
          child: pw.Image(pw.MemoryImage(await tempFile.readAsBytes()), width: 595, height: 842),
        );
      },
    ),
  );

  // Resim verilerini serbest bırakın
  image.dispose();
  byteData = null;
  pngBytes = null;
}
 */

/*
 Chunking (Bölme Yöntemi)
Eğer yukarıdaki yöntemler bellek yönetiminde yeterli olmazsa, çok büyük veri setleri için Chunking (bölme) yöntemi kullanılabilir. PDF'e eklenecek resimlerin sayısı çok fazla ise, bu resimleri birer birer işlemek yerine, belirli sayıda resim işleyip kaydettikten sonra belleği serbest bırakmak ve sonraki bölüme geçmek mantıklı olabilir.

Örneğin, her seferinde 5 sayfayı işleyip PDF'e ekledikten sonra belleği temizleyip tekrar diğer sayfalara geçebilirsiniz.
int chunkSize = 5;
for (int i = 0; i < pageKeys.length; i += chunkSize) {
  List<GlobalKey> chunk = pageKeys.sublist(i, (i + chunkSize).clamp(0, pageKeys.length));

  // Bu chunk içindeki sayfaları işle
  for (var key in chunk) {
    // Aynı işlemleri yap (render et ve PDF'e ekle)
  }

  // Chunk işlemi bittiğinde bellek temizliği yap
  System.gc();
}
 */
