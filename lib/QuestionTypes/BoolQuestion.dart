import 'package:flutter/material.dart';
import '../Classes.dart';

/* Question of type QuestionType.Bool */
class BoolQuestion extends StatefulWidget {
  BoolQuestion(
    {
      Key key,
      @required this.controller,
      @required this.useSwitch
    }
  ) : super(key: key);

  final QuestionController controller;
  final bool useSwitch;

  _BoolQuestionState createState() => _BoolQuestionState();
}

class _BoolQuestionState extends State<BoolQuestion> {

  bool boolValue;

  @override
  void initState() { 
    super.initState();
    boolValue = widget.controller.value;
  }
  @override
  Widget build(BuildContext context) {
    return ( widget.useSwitch ?
      Switch(
        value: boolValue,
        onChanged: (value){
          setState(() {
            boolValue = value;
          });
          widget.controller.value = value;
        },
      )
      :
      Checkbox(
        value: boolValue,
        onChanged: (value){
          setState(() {
            boolValue = value;
          });
          widget.controller.value = value;
        },
      )
    );
  }
}