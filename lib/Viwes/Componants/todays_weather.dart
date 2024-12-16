import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import 'package:sky_sense/Models/WeatherModel.dart';

class TodaysWeather extends StatelessWidget {
  final WeatherModel? weatherModel;

  const TodaysWeather({super.key, this.weatherModel});

  WeatherType getWeatherType(Current? current) {
    if (current?.isDay == 1) {
      if (current?.condition?.text == "Sunny") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "Overcast") {
        return WeatherType.overcast;
      } else if (current?.condition?.text == "Partly cloudy") {
        return WeatherType.cloudy;
      } else if (current?.condition?.text == "Cloudy") {
        return WeatherType.cloudy;
      } else if (current?.condition?.text == "Clear") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "Mist") {
        return WeatherType.lightSnow;
      } else if (current!.condition!.text!.contains("thunder")) {
        return WeatherType.thunder;
      } else if (current.condition!.text!.contains("showers")) {
        return WeatherType.middleSnow;
      } else if (current.condition!.text!.contains("rain")) {
        return WeatherType.heavyRainy;
      }
    } else {
      if (current?.condition?.text == "Sunny") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "Overcast") {
        return WeatherType.overcast;
      } else if (current?.condition?.text == "Partly cloudy") {
        return WeatherType.cloudyNight;
      } else if (current?.condition?.text == "Cloudy") {
        return WeatherType.cloudyNight;
      } else if (current?.condition?.text == "Clear") {
        return WeatherType.sunnyNight;
      } else if (current?.condition?.text == "Mist") {
        return WeatherType.lightSnow;
      } else if (current!.condition!.text!.contains("thunder")) {
        return WeatherType.thunder;
      } else if (current.condition!.text!.contains("showers")) {
        return WeatherType.middleSnow;
      } else if (current.condition!.text!.contains("rain")) {
        return WeatherType.heavyRainy;
      }
    }
    return WeatherType.middleRainy;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: [
          WeatherBg(
            weatherType: getWeatherType(weatherModel?.current),
            width: MediaQuery.of(context).size.width,
            height: 358,
          ),
          SizedBox(
            width: double.infinity,
            height: 358,
            child: Column(
              children: [
                SizedBox(height: 10),
                // Location and Date Container
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        weatherModel?.location?.name ?? "Unknown Location",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        weatherModel?.current?.lastUpdated != null
                            ? DateFormat.yMMMMEEEEd().format(
                                DateTime.parse(
                                    weatherModel!.current!.lastUpdated!),
                              )
                            : "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                // Weather Condition Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white24,
                        ),
                        child: Image.network(
                          "https:${weatherModel?.current?.condition?.icon ?? ''}",
                          height: 60,
                          width: 60,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weatherModel?.current?.tempC
                                        ?.round()
                                        .toString() ??
                                    "-",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 60,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "°C",
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            weatherModel?.current?.condition?.text ?? "N/A",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                // Additional Weather Info Container
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Feels Like\n${weatherModel?.current?.feelslikeC?.round().toString() ?? "-"} °C',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Wind\n${weatherModel?.current?.windKph?.round().toString() ?? "-"} km/h',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 5,
                          color: Colors.white54,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Humidity\n${weatherModel?.current?.humidity?.toString() ?? "-"}%',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Visibility\n${weatherModel?.current?.visKm?.toString() ?? "-"} km',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
