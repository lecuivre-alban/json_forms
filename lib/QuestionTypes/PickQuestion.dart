import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Classes.dart';
import '../FormProvider.dart';
import '../QuestionWidget.dart';

class PickQuestion extends StatefulWidget {
  /// Question of type QuestionType.Pick
  PickQuestion({
    Key key,
    @required this.qkey,
    @required this.possibilities,
  }) : super(key: key);

  final List<dynamic> possibilities;
  final GlobalKey<QuestionWidgetState> qkey;

  _PickQuestionState createState() => _PickQuestionState();
}

class _PickQuestionState extends State<PickQuestion> {
  
  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, formProvider, _widget){
        return Row(
          children: <Widget>[
            DropdownButton(
              value: formProvider.controllers[widget.qkey].value,
              items: List.generate(
                widget.possibilities.length,
                (index){
                  return DropdownMenuItem(
                    value: widget.possibilities[index],
                    child: Text('${widget.possibilities[index]}'),
                  );
                }
              ),
              onChanged: (value){
                setState(() {
                  formProvider.controllers[widget.qkey].value = value;
                });
              },
            )
          ],
        );
      },
    );
  }
}
