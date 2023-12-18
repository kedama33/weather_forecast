import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_forecast/consts.dart';
import 'package:weather_forecast/providers/weathers.dart';
import 'package:weather_forecast/screens/screen_home.dart';

//TODO API通信したテスト
void main() {
  Weathers weathers = Weathers();

  Future buildWidget(WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => weathers,
        child: MaterialApp(
          home: ScreenHome(),
        ),
      ),
    );
    await widgetTester.pump();
  }

  group('天気情報を取得できた場合', () {
    testWidgets('背景画像が設定されていることを確認', (widgetTester) async {
      await buildWidget(widgetTester);
      predicate(Widget widget) =>
          widget is Container &&
          widget.decoration ==
              BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'images/${weathers.setBackgroundImage(weathers.currentWeather!.main)}'),
                  fit: BoxFit.cover,
                ),
              );
      expect(
        find.byWidgetPredicate(predicate),
        findsOneWidget,
      );
    });

    testWidgets('市町村名が表示されていることを確認', (widgetTester) async {
      await buildWidget(widgetTester);
      expect(find.text(weathers.currentWeather!.cityName!), findsOneWidget);
    });

    testWidgets('現在の天気が表示されていることを確認', (widgetTester) async {
      await buildWidget(widgetTester);
      expect(
          find.image(
            Image.network(
                    'https://openweathermap.org/img/wn/${weathers.currentWeather!.icon}.png')
                .image,
          ),
          findsOneWidget);
    });

    testWidgets('現在の気温が表示されていることを確認', (widgetTester) async {
      await buildWidget(widgetTester);
      expect(
          find.text(weathers.currentWeather!.temp.toString() + Consts.celsius),
          findsOneWidget);
    });

    testWidgets('当日の最高気温が表示されていることを確認', (widgetTester) async {
      await buildWidget(widgetTester);
      predicate(Widget widget) =>
          widget is Text &&
          widget.data ==
              weathers.currentWeather!.tempMax.toString() + Consts.celsius &&
          widget.style ==
              const TextStyle(
                fontSize: Consts.currentWeatherTextFontSize,
                color: Consts.tempMaxTextColor,
              );
      expect(find.byWidgetPredicate(predicate), findsWidgets);
    });

    testWidgets('当日の最低気温が表示されていることを確認', (widgetTester) async {
      await buildWidget(widgetTester);
      predicate(Widget widget) =>
          widget is Text &&
          widget.data ==
              weathers.currentWeather!.tempMin.toString() + Consts.celsius &&
          widget.style ==
              const TextStyle(
                fontSize: Consts.currentWeatherTextFontSize,
                color: Consts.tempMinTextColor,
              );
      expect(find.byWidgetPredicate(predicate), findsWidgets);
    });

    testWidgets('3時間ごとの天気は縦スクロールできることを確認', (widgetTester) async {
      await buildWidget(widgetTester);

      predicate(Widget widget) =>
          widget is SingleChildScrollView &&
          widget.key == const Key('three_hourly_weather_container');

      expect(find.byWidgetPredicate(predicate), findsOneWidget);
    });

    testWidgets('3時間ごとの時間が表示されていることを確認', (widgetTester) async {
      await buildWidget(widgetTester);
      for (var weather in weathers.threeHourlyWeatherList!) {
        expect(find.text(weather.time!.hour.toString()), findsWidgets);
      }
    });

    testWidgets('3時間ごとの天気が表示されていることを確認', (widgetTester) async {
      await buildWidget(widgetTester);
      for (var weather in weathers.threeHourlyWeatherList!) {
        expect(
          find.image(Image.network(
            'https://openweathermap.org/img/wn/${weather.icon}.png',
          ).image),
          findsOneWidget,
        );
      }
    });

    testWidgets('3時間ごとの気温が表示されていることを確認', (widgetTester) async {
      await buildWidget(widgetTester);
      for (var weather in weathers.threeHourlyWeatherList!) {
        expect(
            find.text(weather.temp.toString() + Consts.celsius), findsWidgets);
      }
    });

    testWidgets('3時間ごとの気温について、日付が変わる時に日付が表示されることを確認', (widgetTester) async {
      await buildWidget(widgetTester);
      for (var weather in weathers.threeHourlyWeatherList!) {
        if (weather.time!.hour == 0) {
          expect(
              find.text(
                weather.time!.day.toString() +
                    Consts.day +
                    Consts.halfLeftParenthesis +
                    Consts.weekday[weather.time!.weekday - 1] +
                    Consts.halfRightParenthesis,
              ),
              findsOneWidget);
        }
      }
    });
  });

  group('天気情報を取得できなかった場合はその旨が表示されること', () {
    testWidgets('現在地を取得する許可がユーザから得られなかった場合', (widgetTester) async {
      await buildWidget(widgetTester);
      expect(find.text('天気情報を取得できませんでした'), findsOneWidget);
    });

    testWidgets('現在地の取得に失敗した場合', (widgetTester) async {
      await buildWidget(widgetTester);
      expect(find.text('天気情報を取得できませんでした'), findsOneWidget);
    });

    testWidgets('現在の天気の取得に失敗した場合', (widgetTester) async {
      await buildWidget(widgetTester);
      expect(find.text('天気情報を取得できませんでした'), findsOneWidget);
    });

    testWidgets('3時間ごとの現在地の天気の取得に失敗した場合', (widgetTester) async {
      await buildWidget(widgetTester);
      expect(find.text('天気情報を取得できませんでした'), findsOneWidget);
    });
  });
}
