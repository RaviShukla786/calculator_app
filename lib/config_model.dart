import 'package:json_annotation/json_annotation.dart';

part 'config_model.g.dart';

@JsonSerializable()
class Config {
  final FieldConfig rateOfInterest;
  final PrincipalAmountConfig principalAmount;
  final CompoundTimesConfig timesToCompound;
  final YearConfig numberOfYears;
  final OutputConfig output;

  Config(this.rateOfInterest, this.principalAmount, this.timesToCompound, this.numberOfYears, this.output);

  factory Config.fromJson(Map<String, dynamic> json) => ConfigFromJson(json);
  Map<String, dynamic> toJson() => ConfigToJson(this);
}

@JsonSerializable()
class FieldConfig {
  final String textColor;
  final int textSize;
  final String labelText;
  final List<ValueLabel> values;

  FieldConfig(this.textColor, this.textSize, this.labelText, this.values);

  factory FieldConfig.fromJson(Map<String, dynamic> json) => FieldConfigFromJson(json);
  Map<String, dynamic> toJson() => FieldConfigToJson(this);
}

@JsonSerializable()
class ValueLabel {
  final int value;
  final String label;

  ValueLabel(this.value, this.label);

  factory ValueLabel.fromJson(Map<String, dynamic> json) => ValueLabelFromJson(json);
  Map<String, dynamic> toJson() => ValueLabelToJson(this);
}

@JsonSerializable()
class PrincipalAmountConfig {
  final String hintText;
  final String textColor;
  final int textSize;
  final Map<String, int> minAmount;
  final int maxAmount;
  final String errorMessage;

  PrincipalAmountConfig(this.hintText, this.textColor, this.textSize, this.minAmount, this.maxAmount, this.errorMessage);

  factory PrincipalAmountConfig.fromJson(Map<String, dynamic> json) => PrincipalAmountConfigFromJson(json);
  Map<String, dynamic> toJson() => PrincipalAmountConfigToJson(this);
}

@JsonSerializable()
class CompoundTimesConfig {
  final String labelText;
  final String textColor;
  final int textSize;
  final Map<String, List<int>> values;

  CompoundTimesConfig(this.labelText, this.textColor, this.textSize, this.values);

  factory CompoundTimesConfig.fromJson(Map<String, dynamic> json) => CompoundTimesConfigFromJson(json);
  Map<String, dynamic> toJson() => CompoundTimesConfigToJson(this);
}

@JsonSerializable()
class YearConfig {
  final String labelText;
  final String textColor;
  final int textSize;
  final Map<String, List<int>> values;

  YearConfig(this.labelText, this.textColor, this.textSize, this.values);

  factory YearConfig.fromJson(Map<String, dynamic> json) => YearConfigFromJson(json);
  Map<String, dynamic> toJson() => YearConfigToJson(this);
}

@JsonSerializable()
class OutputConfig {
  final String textColor;
  final String labelText;
  final int textSize;
  final List<String> modeOfDisplay;

  OutputConfig(this.textColor, this.labelText, this.textSize, this.modeOfDisplay);

  factory OutputConfig.fromJson(Map<String, dynamic> json) => OutputConfigFromJson(json);
  Map<String, dynamic> toJson() => OutputConfigToJson(this);
}