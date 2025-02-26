import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScrollingText extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final Axis scrollAxis;
  final double ratioOfBlankToScreen;
  final double? width;

  const ScrollingText({super.key,
    required this.text,
    this.textStyle,
    this.scrollAxis= Axis.horizontal,
    this.ratioOfBlankToScreen= 1,
    this.width,
  });

  @override
  State<StatefulWidget> createState() {
    return ScrollingTextState();
  }
}

class ScrollingTextState extends State<ScrollingText> {
  late ScrollController scrollController;
  late double screenWidth;
  late double screenHeight;
  double position = 0.0;
  Timer? timer;
  final double _moveDistance = 3.0;
  final int _timerRest = 100;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      startTimer();
    });
  }

  void startTimer() {
    if (_key.currentContext != null) {
      double widgetWidth =
          _key.currentContext!.findRenderObject()!.paintBounds.size.width;
      double widgetHeight =
          _key.currentContext!.findRenderObject()!.paintBounds.size.height;

      timer = Timer.periodic(Duration(milliseconds: _timerRest), (timer) {
        double maxScrollExtent = scrollController.position.maxScrollExtent;
        double pixels = scrollController.position.pixels;
        if (pixels + _moveDistance >= maxScrollExtent) {
          if (widget.scrollAxis == Axis.horizontal) {
            position = (maxScrollExtent -
                screenWidth * widget.ratioOfBlankToScreen +
                widgetWidth) /
                2 -
                widgetWidth +
                pixels -
                maxScrollExtent;
          } else {
            position = (maxScrollExtent -
                screenHeight * widget.ratioOfBlankToScreen +
                widgetHeight) /
                2 -
                widgetHeight +
                pixels -
                maxScrollExtent;
          }
          scrollController.jumpTo(position);
        }
        position += _moveDistance;
        scrollController.animateTo(position,
            duration: Duration(milliseconds: _timerRest), curve: Curves.linear);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = widget.width??MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;
  }

  Widget getBothEndsChild() {
    if (widget.scrollAxis == Axis.vertical) {
      String newString = widget.text.split("").join("\n");
      return Center(
        child: Text(
          newString,
          style: widget.textStyle,
          textAlign: TextAlign.center,
        ),
      );
    }
    return Center(
        child: Text(
          widget.text,
          style: widget.textStyle,
        ));
  }

  Widget getCenterChild() {
    if (widget.scrollAxis == Axis.horizontal) {
      return SizedBox(width: screenWidth * widget.ratioOfBlankToScreen);
    } else {
      return SizedBox(height: screenHeight * widget.ratioOfBlankToScreen);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer!.cancel();
    }
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: _key,
      scrollDirection: widget.scrollAxis,
      controller: scrollController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        ColoredBox(color: Colors.green,child: getBothEndsChild()),
        ColoredBox(color: Colors.purple,child: getCenterChild()),
        ColoredBox(color: Colors.teal,
        child: getBothEndsChild()),
      ],
    );
  }
}