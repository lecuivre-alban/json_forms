
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

import 'SectionWidget.dart';

part 'Classes.g.dart';

enum QuestionTypes {
  Text,
  Number,
  Bool,
  Radio,
  Pick,
  CheckTable,
  OptionalQuantityTable
}

@JsonSerializable()
class Form{
  final String name;
  final List<Section> sections;
  
  Form({this.name, this.sections});

  factory Form.fromJson(Map<String, dynamic> json) => _$FormFromJson(json);
  Map<String, dynamic> toJson() => _$FormToJson(this);
} 

@JsonSerializable()
class Section{
  final String name;
  final List<Question> questions;

  Section({this.name, this.questions});

  factory Section.fromJson(Map<String, dynamic> json) => _$SectionFromJson(json);
  Map<String, dynamic> toJson() => _$SectionToJson(this);

}

@JsonSerializable()
class Question {
  final int id;
  final String text;
  final QuestionTypes type;
  dynamic value;
  final List<dynamic> possibilities;
  final Condition condition;
  final bool isRequired;
  final String placeholder;
  final String invalidMessageKey;
  

  Question({this.id, this.text, this.type, this.value, this.possibilities, this.condition, this.isRequired, this.placeholder, this.invalidMessageKey});

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  bool hasValue(dynamic v){
    bool res;
    try{
      res = (value as List).contains(v);
    }catch(e){
      res = (value == v);
    }
    return res;
  }

  bool validate(){
    if(isRequired){
      if (value == null || value == '') return false;
    }
    return true;
  }
}

@JsonSerializable()
class Condition{
  final int questionId;
  final dynamic value;

  Condition({this.questionId, this.value});

  factory Condition.fromJson(Map<String, dynamic> json) => _$ConditionFromJson(json);
  Map<String, dynamic> toJson() => _$ConditionToJson(this);
}

class QuestionController extends ChangeNotifier{
  Question _question;
  dynamic _value;
  GlobalKey<SectionWidgetState> _sectionKey;
  QuestionController({GlobalKey<SectionWidgetState> sectionKey, Question question}):_question=question, _value=question.value,_sectionKey=sectionKey{
    this.addListener((){
      _sectionKey.currentState.refresh();
    });
  }

  get value => _value;

  set value(dynamic v){
    print(v);
    _value = v;
    _question.value = v;
    notifyListeners();
  }
}