import 'package:json_annotation/json_annotation.dart';

part 'subscriptions_models.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class GetByProfileResponseDto {
  final List<PlanDto> results;

  GetByProfileResponseDto(this.results);

  factory GetByProfileResponseDto.fromJson(Map<String, dynamic> json) => _$GetByProfileResponseDtoFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class PlanDto {
  final int id;
  final String title;
  final bool isActive;
  final double cost;
  final int currency;
  final int? activeCoid;

  PlanDto(
    this.id,
    this.title,
    this.isActive,
    this.cost,
    this.currency,
    this.activeCoid,
  );

  factory PlanDto.fromJson(Map<String, dynamic> json) => _$PlanDtoFromJson(json);
}
