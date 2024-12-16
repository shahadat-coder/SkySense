import 'package:flutter/material.dart';
import 'package:sky_sense/Models/WeatherModel.dart';
import 'package:sky_sense/Viwes/Componants/future_forecast_listitem.dart';
import 'package:sky_sense/Viwes/Componants/hourly-weather_list_item.dart';
import 'package:sky_sense/Viwes/Componants/todays_weather.dart';
import 'package:sky_sense/custom_widgets/custom_color.dart';
import 'package:sky_sense/services/api_service.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  ApiService apiService = ApiService();

  final _textController = TextEditingController();
  String searchText = 'auto:ip';

  _showTextInputDialog(BuildContext contex) async {
    return showDialog(
        context: context,
        builder: (contex) {
          return AlertDialog(
            title: Text('Search Location'),
            content: TextField(
              controller: _textController,
              decoration:
                  InputDecoration(hintText: "search by city,zip,lat,lang"),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(contex);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    if (_textController.text.isEmpty) {
                      return;
                    }

                    Navigator.pop(contex, _textController.text);
                  },
                  child: Text('Okay'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColors,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColors,
        title: Text(
          ' SkySense',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              _textController.clear();
              String text = await _showTextInputDialog(context);
              setState(() {
                searchText = text;
              });
            },
            icon: Icon(Icons.search),
            color: Colors.white70,
          ),
          IconButton(
              onPressed: () {
                searchText = 'auto:ip';
                setState(() {});
              },
              icon: Icon(Icons.my_location),
              color: Colors.white70),
        ],
        titleSpacing: 5,
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: apiService.getWeatherData(searchText),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  WeatherModel? weatherModel = snapshot.data;

                  return SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          TodaysWeather(
                            weatherModel: weatherModel,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Weather by hours",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                                itemCount: weatherModel
                                    ?.forecast?.forecastday?[0].hour?.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  Hour? hour = weatherModel
                                      ?.forecast?.forecastday?[0].hour?[index];

                                  return HourlyWeatherListItem(
                                    hour: hour,
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Next 7 days weather",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount:
                                    weatherModel?.forecast?.forecastday?.length,
                                itemBuilder: (context, index) {
                                  Forecastday? forecastDay = weatherModel
                                      ?.forecast?.forecastday?[index];
                                  return FutureForecastListItem(
                                    forecastday: forecastDay,
                                  );
                                }),
                          ),
                        ],
                      ));
                }
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    'Error has occured',
                    style: TextStyle(color: Colors.white),
                  ));
                }
                return Center(child: CircularProgressIndicator());
              })),
    );
  }
}
