
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'Classes.dart' as classes;
import 'QuestionWidget.dart';
import 'SectionWidget.dart';

class FormProvider extends ChangeNotifier {
  
  classes.Form _form;
  List<GlobalKey<SectionWidgetState>> _sections = List();
  Map<
    GlobalKey<SectionWidgetState>, 
    List<GlobalKey<QuestionWidgetState>>
    > _questions = Map();
  Map<GlobalKey<QuestionWidgetState>,classes.QuestionController> _controllers = Map();

  classes.Form get form => _form;
  List<GlobalKey<SectionWidgetState>> get sectionsKey => _sections;
  Map<
    GlobalKey<SectionWidgetState>, 
    List<GlobalKey<QuestionWidgetState>>
    > get questionsKey => _questions;
  Map<GlobalKey<QuestionWidgetState>,classes.QuestionController> get controllers => _controllers;

  void init(Map<String, dynamic> json, bool readOnly){
    setForm(json, readOnly);
  }

  void setForm(Map<String, dynamic> json, bool readOnly){
    _form = classes.Form.fromJson(json);

    _sections = List();
    _questions = Map();
    _controllers = Map();

    for(var i=0; i<_form.sections.length; i++){
      final skey = GlobalKey<SectionWidgetState>();
      _sections.add(skey);
      _questions.putIfAbsent(skey, () => <GlobalKey<QuestionWidgetState>>[]);
      for(var j=0; j<_form.sections[i].questions.length; j++){
        final qkey = GlobalKey<QuestionWidgetState>();
        _questions[skey].add(qkey);
        print('Question $i $j : ${_form.sections[i].questions[j]}');
        classes.QuestionController qcontroller = classes.QuestionController(sectionKey: skey, question: _form.sections[i].questions[j],  readOnly: readOnly);
        _controllers.putIfAbsent(qkey, () => qcontroller);
      }
    }
  }

}