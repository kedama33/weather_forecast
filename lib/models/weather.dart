import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  // 日時
  final DateTime? time;

  // 場所
  final String? cityName;

  // 天気
  final String? main;

  // 天気アイコン
  final String? icon;

  // 気温
  final int? temp;

  // 最高気温
  final int? tempMax;

  // 最低気温
  final int? tempMin;

  const Weather({
    this.time,
    this.cityName,
    this.main,
    this.icon,
    this.temp,
    this.tempMax,
    this.tempMin,
  });

  @override
  List<Object?> get props => [
        time,
        cityName,
        main,
        icon,
        temp,
        tempMax,
        tempMin,
      ];
}
