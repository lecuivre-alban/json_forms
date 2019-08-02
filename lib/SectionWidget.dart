import 'package:flutter/material.dart';

import 'Classes.dart';
import 'QuestionWidget.dart';

class SectionWidget extends StatefulWidget {
  SectionWidget(this.section, {
    Key key,
    this.decoration,
    this.innerPadding,
    this.outterPadding,
    this.useSwitch,
    this.showSectionTitle,
    this.translator
  }) : super(key: key);


  final Section section;
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

  List<GlobalKey<QuestionWidgetState>> questionsKeys = <GlobalKey<QuestionWidgetState>>[];
  List<Widget> questions;

  @override
  void initState() { 
    super.initState();
    widget.section.questions.forEach((_)=>questionsKeys.add(GlobalKey<QuestionWidgetState>()));  
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  refresh() => setState((){});

  bool validate(){
    bool res = true;
  
    for(final q in questionsKeys){
        try{
          if(! q.currentState.validate()) res = false;
        } catch(e) {}
    }
    return res;
  }

  List<Widget> createQuestions(){
    return List.generate(
      widget.section.questions.length, 
      (index){
        final question = widget.section.questions[index];
        if(question.condition != null){
          final questionId = question.condition.questionId;
          final conditionValue = question.condition.value;
          if(widget.section.questions.where(
            (e) => e.id == questionId
          ).first.hasValue(conditionValue)){
            return QuestionWidget(
              parentKey: widget.key,
              question: widget.section.questions[index],
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
            key: questionsKeys[index],
            parentKey: widget.key,
            question: widget.section.questions[index],
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

    return Column(
      children: <Widget>[
        ( widget.showSectionTitle ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.section.name,
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