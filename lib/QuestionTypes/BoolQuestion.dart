import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../FormProvider.dart';
import '../QuestionWidget.dart';

/* Question of type QuestionType.Bool */
class BoolQuestion extends StatefulWidget {
  BoolQuestion(
    {
      Key key,
      @required this.qkey,
      @required this.useSwitch
    }
  ) : super(key: key);

  final GlobalKey<QuestionWidgetState> qkey;
  final bool useSwitch;

  _BoolQuestionState createState() => _BoolQuestionState();
}

class _BoolQuestionState extends State<BoolQuestion> {

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, formProvider, _widget){
        return ( widget.useSwitch ?
          Switch(
            value: formProvider.controllers[widget.qkey].value,
            onChanged: (value){
              if(formProvider.controllers[widget.qkey].readOnly==false){
                setState(() {
                });
                formProvider.controllers[widget.qkey].value = value;
              }
              
            },
          )
          :
          Checkbox(
            value: formProvider.controllers[widget.qkey].value,
            onChanged: (value){
              if(formProvider.controllers[widget.qkey].readOnly==false){
                setState(() {
                });
                formProvider.controllers[widget.qkey].value = value;
              }
            },
          )
        );
      },
    );
  }
}