
import 'package:flutter/widgets.dart';
import 'package:{{project_file_name}}/models/common/auto_complete_models.dart';
import 'package:{{project_file_name}}/models/management.dart';

abstract class MainAutoCompleteProvider extends ChangeNotifier{
  List<BaseAutoCompleteModel> searchedItemList=[];
  resetSearched(){
    searchedItemList = autocompleteReturner.data;
    notifyListeners();
  }
  searchInList(String word){
    if (word.isEmpty) {
      searchedItemList = autocompleteReturner.data;
    } else {
      searchedItemList = (autocompleteReturner.data)
          .where((element) =>
          (element.name??"").toLowerCase().contains(word.toLowerCase()))
          .toList();
      
    }
    notifyListeners();
  }
  Returner<List<BaseAutoCompleteModel>> autocompleteReturner = Returner<List<BaseAutoCompleteModel>>(data: [], viewStatus: ViewStatus.stateInitial);
}
/*

 */