import 'package:flutter/material.dart';

import 'Classes.dart' as prefix0;
import 'SectionWidget.dart';

class Form extends StatefulWidget {

  final prefix0.Form form;
  /// Color used for the progress bar
  final Color progressColor;
  /// Color used form the form (accents & bottom bar)
  final Color primaryColor;
  /// BoxDecoration for the question
  final BoxDecoration decoration;
  /// Padding between [decoration] and question content
  final EdgeInsets innerPadding;
  /// Padding between question and other elements
  final EdgeInsets outterPadding;
  /// Render boolean questions with switch instead of a checkbox
  final bool useSwitch;
  /// Hide bottom bar
  final bool hideBar;
  /// Show the title of the form
  final bool showFormTitle;
  /// Show the titles of the sections
  final bool showSectionsTitles;
  /// Function called when the last section have been validated
  /// (Used if [hideBar]=false)
  final Function(prefix0.Form) onValidation;
  /// Function used to get localized string with key
  final Function(String) translator;

  Form({
    Key key,
    @required this.form,
    this.progressColor,
    this.primaryColor,
    this.decoration,
    this.innerPadding,
    this.outterPadding,
    this.useSwitch,
    this.hideBar,
    this.showFormTitle,
    this.showSectionsTitles,
    this.onValidation,
    this.translator
  }): super(key: key);

  FormState createState() => FormState();
}

class FormState extends State<Form> {

  int index=0;

  List<GlobalKey<SectionWidgetState>> sectionsKeys = <GlobalKey<SectionWidgetState>>[];

  @override
  void initState() {
    super.initState();
    // Creating key for each section
    widget.form.sections.forEach((_)=> sectionsKeys.add(GlobalKey<SectionWidgetState>()));
  }
  
  bool validate(){
    for(final section in sectionsKeys){
      try{
        if(section.currentState.validate()==false) return false;
      }catch(e){}
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        accentColor: widget.primaryColor,
      ),
      child: Column(
        children: <Widget>[
          ( widget.showFormTitle ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.form.name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22
              ),
            ),
          ): Container() ),
          Expanded(
            child: SectionWidget(
              widget.form.sections[index],
              key: sectionsKeys[index],
              showSectionTitle: widget.showSectionsTitles,
              decoration: widget.decoration,
              useSwitch: widget.useSwitch,
              innerPadding: widget.innerPadding,
              outterPadding: widget.outterPadding,
              translator: widget.translator
            ),
          ),
          ( ! widget.hideBar ?
          Material(
            elevation: 5,
            color: widget.primaryColor,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width*0.5,
                          height: 10,
                          decoration: BoxDecoration(
                            color: widget.progressColor.withAlpha(75),
                            borderRadius: BorderRadius.circular(45)
                          ),
                        ),
                      ], 
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 500),
                      left: 0,
                      right: MediaQuery.of(context).size.width*0.5*(1-((index+1)/widget.form.sections.length)),
                      child: Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: widget.progressColor,
                          borderRadius: BorderRadius.circular(45)
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ( index > 0 ?
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: widget.progressColor),
                        onPressed: (){
                          setState(() {
                            if(sectionsKeys[index].currentState.validate()){
                              index--;
                            }
                          });
                        },
                      )
                    :
                      Container()
                    ),
                    Expanded(child: Container(),),           
                    IconButton(
                      icon: Icon(
                        (index == widget.form.sections.length-1 ? Icons.check : Icons.arrow_forward), 
                        color: widget.progressColor,),
                      onPressed: (){
                        // Validate section
                        if(index < widget.form.sections.length-1){
                          setState(() {
                            if(sectionsKeys[index].currentState.validate()){
                              index++;
                            }
                          });
                        } else{
                          if(sectionsKeys[index].currentState.validate()){
                            widget.onValidation(widget.form);
                          }
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          )
          :
          Container()
          ),
        ],
      ),
    );
  }
}