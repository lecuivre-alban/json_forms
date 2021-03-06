library json_forms;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Classes.dart' as prefix1;
import 'FormProvider.dart';
import 'FormWidget.dart' as prefix0;

class JsonForm {

  /// [progressColor] : Color used for the progress bar
  /// 
  /// [primaryColor] : Color used form the form (accents & bottom bar)
  /// 
  /// [decoration] : BoxDecoration for the question
  /// 
  /// [innerPadding] : Padding between [decoration] and question content
  /// 
  /// [outterPadding] : Padding between question and other elements
  /// 
  /// [useSwitch] : Render boolean questions with switch instead of a checkbox
  /// 
  /// [hideBar] Hide bottom bar (**DO NOT** SET TO **true** if you have multiples sections)
  /// 
  /// [showFormTitle] Show the title of the form
  /// 
  /// [showSectionsTitles] Show the titles of the sections
  /// 
  /// [onValidation] Function called when the last section have been validated
  /// (Used if [hideBar]=false)
  static Widget fromJson(
    Map<String, dynamic> json,
    {
      Color progressColor=Colors.white,
      Color primaryColor=Colors.blue,
      BoxDecoration decoration=const BoxDecoration(),
      EdgeInsets innerPadding= EdgeInsets.zero,
      EdgeInsets outterPadding=const EdgeInsets.all(8),
      bool useSwitch=false,
      bool hideBar=false,
      bool showFormTitle=true,
      bool showSectionsNames=true,
      GlobalKey<prefix0.FormState> key,
      Function(prefix1.Form) onValidation,
      Function(String) translator,
      bool readOnly=false
    }
  ){
    return ChangeNotifierProvider<FormProvider>(
      builder: (_){
        final provider = FormProvider();
        provider.init(json, readOnly);
        return provider;
      },
      child: prefix0.Form(
        key: key,
        progressColor: progressColor,
        primaryColor: primaryColor,
        decoration: decoration,
        innerPadding: innerPadding,
        outterPadding: outterPadding,
        useSwitch: useSwitch,
        hideBar: hideBar,
        showFormTitle: showFormTitle,
        showSectionsTitles: showSectionsNames,
        onValidation: onValidation,
        translator: translator
      )
    );
  }
}