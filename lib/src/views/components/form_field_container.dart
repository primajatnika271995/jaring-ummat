import 'package:flutter/material.dart';

//  WIDGET FORM FIELD FULLNAME AND EMAIL

Widget formField(BuildContext context, String hintText, var icon, TextEditingController ctrl) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0), color: Colors.white),
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.5),
    child: TextField(
      controller: ctrl,
      decoration: InputDecoration(
          contentPadding:
          EdgeInsets.only(top: 10.0, bottom: 10.0, left: -8.0),
          // errorText: _validate ? 'Form tidak boleh Kosong' : null,
          icon: Icon(icon, size: 15.0),
          border: InputBorder.none,
          hintText: hintText),
      style: TextStyle(fontSize: 12.0),
    ),
  );
}

//  WIDGET CUSTOM FORM FIELD CONTACT

Widget formFieldContact(BuildContext context, String hintText, var icon, TextEditingController ctrl) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white),
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.5),
    child: TextField(
      controller: ctrl,
      keyboardType: TextInputType.numberWithOptions(),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
              top: 10.0, bottom: 10.0, left: -8.0),
          icon: Container(
            width: 51.0,
            padding: EdgeInsets.all(0.0),
            child: Row(
              children: <Widget>[
                Icon(
                  icon,
                  size: 15.0,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  '+62 | ',
                  style: TextStyle(fontSize: 11),
                )
              ],
            ),
          ),
          border: InputBorder.none,
          hintText: hintText),
      style: TextStyle(fontSize: 12.0),
    ),
  );
}

Widget formFieldPassword(BuildContext context, String hintText, var icon, TextEditingController ctrl, Function onTap, bool _obscureTextPassword) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white),
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.5),
    child: Stack(
      alignment: const Alignment(1.0, 0.0),
      children: <Widget>[
        TextField(
          controller: ctrl,
          obscureText: _obscureTextPassword,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                  left: -8.0),
              icon: Icon(icon, size: 15.0),
              border: InputBorder.none,
              hintText: hintText),
          style: TextStyle(fontSize: 12.0),
        ),
        Container(
          padding: EdgeInsets.only(right: 15.0),
          child: GestureDetector(
            onTap: onTap,
            child: Icon(
              _obscureTextPassword
                  ? Icons.visibility_off
                  : Icons.visibility,
              size: 20.0,
            ),
          ),
        )
      ],
    ),
  );
}