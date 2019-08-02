import 'package:flutter/material.dart';
import '../Classes.dart';

/* Question of type QuestionType.Number */
class NumberQuestion extends StatefulWidget {
  NumberQuestion({Key key,
    @required this.controller,
    this.placeholder
  }) : super(key: key);

  final QuestionController controller;
  final String placeholder;

  _NumberQuestionState createState() => _NumberQuestionState();
}

class _NumberQuestionState extends State<NumberQuestion> {

  TextEditingController controller;

  @override
  void initState() { 
    super.initState();
    controller = TextEditingController(text: widget.controller.value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: controller,
            decoration: InputDecoration(
              hintText: widget.placeholder ?? ''
            ),
            onChanged: (value){
              widget.controller.value = value;
            },
          ),
        )
      ],
    );
  }
}