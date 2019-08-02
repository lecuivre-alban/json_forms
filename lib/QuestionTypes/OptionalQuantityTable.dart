import 'package:flutter/material.dart';
import '../Classes.dart';

class OptionalQuantityTable extends StatefulWidget {
  OptionalQuantityTable({
    Key key,
    @required this.possibilities,
    @required this.controller
  }) : super(key: key);

  final List<dynamic> possibilities;
  final QuestionController controller;

  _OptionalQuantityTableState createState() => _OptionalQuantityTableState();
}

class _OptionalQuantityTableState extends State<OptionalQuantityTable> {

  Map<dynamic, TextEditingController> controllers = Map();
  Map<dynamic, int> map;

  @override
  void initState() { 
    super.initState();
    map=widget.controller.value;
    for(final p in widget.possibilities){
      dynamic init;
      try {
        init  = widget.controller.value[p];
      } catch(e){}
      controllers.putIfAbsent(p, () => TextEditingController(text: (init ?? '').toString()));
    }  
  }

  @override
  void didChangeDependencies() {
    map?.removeWhere((k,v)=>v==null);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: List.generate(
        widget.possibilities.length,
        (index){
          return  Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Checkbox(
                  value: map?.keys?.contains(widget.possibilities[index]) ?? false,
                  onChanged: (value){
                    Map<dynamic, int> checked = map ?? Map<dynamic,int>();
                    if(value){
                      checked[widget.possibilities[index]] = null ;
                    } else {
                      checked.removeWhere((k,v)=> k==widget.possibilities[index]);
                      controllers[widget.possibilities[index]].text='';
                      widget.controller.value = checked;
                    }
                    setState(() {
                      map = checked;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text('${widget.possibilities[index]}'),
                ),
                (
                  map?.keys?.contains(widget.possibilities[index]) ?? false ?
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: controllers[widget.possibilities[index]],
                      onChanged: (value){
                        Map<dynamic, int> newValue = map;
                        if(value==''){
                          newValue.removeWhere((k,v)=>k==widget.possibilities[index]);
                        }else {
                          newValue[widget.possibilities[index]] = int.parse(value);                     
                        }
                        widget.controller.value = newValue;
                      },
                    ),
                  )
                  :
                  Container()
                )
              ],
            ),
          );
        }
      )
    );
  }
}