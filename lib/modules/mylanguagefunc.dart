import 'dart:convert';

import 'package:agrifamilyapp/Helpers/apiHelpers.dart';
import 'package:agrifamilyapp/models/languagemodel.dart';
import 'package:flutter/material.dart';

Future<List<Languagemodel>> fetchAllLanguages(BuildContext context) async{
    try{
      final response = await ApiHelpers.fetchData('/language/all');
      if (response.statusCode == 200) {
         var list = jsonDecode(response.body) as List;
         var listLanguages  = list.map((i) => Languagemodel.fromJson(i)).toList();
        return listLanguages;
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