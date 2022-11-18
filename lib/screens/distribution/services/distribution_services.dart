import 'dart:convert';

import 'package:fast_fueler_mobile_station/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';

class DistributionServices {
  void refill(
      {required BuildContext context,
      required registrationNo,
      required filledAmount,
      required stationRegNo,
      required fuelType,
      required queueID}) async {
    try {

      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.post(Uri.parse('$uri/station/refill'),
          body: jsonEncode({
            'registrationNo': registrationNo,
            'filledAmount': filledAmount,
            'stationRegNo': stationRegNo,
            'fuelType': fuelType,
            'queueID': queueID,
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
