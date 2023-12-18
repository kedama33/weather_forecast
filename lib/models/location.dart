import 'package:equatable/equatable.dart';

class Location extends Equatable {
  // 緯度
  final double latitude;

  // 経度
  final double longitude;

  const Location({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];
}
