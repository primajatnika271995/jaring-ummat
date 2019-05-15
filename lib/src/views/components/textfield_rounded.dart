import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/views/components/EnsureVisibleWhenFocused.dart';

Widget TextFieldRounded({ BuildContext context, hintText: String, isSecureText: false, keyboardType, controller, textInputAction, focusNode, focusNode2, onFieldSubmitted}) {
  return Padding(
    padding: EdgeInsets.only(top: 5),
    
    child: Container(
      child: TextFormField(
        controller: controller,
        textInputAction: textInputAction,
        focusNode: focusNode,
         onFieldSubmitted: onFieldSubmitted,
         keyboardType: keyboardType,
        obscureText: isSecureText,
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none, 
          hintText: hintText
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        color: Colors.white,
      ),
      padding: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
    )
  );
  
}