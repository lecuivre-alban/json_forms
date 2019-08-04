import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Classes.dart';

import 'FormProvider.dart';
import 'QuestionTypes/TextQuestion.dart';
import 'QuestionTypes/NumberQuestion.dart';
import 'QuestionTypes/BoolQuestion.dart';
import 'QuestionTypes/RadioQuestion.dart';
import 'QuestionTypes/PickQuestion.dart';
import 'QuestionTypes/CheckTableQuestion.dart';
import 'QuestionTypes/OptionalQuantityTable.dart';

class QuestionWidget extends StatefulWidget {
  QuestionWidget(
    {
      Key key, 
      @required this.parentKey,
      @required this.question,
      this.decoration,
      this.innerPadding,
      this.outterPadding,
      this.useSwitch,
      this.showRequired=false,
      this.translator
    }
  ) : super(key: key);

  final GlobalKey parentKey;
  /// Question object to be rendered
  final Question question;
  /// BoxDecoration for the question
  final BoxDecoration decoration;
  /// Padding between [decoration] and question content
  final EdgeInsets innerPadding;
  /// Padding between question and other elements
  final EdgeInsets outterPadding;
  /// Render boolean questions with switch instead of a checkbox
  final bool useSwitch;
  /// Add an icon to indicate that a value is required for this question
  final bool showRequired;

  final Function(String) translator;

  QuestionWidgetState createState() => QuestionWidgetState();
}

class QuestionWidgetState extends State<QuestionWidget> {

  bool _error = false;

  bool validate(){
    if(! widget.question.validate()){
      setState(() {
        _error = true;
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Widget question;
    switch(widget.question.type){
      case QuestionTypes.Text:
        question = TextQuestion(
          placeholder: widget.question.placeholder,
          qkey: widget.key,
        );
        break;
      case QuestionTypes.Number:
        question = NumberQuestion(
          placeholder: widget.question.placeholder,
          qkey: widget.key
        );
        break;
      case QuestionTypes.Bool:
        question = BoolQuestion(
          qkey: widget.key,
          useSwitch: widget.useSwitch,
        );
        break;
      case QuestionTypes.Radio:
        question = RadioQuestion(
          possibilities: widget.question.possibilities,
          qkey: widget.key
        );
        break;
      case QuestionTypes.Pick:
        question = PickQuestion(
          qkey: widget.key,
          possibilities: widget.question.possibilities,
        );
        break;
      case QuestionTypes.CheckTable:
        question = CheckTableQuestion(
          qkey: widget.key,
          possibilities: widget.question.possibilities,
        );
        break;
      case QuestionTypes.OptionalQuantityTable:
        question = OptionalQuantityTable(
          qkey: widget.key,
          possibilities: widget.question.possibilities,
        );
        break;
      default:
        return Container();
    }

    if( // Question to be displayed on one line
      widget.question.type == QuestionTypes.Bool ||
      widget.question.type == QuestionTypes.Pick
    ) {
      return Padding(
        padding: widget.outterPadding,
        child: Container(
          decoration: widget.decoration,
          child: Padding(
            padding: widget.innerPadding,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    (widget.question.text!='' && widget.question.text!= null ?
                    Expanded(
                      child: Text(widget.question.text),
                    ) : Container() ),
                    ( widget.showRequired ?
                      Icon(Icons.warning, size: 14,)
                      :
                      Container()
                    ),
                    question,
                  ],
                ),
                (_error ? _errorWidget() : Container() ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: widget.outterPadding,
        child: Container(
          decoration: widget.decoration,
          child: Padding(
            padding: widget.innerPadding,
            child: Column(
              children: <Widget>[
                (widget.question.text!='' && widget.question.text!= null ?
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(widget.question.text),
                    ),
                  ],
                ) : Container() ),
                Row(
                  children: <Widget>[
                    Expanded(child: question),
                    ( widget.showRequired ?
                      Icon(Icons.warning, size: 14,)
                      :
                      Container()
                    )
                  ],
                ),
                (_error ? _errorWidget() : Container() ),
              ],
            ),
          ),
        ),
      );
    }        
  }

    _errorWidget() => Padding(
    padding: const EdgeInsets.only(top: 2.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            /*decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
              color: Colors.red[600],
            ),*/
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                ( widget.translator!=null && widget.question.invalidMessageKey!=null ? widget.translator(widget.question.invalidMessageKey) : 'The field is empty'),
                style: TextStyle(color: Colors.red[600]),),
            ),
          ),
        )
      ],
    ),
  );
}