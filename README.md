# Flutterを使った天気予報アプリ

現在地の天気予報を取得するアプリです。
天気の情報はOpenWeatherMapのAPIを使用して取得しています。

## 表示されるもの
 - 現在地の地名（Geolocatorパッケージを使用して取得）
 - 現在地の今の天気（アイコンで表示）
 - 現在地の今の気温・当日の最高気温・当日の最低気温
   - 現在の天気によって背景の画像が変わります

 - 当日から5日間の3時間ごとの天気予報
   - 天気（アイコンで表示）
   - 気温
 
## 注意点
 - OpenWeatherMapのAPIkeyを設定する必要があります。
 - APIkeyは"consts.dart"の"apiKey"に設定してください。

## OpenWeatherMap
https://openweathermap.org/

## 参考
https://www.udemy.com/course/flutter-api/learn/lecture/26577992#overview
