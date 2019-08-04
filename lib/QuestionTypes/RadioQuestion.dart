import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Classes.dart';
import '../FormProvider.dart';
import '../QuestionWidget.dart';

class RadioQuestion extends StatefulWidget {
  /// Question of type QuestionType.Radio
  RadioQuestion({
    Key key,
    @required this.qkey,
    @required this.possibilities,
  }) : super(key: key);

  final List<dynamic> possibilities;
  final GlobalKey<QuestionWidgetState> qkey;

  _RadioQuestionState createState() => _RadioQuestionState();
}

class _RadioQuestionState extends State<RadioQuestion> {

  dynamic selectedValue;

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, formProvider, _widget){
        selectedValue = formProvider.controllers[widget.qkey].value;
        return Wrap(
          children: List.generate(
            widget.possibilities.length,
            (index){
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('${widget.possibilities[index]}'),
                    Radio(
                      value: widget.possibilities[index],
                      groupValue: selectedValue,
                      onChanged: (value){
                        setState(() {
                          selectedValue = value;
                        });
                        formProvider.controllers[widget.qkey].value = value;
                      },
                    ),
                  ],
                ),
              );
            }
          ),
        );
      },
    );
  }
}