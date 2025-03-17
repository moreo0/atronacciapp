import 'package:flutter/cupertino.dart';


class ValidatorHelper{
  static bool validateForm(GlobalKey<FormState> formKey){
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      return true;
    }
    return false;
  }

  static String? field({
    required String title,
    required String value,
    // required String regex,
  }){
    if(value.isEmpty){
      return 'is field cannot be empty';
    }
    return null;
  }
}