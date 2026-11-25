import 'package:flutter/widgets.dart';

class SensorData {
  final double temperature;
  final double humidity;
  final int updatedAt;

  SensorData({
    required this.temperature,
    required this.humidity,
    required this.updatedAt,
  });

  factory SensorData.fromMap(Map<dynamic, dynamic> map) {
    return SensorData(
      temperature: (map['temperature'] as num?)?.toDouble() ?? 0.0,
      humidity: (map['humidity'] as num?)?.toDouble() ?? 0.0,
      updatedAt: (map['updated_at'] as int?) ?? 0,
    );
  }
}

class ActuatorState {
  final String mode;
  final bool mistMaker;
  final bool exhaustFan;

  ActuatorState({
    required this.mode,
    required this.mistMaker,
    required this.exhaustFan,
  }); 

  factory ActuatorState.fromMap(Map<dynamic, dynamic> map) {
    return ActuatorState(
      mode: (map['mode'] as String?) ?? 'auto',
      mistMaker: (map['mist_maker'] as bool?) ?? false,
      exhaustFan: (map['exhaust_fan'] as bool?) ?? false,
    );
  }
}

class ThresholdsModel {
  final double humidityMin;
  final double humidityMax;
  final double tempMax;

  ThresholdsModel({
    required this.humidityMin,
    required this.humidityMax,
    required this.tempMax,
  });

  factory ThresholdsModel.fromMap(Map<dynamic, dynamic> map) {
    return ThresholdsModel (
      humidityMin: (map['humidity_min'] as num?)?.toDouble() ?? 80.0,
      humidityMax: (map['humidity_max'] as num)?.toDouble() ?? 90.0,
      tempMax: (map['temp_max'] as num)?.toDouble() ?? 28.5,
    );
  }

  Map<String, dynamic> toJson() => {
    'humidty_min': humidityMin,
    'humidity_max': humidityMax,
    'temp_max': tempMax,
  };
}