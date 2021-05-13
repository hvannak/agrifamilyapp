import 'dart:convert';

import 'package:agrifamilyapp/Helpers/apiHelpers.dart';
import 'package:agrifamilyapp/models/categorymodel.dart';
import 'package:agrifamilyapp/modules/mygeneralfunc.dart';
import 'package:flutter/material.dart';

Future<List<Categorymodel>> fetchAllCategory(BuildContext context) async{
    try{
      final response = await ApiHelpers.fetchData('/category/all');
      if (response.statusCode == 200) {
         var list = jsonDecode(response.body) as List;
         var listCategory  = list.map((i) => Categorymodel.fromJson(i)).toList();
        return listCategory;
      } else {
        print(response.statusCode.toString());
        throw (response.statusCode.toString());
      }
    }
    catch(e){
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      throw(e);
    }
  }

Future<List<Categorymodel>> fetchCategoryLang(BuildContext context) async{
    try{
      final response = await ApiHelpers.fetchData('/category/getByLangId/' + await getsharedPref('lang'));
      if (response.statusCode == 200) {
         var list = jsonDecode(response.body) as List;
         var listCategory  = list.map((i) => Categorymodel.fromJson(i)).toList();
         var allProp = await getShowLang('All');
         listCategory.insert(0, Categorymodel('-1', allProp, null, null));
        return listCategory;
      } else {
        print(response.statusCode.toString());
        throw (response.statusCode.toString());
      }
    }
    catch(e){
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      throw(e);
    }
  }