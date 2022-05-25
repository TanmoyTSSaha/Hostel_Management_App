
import '/services/authentication.dart';
import '/services/database.dart';
import '/widget/contactList.dart';


import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  static const String route="/homeScreen";


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();


    //contacts==null ? print("0"):print(contacts!.length);
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if(mounted){
      super.setState(fn);
    }

  }




  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: Center(child: Text("INTRO App")),
            backgroundColor: Theme.of(context).primaryColor,
            actions: [
              IconButton(onPressed:()async{ Authentication().signOut(context);}, icon: Icon(Icons.logout))
            ]
        ),
        body:Center(
              child:  ContactList(),
        ),


    );
  }
}
