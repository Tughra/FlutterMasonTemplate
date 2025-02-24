import 'package:sirketim_cebimde/core/extensions/context_extension.dart';
import 'package:sirketim_cebimde/core/extensions/int_extension.dart';
import 'package:sirketim_cebimde/widgets_dialogs/widgets/customs/custom_appbars/appbar.dart';
import 'package:sirketim_cebimde/widgets_dialogs/widgets/loadings/policy_list_loading.dart';
import 'package:sirketim_cebimde/widgets_dialogs/widgets/loadings/user_appbar_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class HomeLoading extends StatelessWidget {
  const HomeLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPrimary(
        toolbarHeight: 0,
        appBarSize: Size.zero,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          32.heightIntMargin,
         const PrAppBarLoading(),
          32.heightIntMargin,
          const PolicyCardLoading(),
          12.heightIntMargin,
          const PolicyCardLoading(),
          12.heightIntMargin,
          const PolicyCardLoading(),
          12.heightIntMargin,
          const PolicyCardLoading(),
        ],
      ),
    );
  }
}
