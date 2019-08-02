import 'package:flutter/material.dart';
import '../Classes.dart';

class CheckTableQuestion extends StatefulWidget {
  /// Question of type QuestionType.CheckTable
  CheckTableQuestion({
    Key key,
    @required this.controller,
    @required this.possibilities,
  }) : super(key: key);

  final List<dynamic> possibilities;
  final QuestionController controller;

  _CheckTableQuestionState createState() => _CheckTableQuestionState();
}

class _CheckTableQuestionState extends State<CheckTableQuestion> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: List.generate(
        widget.possibilities.length,
        (index){
          return  Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('${widget.possibilities[index]}'),
                Checkbox(
                  value: (widget.controller.value as List)?.contains(widget.possibilities[index]) ?? widget.controller.value == widget.possibilities[index],
                  onChanged: (value){
                    List checked = widget.controller.value?.toList() ?? List();
                    if(value){
                      checked.add(widget.possibilities[index]);
                    } else {
                      checked.removeWhere((e) => e==widget.possibilities[index]);
                    }
                    widget.controller.value = checked;
                  },
                )
              ],
            ),
          );
        }
      )
    );
  }
}