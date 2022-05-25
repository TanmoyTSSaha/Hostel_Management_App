

import 'package:flutter/material.dart';
import '../widget/LoginCard.dart';






class LoginScreen extends StatelessWidget {
  static const route = '/LoginScreen';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            height:deviceSize.height*0.3,
              width: deviceSize.width,
              child: Image.asset("assets/images/title_logo.jpeg")),

          LoginCard()
        ],
      ),
    );
  }

}
