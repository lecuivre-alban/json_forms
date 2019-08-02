// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Form _$FormFromJson(Map<String, dynamic> json) {
  return Form(
    name: json['name'] as String,
    sections: (json['sections'] as List)
        ?.map((e) =>
            e == null ? null : Section.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FormToJson(Form instance) => <String, dynamic>{
      'name': instance.name,
      'sections': instance.sections,
    };

Section _$SectionFromJson(Map<String, dynamic> json) {
  return Section(
    name: json['name'] as String,
    questions: (json['questions'] as List)
        ?.map((e) =>
            e == null ? null : Question.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SectionToJson(Section instance) => <String, dynamic>{
      'name': instance.name,
      'questions': instance.questions,
    };

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    id: json['id'] as int,
    text: json['text'] as String,
    type: _$enumDecodeNullable(_$QuestionTypesEnumMap, json['type']),
    value: json['value'],
    possibilities: json['possibilities'] as List,
    condition: json['condition'] == null
        ? null
        : Condition.fromJson(json['condition'] as Map<String, dynamic>),
    isRequired: json['isRequired'] as bool,
    placeholder: json['placeholder'] as String,
    invalidMessageKey: json['invalidMessageKey'] as String,
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'type': _$QuestionTypesEnumMap[instance.type],
      'value': instance.value,
      'possibilities': instance.possibilities,
      'condition': instance.condition,
      'isRequired': instance.isRequired,
      'placeholder': instance.placeholder,
      'invalidMessageKey': instance.invalidMessageKey,
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$QuestionTypesEnumMap = <QuestionTypes, dynamic>{
  QuestionTypes.Text: 'Text',
  QuestionTypes.Number: 'Number',
  QuestionTypes.Bool: 'Bool',
  QuestionTypes.Radio: 'Radio',
  QuestionTypes.Pick: 'Pick',
  QuestionTypes.CheckTable: 'CheckTable',
  QuestionTypes.OptionalQuantityTable: 'OptionalQuantityTable'
};

Condition _$ConditionFromJson(Map<String, dynamic> json) {
  return Condition(
    questionId: json['questionId'] as int,
    value: json['value'],
  );
}

Map<String, dynamic> _$ConditionToJson(Condition instance) => <String, dynamic>{
      'questionId': instance.questionId,
      'value': instance.value,
    };
