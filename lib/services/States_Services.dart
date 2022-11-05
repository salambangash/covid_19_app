import 'dart:convert';

import 'package:covid_19_app/model/WorldStateModel.dart';
import 'package:covid_19_app/services/Utillities/App_Url.dart';
import 'package:http/http.dart' as http;

class StateServices {

  Future<WorldStateModel> fetchWorldStatesRecords ()async{
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if(response.statusCode == 200){

      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    }else{

      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countryListApi ()async{

    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if(response.statusCode == 200){

       data = jsonDecode(response.body);
      return data;
    }else{

      throw Exception('Error');
    }
  }
}
