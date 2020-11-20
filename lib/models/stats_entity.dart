import 'package:json_annotation/json_annotation.dart';
part 'stats_entity.g.dart';

@JsonSerializable()
class StatsEntity {
  String label;
  int step;
  double x;
  double y;
  double z;
  double sum;
  double speed;

  StatsEntity({this.label, this.step, this.x, this.y, this.z, this.sum, this.speed});

  factory StatsEntity.fromJson(Map<String, dynamic> json) => _$StatsEntityFromJson(json);
  Map<String, dynamic> toJson() => _$StatsEntityToJson(this);
}
