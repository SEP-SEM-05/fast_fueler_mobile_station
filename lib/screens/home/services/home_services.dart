// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:fast_fueler_mobile_station/models/active_queue.dart';
import 'package:fast_fueler_mobile_station/screens/auth/signin_screen.dart';
import 'package:fast_fueler_mobile_station/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        SigninScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, "Logout failed. Try Again");
    }
  }

  Future<List<ActiveQueue>> fetchAllActiveQueues(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ActiveQueue> activeQueues = [];
    try {
      http.Response res = await http.get(
          Uri.parse(
              '$uri/station/get-activequeues/${userProvider.user.registrationNo}'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            activeQueues.add(
              ActiveQueue.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, "Unable to fetch the active Queues");
    }
    return activeQueues;
  }
}
