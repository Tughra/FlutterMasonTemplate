import 'dart:io';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:open_file/open_file.dart';
import 'package:{{project_file_name}}/core/services/dialog_service.dart';
import 'package:{{project_file_name}}/utils/constants/values_manager.dart';
import 'package:{{project_file_name}}/core/extensions/context_extension.dart';
import 'package:draggable_expandable_fab/draggable_expandable_fab.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share_plus/share_plus.dart';
import 'package:{{project_file_name}}/core/services/dialog_service.dart';
import 'package:{{project_file_name}}/utils/constants/values_manager.dart';
import 'package:{{project_file_name}}/utils/print_log.dart';

class OfferViewPdf extends StatefulWidget {
  final File file;
  final String title;

  const OfferViewPdf({Key? key, required this.file, required this.title}) : super(key: key);

  @override
  State<OfferViewPdf> createState() => _OfferViewPdfState();
}

class _OfferViewPdfState extends State<OfferViewPdf> {
  // final GlobalKey<PdfViewerState> _pdfViewerKey = GlobalKey();
  List<PopupMenuEntry<int>> pagesPopUpList = [];
  late PdfController _pdfController;
  late final Debouncer _deBouncer;

  @override
  void initState() {
    super.initState();
    _deBouncer = Debouncer(delay: const Duration(milliseconds: 600));
    _pdfController = PdfController(
      document: PdfDocument.openData(widget.file.readAsBytes()),
      initialPage: 1,
    );
    // controlPdfOpen();
  }

  /*
  void controlPdfOpen() async {
    try {
      await PdfDocument.openFile(widget.file.path);
    } catch (e) {
      debugShow(e);
    }
  }
  */

  @override
  void dispose() {
    _pdfController.dispose();
    _deBouncer.cancel();
    super.dispose();
  }

  void openExternal() async {
    try {
      // Dosyayı aç
      final result = await OpenFile.open(widget.file.path);

      if (result.type != ResultType.done) {
        throw Exception('Dosya açılamadı: ${result.message}');
      }
    } catch (e) {
      DialogService.instance.showCustomSnack("Bir sorun oluştu. Lütfen tekrar deneyiniz.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonAnimator: NoScalingAnimation(),
      floatingActionButtonLocation: ExpandableFloatLocation(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              color: Colors.white,
              onPressed: () async {
                try {
                  Share.shareXFiles(
                    [XFile(widget.file.path)],
                    text: 'Share PDF',
                    sharePositionOrigin: Rect.fromLTRB(0.0, 0.0, context.width, context.height),
                  );
                } catch (e) {
                  debugShow(e);
                }
              },
              icon: const Icon(Icons.share))
        ],
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ValueListenableBuilder(
                valueListenable: _pdfController.pageListenable,
                builder: (_, state, __) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    color: AppColor.primaryColor,
                    child: Center(
                        child: Text(
                          "Sayfa $state",
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  );
                }),
            Expanded(
              child: PdfView(
                builders: PdfViewBuilders<DefaultBuilderOptions>(
                  options: const DefaultBuilderOptions(),
                  errorBuilder: (_, __) => GestureDetector(
                      child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Pdf Görüntülenemiyor'),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: AppColor.primaryColor, foregroundColor: Colors.white),
                                  onPressed: () {
                                    _deBouncer.call(openExternal);
                                  },
                                  child: const Text("Uygulama Seç"))
                            ],
                          ))),
                  documentLoaderBuilder: (_) => const Center(child: CircularProgressIndicator()),
                  pageLoaderBuilder: (_) => const Center(child: CircularProgressIndicator()),
                  pageBuilder: _pageBuilder,
                ),
                controller: _pdfController,
              ),
            ),
            ValueListenableBuilder(
                valueListenable: _pdfController.loadingState,
                builder: (_, state, __) {
                  return (state == PdfLoadingState.success && (_pdfController.pagesCount ?? 0) > 1)
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: context.height / 20,
                          height: context.height / 20,
                          decoration:
                          BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor), borderRadius: BorderRadius.circular(40)),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(40),
                            child: const Icon(
                              Icons.chevron_left,
                              color: Colors.black,
                            ),
                            onTap: () {
                              _pdfController.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.linear);
                            },
                          )),
                      Material(
                        color: Theme.of(context).colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            const RelativeRect position = RelativeRect.fromLTRB(5, 100, 1, 1);
                            if (pagesPopUpList.isEmpty) {
                              pagesPopUpList = List.generate(
                                  _pdfController.pagesCount!,
                                      (index) => PopupMenuItem<int>(
                                    value: 0,
                                    child: Text('${1 + index}. Sayfa'),
                                    onTap: () {
                                      _pdfController.jumpToPage(index + 1);
                                    },
                                  ));
                            }
                            showMenu(
                                context: context,
                                position: position,
                                items:
                                pagesPopUpList /*[
                                PopupMenuItem<int>(
                                  value: 0,
                                  child: Text("sortOrder"),
                                ),
                              ]*/

                            );
                          },
                          child: const Padding(padding: EdgeInsets.all(12.0), child: Text('Sayfa Seç')),
                        ),
                      ),
                      Container(
                          width: context.height / 20,
                          height: context.height / 20,
                          decoration:
                          BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor), borderRadius: BorderRadius.circular(40)),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(40),
                            child: const Icon(
                              Icons.chevron_right,
                              color: Colors.black,
                            ),
                            onTap: () {
                              _pdfController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.linear);
                            },
                          )),
                    ],
                  )
                      : const SizedBox.shrink();
                })
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _pageBuilder(
      BuildContext context,
      Future<PdfPageImage> pageImage,
      int index,
      PdfDocument document,
      ) {
    return PhotoViewGalleryPageOptions(
      imageProvider: PdfPageImageProvider(
        pageImage,
        index,
        document.id,
      ),
      minScale: PhotoViewComputedScale.contained * 1,
      maxScale: PhotoViewComputedScale.contained * 2,
      initialScale: PhotoViewComputedScale.contained * 1.0,
      heroAttributes: PhotoViewHeroAttributes(tag: '${document.id}-$index'),
    );
  }
}
