import 'dart:io';
import 'package:{{project_file_name}}/utils/constants/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:get/route_manager.dart';
import 'package:{{project_file_name}}/widget_dialogs/widgets/shimmer/shimmer_widget.dart';

abstract class ShowImagePage extends StatefulWidget {
  final String image;
  final bool isFile;

  const ShowImagePage({Key? key,required this.image, required this.isFile}) : super(key: key);

  @override
  State<ShowImagePage> createState() => _ShowImagePageState();
}

class _ShowImagePageState extends State<ShowImagePage> {
  double _scale = 1.0;
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: true,
          foregroundColor: Colors.white,
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.black, statusBarIconBrightness: Brightness.light)),
      body: GestureDetector(
        onScaleStart: (ScaleStartDetails details) {
          _previousScale = _scale;
          setState(() {});
        },
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            _scale = _previousScale * details.scale;
          });
        },
        child: InteractiveViewer(
          transformationController: TransformationController(Matrix4.identity()
            ..scale(_scale)
            ..translate(0.0, 0.0, 0.0)),
          minScale: 0.5,
          maxScale: 4.0,
          child: Center(
              child: widget.isFile
                  ? Image.file(File(widget.image),)
                  : Image.network(
                widget.image,
                fit: BoxFit.contain,
                loadingBuilder: (context, widget, event) {
                  if (event == null) return widget;
                  return ShimmerWidget(height: context.height, width: context.width);
                },
                errorBuilder: (context, object, stacktrace) {
                  return Image.asset(LogosAssets.appLogo, fit: BoxFit.cover);
                },
              )
          ),
        ),
      ),
    );
  }
}
class ShowFileImagePage extends ShowImagePage{
  const ShowFileImagePage({super.key, required super.image}):super(isFile: true);
}
class ShowNetworkImagePage extends ShowImagePage{
  const ShowNetworkImagePage({super.key, required super.image}):super(isFile: false);
}

class SelectedImageShow extends StatelessWidget {
  final String? image;

  const SelectedImageShow({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: true,
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.black, statusBarIconBrightness: Brightness.light)),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Image.file(File(image!)),
          ),
          Positioned(
              bottom: 20,
              right: 50,
              left: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(flex: 2,
                    child: MaterialButton(onPressed: () {
                      Get.back<bool>(result: false);
                    },color: Colors.red.shade800,child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                      child: Icon(Icons.clear,color: Colors.white,),
                    ),),
                  ),
                  const Spacer(),
                  Expanded(flex: 2,
                    child: MaterialButton(onPressed: () {
                      Get.back<bool>(result: true);
                    },color: Colors.green.shade800,child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                      child: Icon(Icons.check_outlined,color: Colors.white,),
                    ),),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
