import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sky_sense/Models/WeatherModel.dart';

class FutureForecastListItem extends StatelessWidget {
  final Forecastday? forecastday;

  const FutureForecastListItem({super.key, this.forecastday});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white24, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Image.network("https:${forecastday?.day?.condition?.icon ?? ''}"),
              Expanded(
                child: Text(
                  forecastday?.date != null
                      ? DateFormat.MMMEd().format(
                          DateTime.parse(forecastday?.date.toString() ?? ''),
                        )
                      : "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  forecastday?.day?.condition?.text.toString() ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "^${forecastday?.day?.maxtempC?.round().toString() ?? ''}/${forecastday?.day?.mintempC?.round().toString() ?? ''}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
