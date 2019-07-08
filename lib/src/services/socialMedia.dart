import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:flutter_jaring_ummat/src/services/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_jaring_ummat/src/bloc/registerBloc.dart' as registerBloc;

import 'package:flutter_jaring_ummat/src/models/UserDetails.dart';

final FacebookLogin facebookSignIn = new FacebookLogin();
SharedPreferences _preferences;

UserDetailsService registerData = new UserDetailsService();

Future<Null> _loginFacebook(BuildContext context) async {
  _preferences = await SharedPreferences.getInstance();
  final FacebookLoginResult result =
      await facebookSignIn.logInWithReadPermissions(
    ['email'],
  );

  switch (result.status) {
    case FacebookLoginStatus.loggedIn:
      final FacebookAccessToken accessToken = result.accessToken;
      print(
        '''
         Logged in!
         *******************************************************
         Token:                ${accessToken.token}
         User id:              ${accessToken.userId}
         Expires:              ${accessToken.expires}
         Permissions:          ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}

         ''',
      );

      var graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${result.accessToken.token}',
      );
      var profile = json.decode(graphResponse.body);
      FacebookUserDetails fbUser = FacebookUserDetails.fromJson(profile);

      await registerData.userDetails(fbUser.email).then((response) {
        if (response.statusCode == 200) {
          print('Data Sudah Terdaftar !');
        } else if (response.statusCode == 204) {
          print('Register Data with Facebook');
          final postData = PostRegistration(
            contact: 'Not Found',
            email: fbUser.email,
            fullname: fbUser.name,
            password: 'password',
            tipe_user: 'Muzakki',
            username: fbUser.email
          );

          registerBloc.bloc.saveUser(postData);
        }
      });
      // _preferences.setString(FULLNAME_KEY, ;
      // _preferences.setString(CONTACT_KEY, 'Not Found');
      // _preferences.setString(EMAIL_KEY, userDetails.email);
      // _preferences.setString(ACCESS_TOKEN_KEY, accessToken.token);
      // _preferences.setString(USER_ID_KEY, userDetails.id);
      // _preferences.setString(
      //     PROFILE_FACEBOOK_KEY, profile['picture']['data']['url']);

      print(_preferences.getString(PROFILE_FACEBOOK_KEY));
      break;
    case FacebookLoginStatus.cancelledByUser:
      print('Login cancelled by the user.');
      break;
    case FacebookLoginStatus.error:
      print('Something went wrong with the login process.\n'
          'Here\'s the error Facebook gave us: ${result.errorMessage}');
      break;
  }
}

Future<Null> registerUser(PostRegistration data) async {
  
}
