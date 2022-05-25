
import 'package:flutter/material.dart';
import '/concept/getDescription.dart';

import '/services/database.dart';



class AboutScreen extends StatefulWidget {
  static const String route = '/AboutScreen';

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  Map<String, dynamic> currentUserData;
  Map<String, dynamic> data;
  bool dataPresent = false;
  String description="Other";

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    data = ModalRoute.of(context) == null
        ? null
        : ModalRoute
        .of(context)
        .settings
        .arguments as Map<String, dynamic>;
    if (!dataPresent) {

        Database().getCurrentUserGroup().then((value) {
          currentUserData = value;
          if (data == null || currentUserData == null) {
            return ;
          }
          description = Description(
              otherUserGender: data['Gender'],
              currentUserGender: currentUserData['Gender'],
              currentUserGroup: currentUserData['user_group'],
              otherUserGroup: data['user_group'])
              .getDescription();
          setState(() {});
        }
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text("INTRO App"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: BackButton(
            color: Colors.black,
            onPressed: () {

              Navigator.of(context).pop();
            },
          ),
          actions: [],
        ),
        body: data==null ? Center(child:Text("Error")) :ProfileWidget(data,description));
  }
}

class ProfileWidget extends StatelessWidget {
  String imagePath =
      "https://st2.depositphotos.com/1104517/11965/v/600/depositphotos_119659092-stock-illustration-male-avatar-profile-picture-vector.jpg";
  Map<String,dynamic>data={};
  String description;
  ProfileWidget(this.data,this.description);
  Widget build(BuildContext context) {

    final size = MediaQuery
        .of(context)
        .size;
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Center(child: ImageWidget()),
        SizedBox(
          height: size.height * 0.03,
        ),
        Center(
            child: Text(data["Name"],
                  style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20)),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Center(
          child: Text(data["phoneNo"],
              style: TextStyle(color: Colors.black , fontSize: 15)),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Center(
          child: Text(data["Gender"],
              style: TextStyle(color: Colors.black , fontSize: 15)),
        ),

        SizedBox(
          height: size.height * 0.03,
        ),
         Container(
           decoration: BoxDecoration( color: Colors.white ,border: Border.all(color:Colors.black)),
           child: ListTile(
               leading: Icon(Icons.description),
                title:Text(description)),
         ),

        SizedBox(
          height: size.height * 0.1,
        ),

      ],
    );
  }

  Widget ImageWidget() {
    final image = NetworkImage(imagePath);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          height: 120,
          width: 120,
          child: InkWell(onTap: (){print("yes");},),
        ),
      ),
    );
  }


}
