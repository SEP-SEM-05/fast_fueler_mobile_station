import 'dart:convert';

import 'package:fast_fueler_mobile_station/common/widgets/bottom_bar.dart';
import 'package:fast_fueler_mobile_station/constants/error_handling.dart';
import 'package:fast_fueler_mobile_station/constants/global_variables.dart';
import 'package:fast_fueler_mobile_station/constants/utils.dart';
import 'package:fast_fueler_mobile_station/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // sign in user
  void signInUser({
    required BuildContext context,
    required String registrationNo,
    required String password,
  }) async {
    try {
      print("start");
      http.Response res = await http.post(
        Uri.parse('$uri/mobileauth/api/signin'),
        body: jsonEncode({
          'registrationNo': registrationNo,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("resp");
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get user data
  Future<bool> getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/mobileauth/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/mobileauth'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );
        print(userRes.body);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
      print("load done");
      return true;
    } catch (e) {
      showSnackBar(context, e.toString());
      return true;
    }
  }
}
