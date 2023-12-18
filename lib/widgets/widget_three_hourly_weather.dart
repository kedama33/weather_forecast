import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_forecast/consts.dart';
import 'package:weather_forecast/providers/weathers.dart';

/*
  3時間ごとの天気を表示
 */
class WidgetThreeHourlyWeather extends StatelessWidget {
  const WidgetThreeHourlyWeather({super.key});

  @override
  Widget build(BuildContext context) {
    final weathers = Provider.of<Weathers>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Consts.screenHomeWeatherWidgetBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        key: const Key('three_hourly_weather_container'),
        child: Column(
          children: weathers.threeHourlyWeatherList!
              .map(
                (weather) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // 日付が変わる時に日付を表示
                      if (weather.time!.hour == 0)
                        Container(
                          width: double.infinity,
                          color: Colors.white24,
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            weather.time!.day.toString() +
                                Consts.day +
                                Consts.halfLeftParenthesis +
                                Consts.weekday[weather.time!.weekday - 1] +
                                Consts.halfRightParenthesis,
                            style: const TextStyle(
                              fontSize: Consts.threeHourlyWeatherFontSize,
                              color: Consts.normalTextColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // 時間
                          Text(
                            weather.time!.hour.toString() + Consts.hour,
                            style: const TextStyle(
                              fontSize: Consts.threeHourlyWeatherFontSize,
                              color: Consts.normalTextColor,
                            ),
                          ),

                          // 天気
                          Image.network(
                              'https://openweathermap.org/img/wn/${weather.icon}.png'),

                          // 気温
                          Text(
                            weather.temp.toString() + Consts.celsius,
                            style: const TextStyle(
                              fontSize: Consts.threeHourlyWeatherFontSize,
                              color: Consts.normalTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
