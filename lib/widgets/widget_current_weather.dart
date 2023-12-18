import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_forecast/consts.dart';
import 'package:weather_forecast/providers/weathers.dart';

/*
  現在の天気を表示
 */
class WidgetCurrentWeather extends StatelessWidget {
  const WidgetCurrentWeather({super.key});

  @override
  Widget build(BuildContext context) {
    final weathers = Provider.of<Weathers>(context);

    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: BoxDecoration(
          color: Consts.screenHomeWeatherWidgetBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 表示されている市町村名
                Text(
                  weathers.currentWeather!.cityName.toString(),
                  style: const TextStyle(
                    fontSize: Consts.cityNameFontSize,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            // 現在の天気
            Image.network(
              'https://openweathermap.org/img/wn/${weathers.currentWeather!.icon}.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 現在の気温
                Text(
                  weathers.currentWeather!.temp.toString() + Consts.celsius,
                  style: const TextStyle(
                    fontSize: Consts.currentWeatherTextFontSize,
                    color: Consts.normalTextColor,
                  ),
                ),

                // 当日の最高気温
                Text(
                  weathers.currentWeather!.tempMax.toString() + Consts.celsius,
                  style: const TextStyle(
                    fontSize: Consts.currentWeatherTextFontSize,
                    color: Consts.tempMaxTextColor,
                  ),
                ),

                // 当日の最低気温
                Text(
                  weathers.currentWeather!.tempMin.toString() + Consts.celsius,
                  style: const TextStyle(
                    fontSize: Consts.currentWeatherTextFontSize,
                    color: Consts.tempMinTextColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
