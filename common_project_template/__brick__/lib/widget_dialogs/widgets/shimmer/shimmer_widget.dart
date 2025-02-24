import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class ShimmerWidget extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? width;
  final double? radius;
  final double? marginTop;
  final double? marginBottom;
  final double? marginLeft;
  final double? marginRight;
  final double? padding;
  final Duration period;
  const ShimmerWidget({Key? key,this.period=const Duration(milliseconds: 1500),  this.height,  this.width,  this.radius, this.padding, this.marginTop, this.marginBottom, this.marginLeft, this.marginRight, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop??0,bottom: marginBottom??0,left: marginLeft??0,right: marginRight??0),
      padding: EdgeInsets.all(padding??0),
      width: width,
      height: height,
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          direction: ShimmerDirection.ltr,
          highlightColor:Colors.white  ,
          enabled: true,period: period,
          child: child ?? Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius??0),
            ),
          )
      ),
    );
  }

}

