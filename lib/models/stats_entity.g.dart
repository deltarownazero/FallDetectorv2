// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatsEntity _$StatsEntityFromJson(Map<String, dynamic> json) {
  return StatsEntity(
    label: json['label'] as String,
    x: (json['x'] as num)?.toDouble(),
    y: (json['y'] as num)?.toDouble(),
    z: (json['z'] as num)?.toDouble(),
    sum: (json['sum'] as num)?.toDouble(),
    step: json['step'] as int,
    speed: (json['speed'] as num)?.toDouble(),
    send: json['send'] as bool,
  );
}

Map<String, dynamic> _$StatsEntityToJson(StatsEntity instance) =>
    <String, dynamic>{
      'label': instance.label,
      'x': instance.x,
      'y': instance.y,
      'z': instance.z,
      'sum': instance.sum,
      'step': instance.step,
      'speed': instance.speed,
      'send': instance.send,
    };
