
import 'package:agrifamilyapp/models/pageobjmodel.dart';
import 'package:agrifamilyapp/models/pageoptmodel.dart';
import 'package:flutter/material.dart';

class PagesController extends ChangeNotifier {
  PagesController(){
    _pageObjModel = new Pageobjmodel(null, null, null,
        new Pageoptmodel(_currentPage, _pageSize, ['title'], [false]));
  }
 Pageobjmodel? _pageObjModel;
 int _currentPage = 1;
 int _pageSize = 7;
 String? _searchObj;
 String? _searchObjBy;
 String? _categoryId;

 Pageobjmodel? get pageobjmodel => _pageObjModel;
 int get pageSize => _pageSize;

void setCurrenctPage(int currentPage){
  _currentPage = currentPage;
  _pageObjModel = new Pageobjmodel(_searchObj, _searchObjBy, _categoryId,
        new Pageoptmodel(_currentPage, _pageSize, ['title'], [false]));
    notifyListeners();
}

void setPage(int currentPage,String? searchObj,String? searchObjBy,String? categoryId) {
    _currentPage = currentPage;
    _searchObj = searchObj;
    _searchObjBy = searchObjBy;
    _pageObjModel = new Pageobjmodel(searchObj, searchObjBy, categoryId,
        new Pageoptmodel(_currentPage, _pageSize, ['title'], [false]));
    notifyListeners();
  }

}
