import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progressValue;
  const ProgressBar({Key? key,required this.progressValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double height = 40;
    return SizedBox(width: double.maxFinite,height: height,child: Center(child: TweenAnimationBuilder(duration: const Duration(milliseconds: 1500),
        tween: Tween<double>(begin: 1.0, end: progressValue.clamp(0.0, 1.0)),
        builder: (BuildContext context, double value, Widget? child) {
          return CustomPaint(size: const Size(double.maxFinite,12),painter: ProgressPainter(strokeWidth: 2,value: value),);
        })),);
  }
}

class ProgressPainter extends CustomPainter {
  final double value;
  final double strokeWidth;

  ProgressPainter({required this.value, this.strokeWidth = 6});

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height / 2;
    final paint = Paint()..strokeCap=StrokeCap.round
      ..color = Colors.orange
      ..style = PaintingStyle.fill

      ..shader=LinearGradient(tileMode: TileMode.decal,colors: [Colors.red.withOpacity(value),Colors.red.shade800]).createShader(Rect.fromPoints(Offset(0,centerY), Offset(size.width*value, centerY)));
    final outerStroke = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      //..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3 * 0.57735 + 1.5)
      ..strokeWidth = strokeWidth;

    final path = Path()..addRRect(RRect.fromLTRBR(-strokeWidth/2, size.height+strokeWidth/2, size.width+strokeWidth/2, -strokeWidth/2, Radius.circular(size.height)));
    canvas.drawPath(path, outerStroke);
    //canvas.drawPath(path, (Paint()..color=Colors.red..maskFilter = const MaskFilter.blur(BlurStyle.outer, 3 * 0.57735 + 1.5)));
    canvas.save();
    canvas.restore();

    canvas.clipRect(Rect.fromLTRB(
      0,
      0,
      size.width * value, // yarısını kesmek
      size.height,
    ));
    final path2 = Path()..addRRect(RRect.fromLTRBR(0, size.height, size.width, 0, Radius.circular(size.height)));
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
