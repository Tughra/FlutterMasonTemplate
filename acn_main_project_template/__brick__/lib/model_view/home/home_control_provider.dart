import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:{{project_file_name}}/core/observers/life_cycle_observer.dart';
import 'package:{{project_file_name}}/core/services/anlytics.dart';

enum HomeChildrenPages{
  home(0,"Sayfa 1"),
  agencyReport(1,"Sayfa 2"),
  customerInfo(2,"Sayfa 3"),
  menu(3,"Sayfa 4");
  const HomeChildrenPages(this.pageIndex,this.pageName);
  final int pageIndex;
  final String pageName;
}

class HomeParentController extends ChangeNotifier{

  HomeParentController({this.initialPageIndex = 0}){
    _currentIndex = initialPageIndex;
  }
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final int initialPageIndex;
  int _currentIndex = 0;
  HomeChildrenPages get currentChildrenPage => HomeChildrenPages.values.firstWhere((e)=>e.pageIndex==currentIndex);
  int get currentIndex => _currentIndex;
  bool shouldDispose=false;

  @override
  void dispose() {
    if(shouldDispose)super.dispose();
  }

  void changePage(int index){
    _currentIndex = index;
    _currentPage(index);
    notifyListeners();
  }

  void _currentPage(int index) {
    switch (index) {
      case 0:
        {
          TrackTheRoute.bottomNavigatorRoute = "HomePage";
        }
        break;
      case 1:
        {
          TrackTheRoute.bottomNavigatorRoute = "AgencyReport";
        }
        break;

      case 2:
        {
          TrackTheRoute.bottomNavigatorRoute = "CustomerInfo";
        }
        break;
      case 3:
        {
          TrackTheRoute.bottomNavigatorRoute = "Menu";
        }
        break;
    }
    GetIt.instance<AnalyticsService>().setCurrentPage("HomeParentPage", TrackTheRoute.bottomNavigatorRoute);
    debugPrint(TrackTheRoute.bottomNavigatorRoute);
  }

}