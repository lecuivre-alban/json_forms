import 'package:flutter/material.dart';
import '../Classes.dart';

/* Question of type QuestionType.Text */
class TextQuestion extends StatefulWidget {
  TextQuestion({Key key,
    @required this.controller,
    this.placeholder,
  }) : super(key: key);

  final QuestionController controller;
  final String placeholder;
  _TextQuestionState createState() => _TextQuestionState();
}

class _TextQuestionState extends State<TextQuestion> {

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