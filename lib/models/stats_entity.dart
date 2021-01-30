import 'package:json_annotation/json_annotation.dart';
part 'stats_entity.g.dart';

@JsonSerializable()
class StatsEntity {
  String label;
  double x;
  double y;
  double z;
  double sum;
  int step;
  double speed;
  bool send = true;
  bool isFall;

  StatsEntity(
      {this.label, this.x, this.y, this.z, this.sum, this.step, this.speed, this.send, this.isFall});

  factory StatsEntity.fromJson(Map<String, dynamic> json) => _$StatsEntityFromJson(json);
  Map<String, dynamic> toJson() => _$StatsEntityToJson(this);
}
