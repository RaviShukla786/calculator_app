part of 'config_model.dart';

Config ConfigFromJson(Map<String, dynamic> json) => Config(
      FieldConfig.fromJson(json['rateOfInterest'] as Map<String, dynamic>),
      PrincipalAmountConfig.fromJson(
          json['principalAmount'] as Map<String, dynamic>),
      CompoundTimesConfig.fromJson(
          json['timesToCompound'] as Map<String, dynamic>),
      YearConfig.fromJson(json['numberOfYears'] as Map<String, dynamic>),
      OutputConfig.fromJson(json['output'] as Map<String, dynamic>),
    );

Map<String, dynamic> ConfigToJson(Config instance) => <String, dynamic>{
      'rateOfInterest': instance.rateOfInterest,
      'principalAmount': instance.principalAmount,
      'timesToCompound': instance.timesToCompound,
      'numberOfYears': instance.numberOfYears,
      'output': instance.output,
    };

FieldConfig FieldConfigFromJson(Map<String, dynamic> json) => FieldConfig(
      json['textColor'] as String,
      (json['textSize'] as num).toInt(),
      json['labelText'] as String,
      (json['values'] as List<dynamic>)
          .map((e) => ValueLabel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> FieldConfigToJson(FieldConfig instance) =>
    <String, dynamic>{
      'textColor': instance.textColor,
      'textSize': instance.textSize,
      'labelText': instance.labelText,
      'values': instance.values,
    };

ValueLabel ValueLabelFromJson(Map<String, dynamic> json) => ValueLabel(
      (json['value'] as num).toInt(),
      json['label'] as String,
    );

Map<String, dynamic> ValueLabelToJson(ValueLabel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
    };

PrincipalAmountConfig PrincipalAmountConfigFromJson(
        Map<String, dynamic> json) =>
    PrincipalAmountConfig(
      json['hintText'] as String,
      json['textColor'] as String,
      (json['textSize'] as num).toInt(),
      Map<String, int>.from(json['minAmount'] as Map),
      (json['maxAmount'] as num).toInt(),
      json['errorMessage'] as String,
    );

Map<String, dynamic> PrincipalAmountConfigToJson(
        PrincipalAmountConfig instance) =>
    <String, dynamic>{
      'hintText': instance.hintText,
      'textColor': instance.textColor,
      'textSize': instance.textSize,
      'minAmount': instance.minAmount,
      'maxAmount': instance.maxAmount,
      'errorMessage': instance.errorMessage,
    };

CompoundTimesConfig CompoundTimesConfigFromJson(Map<String, dynamic> json) =>
    CompoundTimesConfig(
      json['labelText'] as String,
      json['textColor'] as String,
      (json['textSize'] as num).toInt(),
      (json['values'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, (e as List<dynamic>).map((e) => (e as num).toInt()).toList()),
      ),
    );

Map<String, dynamic> CompoundTimesConfigToJson(
        CompoundTimesConfig instance) =>
    <String, dynamic>{
      'labelText': instance.labelText,
      'textColor': instance.textColor,
      'textSize': instance.textSize,
      'values': instance.values,
    };

YearConfig YearConfigFromJson(Map<String, dynamic> json) => YearConfig(
      json['labelText'] as String,
      json['textColor'] as String,
      (json['textSize'] as num).toInt(),
      (json['values'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, (e as List<dynamic>).map((e) => (e as num).toInt()).toList()),
      ),
    );

Map<String, dynamic> YearConfigToJson(YearConfig instance) =>
    <String, dynamic>{
      'labelText': instance.labelText,
      'textColor': instance.textColor,
      'textSize': instance.textSize,
      'values': instance.values,
    };

OutputConfig OutputConfigFromJson(Map<String, dynamic> json) => OutputConfig(
      json['textColor'] as String,
      json['labelText'] as String,
      (json['textSize'] as num).toInt(),
      (json['modeOfDisplay'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> OutputConfigToJson(OutputConfig instance) =>
    <String, dynamic>{
      'textColor': instance.textColor,
      'labelText': instance.labelText,
      'textSize': instance.textSize,
      'modeOfDisplay': instance.modeOfDisplay,
    };
