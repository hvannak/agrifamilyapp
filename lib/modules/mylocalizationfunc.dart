import 'dart:convert';

import 'package:agrifamilyapp/Helpers/apiHelpers.dart';
import 'package:agrifamilyapp/models/localizationmodel.dart';
import 'package:flutter/material.dart';

Future<List<Localizationmodel>> fetchLocalLanguage(BuildContext context,String langId) async{
    try{
      final response = await ApiHelpers.fetchData('/localization/getByLang/' + langId );
      if (response.statusCode == 200) {
         var list = jsonDecode(response.body) as List;
         var listLocal  = list.map((i) => Localizationmodel.fromJson(i)).toList();
        return listLocal;
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