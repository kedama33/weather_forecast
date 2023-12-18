import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:weather_forecast/providers/weathers.dart';
import 'package:weather_forecast/models/location.dart';

//TODO API通信したテスト
@GenerateMocks([http.Client])
void main() {
  Weathers weathers = Weathers();

  test('現在地を取得する許可の有無を取得できること', () => null);

  group('現在地を取得する許可の有無によって処理が変わること', () {
    test('現在地を取得していい場合は現在地を取得すること', () => null);

    test('現在地を取得してはいけない場合はcurrentLocationがnullになること', () {
      weathers.doWhenCanNotGetCurrentLocation();
      expect(weathers.currentLocation, null);
    });
  });

  test('現在地を取得できること', () => null);

  test('現在地を取得できなかった場合はcurrentLocationがnullになること', () => null);

  test('現在の天気情報が取得できること', () => null);

  test('現在の天気情報が取得できなかった場合はcurrentWeatherがnullになること', () => null);

  test('3時間ごとの天気情報が取得できること', () => null);

  test('3時間ごとの天気情報が取得できなかった場合はthreeHourlyWeatherListがnullになること', () => null);

  test('天気によって背景画像が変わることを確認', () {
    expect(weathers.setBackgroundImage('Thunderstorm'), 'thunderstorm.jpeg');
    expect(weathers.setBackgroundImage('Drizzle'), 'rain.jpg');
    expect(weathers.setBackgroundImage('Rain'), 'rain.jpg');
    expect(weathers.setBackgroundImage('Snow'), 'snow.jpg');
    expect(weathers.setBackgroundImage('Clear'), 'clear_sky.jpeg');
    expect(weathers.setBackgroundImage('Clouds'), 'few_clouds.jpg');
    expect(weathers.setBackgroundImage('Mist'), 'mist.jpg');
    expect(weathers.setBackgroundImage('Smoke'), 'mist.jpg');
    expect(weathers.setBackgroundImage('Haze'), 'mist.jpg');
    expect(weathers.setBackgroundImage('Dust'), 'mist.jpg');
    expect(weathers.setBackgroundImage('Fog'), 'mist.jpg');
    expect(weathers.setBackgroundImage('Sand'), 'mist.jpg');
    expect(weathers.setBackgroundImage('Ash'), 'mist.jpg');
    expect(weathers.setBackgroundImage('Squall'), 'squall.jpg');
    expect(weathers.setBackgroundImage('Tornado'), 'tornado.jpeg');
    expect(weathers.setBackgroundImage(''), 'landscape-free-photo.jpeg');
  });
}
