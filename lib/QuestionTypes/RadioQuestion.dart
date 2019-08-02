import 'package:flutter/material.dart';
import '../Classes.dart';

class RadioQuestion extends StatefulWidget {
  /// Question of type QuestionType.Radio
  RadioQuestion({
    Key key,
    @required this.controller,
    @required this.possibilities,
  }) : super(key: key);

  final List<dynamic> possibilities;
  final QuestionController controller;

  _RadioQuestionState createState() => _RadioQuestionState();
}

class _RadioQuestionState extends State<RadioQuestion> {

  dynamic selectedValue;

  @override
  void initState() { 
    super.initState();
    selectedValue = widget.controller.value;
  }

  @override
  Widget build(BuildContext context) {
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
                    widget.controller.value = value;
                  },
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}