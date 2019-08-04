import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Classes.dart';
import 'FormProvider.dart';
import 'QuestionWidget.dart';

class SectionWidget extends StatefulWidget {
  SectionWidget(this.i, {
    Key key,
    this.decoration,
    this.innerPadding,
    this.outterPadding,
    this.useSwitch,
    this.showSectionTitle,
    this.translator
  }) : super(key: key);


  final int i;
  /// BoxDecoration for the question
  final BoxDecoration decoration;
  /// Padding between [decoration] and question content
  final EdgeInsets innerPadding;
  /// Padding between question and other elements
  final EdgeInsets outterPadding;
  /// Render boolean questions with switch instead of a checkbox
  final bool useSwitch;
  /// Show title of the section
  final bool showSectionTitle;

  final Function(String) translator;

  SectionWidgetState createState() => SectionWidgetState();
}

class SectionWidgetState extends State<SectionWidget> {

  List<Widget> questions;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  refresh() => setState((){});
  

  bool validate(){
    bool res = true;
  
    for(final q in Provider.of<FormProvider>(context).questionsKey[widget.key]){
        try{
          if(! q.currentState.validate()) res = false;
        } catch(e) {print(e);}
    }
    return res;
  }

  List<Widget> createQuestions(){
    return List.generate(
      Provider.of<FormProvider>(context).form.sections[widget.i].questions.length, 
      (index){
        final question = Provider.of<FormProvider>(context).form.sections[widget.i].questions[index];
        if(question.condition != null){
          final questionId = question.condition.questionId;
          final conditionValue = question.condition.value;
          if(Provider.of<FormProvider>(context).form.sections[widget.i].questions.where(
            (e) => e.id == questionId
          ).first.hasValue(conditionValue)){
            return QuestionWidget(
              parentKey: widget.key,
              key: Provider.of<FormProvider>(context).questionsKey[widget.key][index],
              question: Provider.of<FormProvider>(context).form.sections[widget.i].questions[index],
              decoration: widget.decoration,
              innerPadding: widget.innerPadding,
              outterPadding: widget.outterPadding,
              useSwitch: widget.useSwitch,
              translator: widget.translator
            );
          } else {
            return Container();
          }
        } else {
          return QuestionWidget(
            key: Provider.of<FormProvider>(context).questionsKey[widget.key][index],
            parentKey: widget.key,
            question: Provider.of<FormProvider>(context).form.sections[widget.i].questions[index],
            decoration: widget.decoration,
            innerPadding: widget.innerPadding,
            outterPadding: widget.outterPadding,
            useSwitch: widget.useSwitch,
            translator: widget.translator
          );
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    questions = createQuestions();
    print(jsonEncode(Provider.of<FormProvider>(context).form));
    return Column(
      children: <Widget>[
        ( widget.showSectionTitle ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(Provider.of<FormProvider>(context).form.sections[widget.i].name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20
            ),
          ),
        ) : Container() ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: questions,
            ),
          )
        ),
      ],
    );
  }
}