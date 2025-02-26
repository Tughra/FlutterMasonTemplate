import 'package:{{project_file_name}}/core/extensions/int_extension.dart';
import 'package:{{project_file_name}}/widget_dialogs/widgets/customs/custom_appbars/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class UnloadedPage extends StatelessWidget {
  final VoidCallback onPressed;
  final String? content;

  const UnloadedPage({super.key, required this.onPressed, this.content});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            content ?? "Veri alınamadı. Lütfen tekrar deneyin",textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17, color: Colors.black),
          ),
          8.heightIntMargin,
          ElevatedButton(onPressed: onPressed, child: const Text("Yenile",style: TextStyle(fontSize: 17,),)),
          /*
                SizedBox(
            width: 60,
            height: 60,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                  //border radius equal to or more than 50% of width
                )),
                onPressed: onPressed,
                child: const Center(
                  child: Icon(
                    Icons.refresh,
                    size: 24,
                  ),
                )),
          )

       */
        ],
      ),
    );
  }
}

class UnloadedFullPage extends StatelessWidget {
  final VoidCallback onPressed;
  final String? content;

  const UnloadedFullPage({super.key, required this.onPressed, this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPrimary(
        toolbarHeight: 0,
        appBarSize: Size.zero,
      ),
      body: SizedBox(
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              content ?? "Veri alınamadı lütfen tekrar deneyin",
              style: const TextStyle(fontSize: 17, color: Colors.black),
            ),
            20.heightIntMargin,
            SizedBox(
              width: 60,
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),

                        //border radius equal to or more than 50% of width
                      )),
                  onPressed: onPressed,
                  child: const FittedBox(
                      child: Icon(
                        Icons.refresh,
                        size: 30,
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
