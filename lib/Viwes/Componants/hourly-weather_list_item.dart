import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourlyWeatherListItem extends StatelessWidget {
  final hour;

  const HourlyWeatherListItem({super.key, this.hour});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  hour?.tempC.round().toString() ?? "",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                "°C",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.teal,
            backgroundImage: NetworkImage(
              "https:${hour?.condition?.icon ?? ""}",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            DateFormat.j().format(DateTime.parse(hour?.time?.toString() ?? "")),
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
