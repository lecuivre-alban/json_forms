import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../FormProvider.dart';
import '../QuestionWidget.dart';

class CheckTableQuestion extends StatefulWidget {
  /// Question of type QuestionType.CheckTable
  CheckTableQuestion({
    Key key,
    @required this.qkey,
    @required this.possibilities,
  }) : super(key: key);

  final List<dynamic> possibilities;
  final GlobalKey<QuestionWidgetState> qkey;

  _CheckTableQuestionState createState() => _CheckTableQuestionState();
}

class _CheckTableQuestionState extends State<CheckTableQuestion> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, formProvider, _widget){
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
                      value: (formProvider.controllers[widget.qkey].value as List)?.contains(widget.possibilities[index]) ?? formProvider.controllers[widget.qkey].value == widget.possibilities[index],
                      onChanged: (value){
                        List checked = formProvider.controllers[widget.qkey].value?.toList() ?? List();
                        if(value){
                          checked.add(widget.possibilities[index]);
                        } else {
                          checked.removeWhere((e) => e==widget.possibilities[index]);
                        }
                        formProvider.controllers[widget.qkey].value = checked;
                      },
                    )
                  ],
                ),
              );
            }
          )
        );
      },
    );
  }
}