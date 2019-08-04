import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Classes.dart';
import '../FormProvider.dart';
import '../QuestionWidget.dart';

/* Question of type QuestionType.Number */
class NumberQuestion extends StatefulWidget {
  NumberQuestion({Key key,
    @required this.qkey,
    this.placeholder
  }) : super(key: key);

  final GlobalKey<QuestionWidgetState> qkey;
  final String placeholder;

  _NumberQuestionState createState() => _NumberQuestionState();
}

class _NumberQuestionState extends State<NumberQuestion> {

  TextEditingController controller;

  @override
  void initState() { 
    super.initState();
    Future.delayed(Duration(seconds: 0), (){
      controller = TextEditingController(text: Provider.of<FormProvider>(context).controllers[widget.qkey].value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, formProvider, _widget){
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
                  formProvider.controllers[widget.qkey].value = value;
                },
              ),
            )
          ],
        );
      },
    );
  }
}