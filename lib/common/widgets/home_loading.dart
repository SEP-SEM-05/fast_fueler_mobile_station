import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeLoading extends StatelessWidget {
  const HomeLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: SpinKitFadingCircle(
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? const Color.fromARGB(255, 255, 17, 0) : const Color.fromARGB(255, 0, 255, 8),
            ),
          );
        },
      ),
    ));
  }
}
