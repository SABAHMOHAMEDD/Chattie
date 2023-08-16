import 'package:flutter/material.dart';

import '../../../core/constance/constants.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = "SettingsScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                color: KprimaryColor.withOpacity(0.9),
              ),
            ),
            Text(
              'Sign Out',
              style: TextStyle(color: KprimaryColor.withOpacity(.9)),
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
