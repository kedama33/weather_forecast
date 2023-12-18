import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_forecast/providers/weathers.dart';
import 'package:weather_forecast/widgets/widget_current_weather.dart';
import 'package:weather_forecast/widgets/widget_three_hourly_weather.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weathers = Provider.of<Weathers>(context);

    return Scaffold(
      body: FutureBuilder(
          future: weathers.getCurrentLocationAndWeather(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // 通信中はスピナーを表示
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // 天気情報を取得できた場合は各天気情報を表示
            if (weathers.currentWeather != null &&
                weathers.threeHourlyWeatherList != null) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // 現在の天気によって背景画像を変更
                    image: AssetImage(
                        'images/${weathers.setBackgroundImage(weathers.currentWeather!.main)}'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      // 現在の天気
                      WidgetCurrentWeather(),

                      // 3時間ごとの天気
                      WidgetThreeHourlyWeather(),
                    ],
                  ),
                ),
              );

              // 天気情報を取得できなかった場合はその旨を表示
            } else {
              return const Center(
                child: Text('天気情報を取得できませんでした'),
              );
            }
          }),
    );
  }
}
