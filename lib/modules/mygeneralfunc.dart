import 'dart:convert';

import 'package:agrifamilyapp/models/localizationmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getsharedPref(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? "";
}

setsharedPref(String key,String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

removesharedPref(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}

Future<String> getShowLang(String prop) async {
  var list = jsonDecode(await getsharedPref('local')) as List;
  var listLocal = list.map((i) => Localizationmodel.fromJson(i)).toList().where((x) => x.props == prop && x.type == 'const').toList();
  return (listLocal.length > 0) ? listLocal[0].text : "Not Set";
}

  
  reInstantiateImagesCodec(List<int> buffer){
    String strValue = new String.fromCharCodes(buffer);
    if(strValue.startsWith("data:image/png;base64,")){
      strValue = strValue.split(",")[1];
      return base64Decode(strValue);
    } else {
      return buffer;
    }            
  }