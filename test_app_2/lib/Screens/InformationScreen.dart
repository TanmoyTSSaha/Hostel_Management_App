
import 'package:flutter/material.dart';


import '../widget/InformationCard.dart';

class InformationScreen extends StatefulWidget {
  @override
  static const String route = '/InformationPageRoute';

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

enum Gender { Male, Female, Other, NotSelected }

class _InformationScreenState extends State<InformationScreen> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if(mounted){
      super.setState(fn);
    }

  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("INTRO APP"),
          ),
          actions: [

          ],
        ),
        body: SingleChildScrollView(
          
          child:Column(
            
            children: [

              
              InformationCard(),
            ],
          ),
        ));
  }
}
