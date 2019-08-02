import 'package:flutter/material.dart';
import '../Classes.dart';

class PickQuestion extends StatefulWidget {
  /// Question of type QuestionType.Pick
  PickQuestion({
    Key key,
    @required this.controller,
    @required this.possibilities,
  }) : super(key: key);

  final List<dynamic> possibilities;
  final QuestionController controller;

  _PickQuestionState createState() => _PickQuestionState();
}

class _PickQuestionState extends State<PickQuestion> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        DropdownButton(
          value: widget.controller.value,
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
              widget.controller.value = value;
            });
          },
        )
      ],
    );
  }
}
