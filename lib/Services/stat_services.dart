import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../Models/world_states_model.dart';
import 'Utilities/app_urls.dart';

class StatServices{
  Future<WorldStatesModel> fetchworld()async{
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi)) ;

    if(response.statusCode == 200){
      var data = jsonDecode(response.body) ;
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception('Error') ;
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList)); // Make sure this URL returns a List

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List) {
        return data;
      } else {
        throw Exception('API did not return a list');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }


}