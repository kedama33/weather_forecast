import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:weather_forecast/consts.dart';
import 'package:weather_forecast/models/weather.dart';
import 'package:weather_forecast/models/location.dart';

class Weathers with ChangeNotifier {
  // 現在地を取得する許可の有無
  LocationPermission? permission;

  // 現在地
  Location? currentLocation;

  // 現在の天気
  Weather? currentWeather;

  // 3時間ごとの天気
  List<Weather>? threeHourlyWeatherList;

  // 現在地の取得から天気の取得までを行う
  Future getCurrentLocationAndWeather() async {
    await checkGeolocatorPermission();
    await decideToDoByGeolocatorPermission();
    await getCurrentWeather();
    await getThreeHourlyWeatherList();
  }

  // 現在地を取得する許可の有無がどうなっているか確認
  Future checkGeolocatorPermission() async {
    await Geolocator.requestPermission();
    permission = await Geolocator.checkPermission();
  }

  // 現在地を取得する許可の有無で行う処理を判断する
  Future decideToDoByGeolocatorPermission() async {
    permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse
        // 現在地を取得していい場合は現在地を取得
        ? await getCurrentLocation()
        // 現在地を取得してはいけない場合は天気を取得できなかった旨を表示
        : doWhenCanNotGetCurrentLocation();
  }

  // 現在地を取得する
  Future getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      currentLocation = Location(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      print(e);
      // 現在地の取得に失敗したら天気を取得できなかった旨を表示
      doWhenCanNotGetCurrentLocation();
    }
  }

  // 現在地を取得できなかった場合の処理
  void doWhenCanNotGetCurrentLocation() {
    currentLocation = null;
  }

  // 現在の天気を取得する
  Future getCurrentWeather() async {
    String uri =
        'https://api.openweathermap.org/data/2.5/weather?lat=${currentLocation!.latitude}&lon=${currentLocation!.longitude}&appid=${Consts.apiKey}&units=metric&lang=ja';

    try {
      http.Response response = await http.get(Uri.parse(uri));
      String data = response.body;
      var decodedData = jsonDecode(data);

      currentWeather = Weather(
        cityName: decodedData['name'],
        main: decodedData['weather'][0]['main'],
        icon: decodedData['weather'][0]['icon'],
        temp: decodedData['main']['temp'].toInt(),
        tempMax: decodedData['main']['temp_max'].toInt(),
        tempMin: decodedData['main']['temp_min'].toInt(),
      );
    } catch (e) {
      print(e);
      // 現在の天気の取得に失敗したら天気を取得できなかった旨を表示
      currentWeather = null;
    }
  }

  // 3時間ごとの現在地の天気を取得する
  Future getThreeHourlyWeatherList() async {
    String uri =
        'https://api.openweathermap.org/data/2.5/forecast?lat=${currentLocation!.latitude}&lon=${currentLocation!.longitude}&appid=${Consts.apiKey}&units=metric';

    try {
      http.Response response = await http.get(Uri.parse(uri));
      String data = response.body;
      var decodedData = jsonDecode(data);
      List<dynamic> threeHourlyWeatherDataList = decodedData['list'];

      threeHourlyWeatherList = threeHourlyWeatherDataList
          .map(
            (weather) => Weather(
              time: DateTime.fromMillisecondsSinceEpoch(weather['dt'] * 1000),
              icon: weather['weather'][0]['icon'],
              temp: weather['main']['temp'].toInt(),
            ),
          )
          .toList();
    } catch (e) {
      print(e);
      // 3時間ごとの現在地の天気の取得に失敗したら天気を取得できなかった旨を表示
      threeHourlyWeatherList = null;
    }
  }

  // 天気によって背景画像を変える
  String setBackgroundImage(String? main) {
    late String backgroundImage;

    switch (main) {
      case 'Thunderstorm':
        backgroundImage = 'thunderstorm.jpeg';
        return backgroundImage;
      case 'Drizzle':
        backgroundImage = 'rain.jpg';
        return backgroundImage;
      case 'Rain':
        backgroundImage = 'rain.jpg';
        return backgroundImage;
      case 'Snow':
        backgroundImage = 'snow.jpg';
        return backgroundImage;
      case 'Clear':
        backgroundImage = 'clear_sky.jpeg';
        return backgroundImage;
      case 'Clouds':
        backgroundImage = 'few_clouds.jpg';
        return backgroundImage;
      case 'Mist':
        backgroundImage = 'mist.jpg';
        return backgroundImage;
      case 'Smoke':
        backgroundImage = 'mist.jpg';
        return backgroundImage;
      case 'Haze':
        backgroundImage = 'mist.jpg';
        return backgroundImage;
      case 'Dust':
        backgroundImage = 'mist.jpg';
        return backgroundImage;
      case 'Fog':
        backgroundImage = 'mist.jpg';
        return backgroundImage;
      case 'Sand':
        backgroundImage = 'mist.jpg';
        return backgroundImage;
      case 'Ash':
        backgroundImage = 'mist.jpg';
        return backgroundImage;
      case 'Squall':
        backgroundImage = 'squall.jpg';
        return backgroundImage;
      case 'Tornado':
        backgroundImage = 'tornado.jpeg';
        return backgroundImage;
      default:
        backgroundImage = 'landscape-free-photo.jpeg';
        return backgroundImage;
    }
  }
}
