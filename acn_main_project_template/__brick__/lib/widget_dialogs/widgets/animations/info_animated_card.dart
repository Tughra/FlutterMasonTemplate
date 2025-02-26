import 'package:flutter/material.dart';
import 'package:{{project_file_name}}/utils/print_log.dart';


class InfoAnimatedCardSwitch extends StatefulWidget {
  final bool close;
  final String content;
  final Widget? avatarWidget;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  const InfoAnimatedCardSwitch({super.key,required this.content,this.close=false,this.backgroundColor,this.avatarWidget,this.padding});

  @override
  State<InfoAnimatedCardSwitch> createState() => _InfoAnimatedCardSwitchState();
}

class _InfoAnimatedCardSwitchState extends State<InfoAnimatedCardSwitch> {
  bool disposeCard = false;
  late bool close ;
  String content = "";
  @override
  void initState() {
    content = widget.content;
    close = widget.close;
    disposeCard = close;
    super.initState();
  }
  @override
  void didUpdateWidget(covariant InfoAnimatedCardSwitch oldWidget) {
    close = widget.close;
    content = widget.content;
    if(widget.close){
      Future.delayed(const Duration(seconds: 1),(){
        setState(() {
          disposeCard = widget.close;
        });
      });
    }else{
      disposeCard = widget.close;
    }

    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return Offstage(offstage: disposeCard,
      child: Padding(
        padding: widget.padding??EdgeInsets.zero,
        child: InfoAnimatedCard(avatarWidget: widget.avatarWidget,backgroundColor: widget.backgroundColor,close: close,content: content, onCloseComplete: () {
          setState(() {
            disposeCard=true;
          });
        },),
      ),
    );
  }
}


class InfoAnimatedCard extends StatefulWidget {
  final bool close;
  final String content;
  final Color? backgroundColor;
  final Duration? animationDuration;
    final VoidCallback onCloseComplete;
  final Widget? avatarWidget;
  const InfoAnimatedCard({super.key, required this.content,this.close=false,required this.onCloseComplete,this.backgroundColor,this.avatarWidget,this.animationDuration});

  @override
  State<InfoAnimatedCard> createState() => _InfoAnimatedCardState();
}

class _InfoAnimatedCardState extends State<InfoAnimatedCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController =
      AnimationController(vsync: this, duration: widget.animationDuration??const Duration(seconds: 1));
  late final animationOpen = CurvedAnimation(
      parent: animationController,
      curve: const Interval(0, .4, curve: Curves.fastOutSlowIn));
  late final animationExpand = CurvedAnimation(
      parent: animationController,
      curve: const Interval(.4, 1, curve: Curves.fastOutSlowIn));
  String content = "";
  @override
  void initState() {
    content = widget.content;
    animationController.forward();
    animationController.addStatusListener((status){
      if(status==AnimationStatus.dismissed)widget.onCloseComplete();
    });
    debugShow("_InfoAnimatedCardState init");
    super.initState();
  }
@override
  void didUpdateWidget(covariant InfoAnimatedCard oldWidget) {
  content = widget.content;
    if(widget.close){
      backAnimate();
    }else{
      startAnimate();
    }
    super.didUpdateWidget(oldWidget);
  }
  @override
  void dispose() {
    animationController.dispose();
    debugShow("_InfoAnimatedCardState dispose");
    super.dispose();
  }

  void startAnimate() {
    animationController.forward();
  }

  void backAnimate() {
    animationController.reverse();
  }

  @override
  void deactivate() {
    backAnimate();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            color: widget.backgroundColor??Theme.of(context).secondaryHeaderColor,
            borderRadius: const BorderRadius.all(Radius.circular(200))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(builder: (_, constraint) {
            return AnimatedBuilder(
              animation: animationController,
              builder: (_, child) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: animationOpen.value*50,height: animationOpen.value*50,
                    child: CircleAvatar(
                        maxRadius:50,
                        backgroundColor: Colors.white,
                        foregroundColor: Theme.of(context).secondaryHeaderColor,
                        child: widget.avatarWidget?? Icon(
                          Icons.update_outlined,
                          size: animationOpen.value * 24,
                        )),
                  ),
                      (){
                    if(animationController.value==1) {
                      return Expanded(
                        child: Text(
                          content,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16, color: Colors.white),
                        ),
                      );
                    } else {
                      return  SizedBox(
                        width: (constraint.maxWidth - 50) * animationExpand.value,
                      );
                    }
                  }()

                ],
              ),
            );
          }),
        ));
  }
}
