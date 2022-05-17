// ignore_for_file: must_be_immutable

import 'app_routers.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(BreakingBad());
}

class BreakingBad extends StatelessWidget {
  BreakingBad({
    Key? key,
  }) : super(key: key);
  AppRouter appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: ((context, orientation, deviceType) => MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.generateRoute,
          )),
    );
  }
}
