import 'dart:convert';
import 'package:http/http.dart';
import 'package:sky_sense/Models/WeatherModel.dart';
import 'package:sky_sense/constents/constents.dart';

class ApiService{
  Future<WeatherModel>getWeatherData(String searchText)async{

    String url = '$baseUrl&q=$searchText&days=7';

    try{

      Response response = await get(Uri.parse(url));
      if(response.statusCode == 200){

        Map<String,dynamic> json = jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(json);
        return weatherModel;

      }else{
        throw ('Data not found');
      }

    }catch(e){
      print(e.toString());
      throw e.toString();
    }
  }
}