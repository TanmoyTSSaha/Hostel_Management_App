import 'package:flutter/material.dart';
import './HomeScreen.dart';

class Welcome extends StatelessWidget {

  static const String route='/ShowMarks';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Center(child:Text("INTRO"))),
      body:
      Container(

        padding: EdgeInsets.symmetric(vertical: 25,horizontal: 25),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("WHAT U LOOKING FOR HERE :- \n" +
        "1. This is a personality based social media app where you can read description about personality of people w.r.t. you. \n"
        "2. The purpose of this app is to make you know about like minded people just like u.\n"
        "3. And the one who matches your frequency and vibe.\n"),
            ElevatedButton(onPressed: (){

               Navigator.of(context).pushReplacementNamed(HomeScreen.route);
            }, child: Text("I GOT IT"))
          ],
        )

        ),

    );
  }
}
