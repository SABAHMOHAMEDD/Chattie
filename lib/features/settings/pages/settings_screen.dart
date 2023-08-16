import 'package:flutter/material.dart';

import '../../../core/constance/constants.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = "SettingsScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KprimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                SignOut(context);
              },
              icon: Icon(
                Icons.exit_to_app,
                size: 45,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            Text(
              'Sign Out',
              style: TextStyle(color: Colors.white.withOpacity(.9)),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
