import 'package:flutter/widgets.dart';
import 'package:{{project_file_name}}/model_view/mixins/list_func_mixin.dart';
import 'package:{{project_file_name}}/utils/print_log.dart';
import 'package:provider/provider.dart';

class PaginationListener {
  bool _isRequestSent = false;
  bool _isNewRequestSent = false;

  bool get isRequestSent => _isRequestSent;
  bool get isNewRequestSent => _isNewRequestSent;

  void paginationViaTotalPage<T extends PaginationMixin>(
      BuildContext context, ScrollController controller,
      {Future Function(T provider)? onNext,
      required int currentPage,
      required int totalPages,
      required Function(int summation) setPage}) async {
    debugPrint("$currentPage---$totalPages");
    final provider = context.read<T>();
    if ((controller.offset >= controller.position.maxScrollExtent)) {
      debugPrint("Reach the bottom or tob");
      debugPrint("$currentPage---$totalPages");
      if ((currentPage <= totalPages) && (_isRequestSent == false)) {
        _isRequestSent = true;
        debugPrint("currentPage < totalPages");
        provider.paginationCurrentPage += 1;
        setPage(currentPage + 1);
        debugPrint((currentPage + 1).toString());
        if (onNext != null) {
          await onNext(provider).whenComplete(() {
            debugPrint("on next done when complete");
            Future.delayed(const Duration(seconds: 1), () => _isRequestSent = false);
          });
        }
      }
      debugPrint("isRequestFromPagination---->$_isRequestSent");
    } else if (controller.offset >= controller.position.maxScrollExtent) {
      debugPrint("reach the tobbb");
    }
  }

  Future paginationWithoutTotalPage<T extends PaginationMixin>(
      BuildContext context, ScrollController controller,
      {Future Function(T provider)? onNext,
      required int currentPage,
      Function(int summation)? setPage}) async {
    final provider = context.read<T>();
    bool pagination = provider.allowPagination;
    if (controller.position.pixels < 0.0) {
      provider.allowPagination = true;
    }
    if ((controller.position.maxScrollExtent > 0 &&
        controller.offset > controller.position.maxScrollExtent)) {
      //print("controller.offset ==> ${controller.offset}");
      //print("controller.position.maxScrollExtent ==>${controller.position.maxScrollExtent}");
      if (pagination == true && _isNewRequestSent == false) {
        _isNewRequestSent = true;
        debugPrint("currentPage < totalPages");
        debugPrint(pagination.toString());
        provider.paginationCurrentPage += 1;
        if (setPage != null) setPage(currentPage + 1);
        debugPrint((currentPage + 1).toString());
        if (onNext != null) {
          await onNext(provider).whenComplete(() {
            _isNewRequestSent = false;
          });
        }
      }
    }
  }
  void paginationListenerV1<T>(BuildContext context,ScrollController controller,
      {required Future Function(T provider) onNext,
        required bool pagination,
        Function(bool requestSended)? requestCallback}) async{
    if (!controller.hasClients) return;
    final provider = context.read<T>();
    if ((controller.offset >= controller.position.maxScrollExtent)) {
      if (pagination == true && _isNewRequestSent == false) {
        debugPrint("Can New Request Sent Status ---->$_isNewRequestSent");
        _isNewRequestSent = true;
        requestCallback?.call(_isNewRequestSent);
        debugPrint(pagination.toString());
        await Future.delayed(const Duration(milliseconds: 600),()=>onNext(provider));
        _isNewRequestSent = false;
        requestCallback?.call(_isNewRequestSent);
      }
    } else if (controller.offset >= controller.position.maxScrollExtent) {
      debugShow("reach the tobbb");
    }
  }
}
/*
void paginationListenerV1<T>(
  BuildContext context,
  ScrollController controller,
  {
    required Future Function(T provider) onNext,
    required bool pagination,
    Function(bool requestSended)? requestCallback
  }
) async {
  if (!controller.hasClients) return;

  final provider = context.read<T>();
  final threshold = 0.8 * controller.position.maxScrollExtent;

  if (controller.position.pixels >= threshold) {
    if (pagination && !_isNewRequestSent) {
      try {
        _isNewRequestSent = true;
        requestCallback?.call(_isNewRequestSent);

        await Future.delayed(
          const Duration(milliseconds: 600),
          () => onNext(provider)
        );
      } finally {
        _isNewRequestSent = false;
        requestCallback?.call(_isNewRequestSent);
      }
    }
  }
}
 */
