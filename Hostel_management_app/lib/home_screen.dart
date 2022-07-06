import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hostel_management_app/attendence_screen.dart';
import 'package:hostel_management_app/form_screen.dart';
import 'package:hostel_management_app/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentNavBarIndex = 0;

  List<IconData> navigationBarIcons = [
    FontAwesomeIcons.calendarDays,
    FontAwesomeIcons.check,
    FontAwesomeIcons.user,
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: IndexedStack(
        index: currentNavBarIndex,
        children: [
          FormScreen(),
          AttendenceScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        height: screenHeight / 11.142,
        // margin: EdgeInsets.only(
        //   left: screenHeight / 65,
        //   right: screenHeight / 65,
        //   bottom: screenHeight / 32.5,
        // ),
        decoration: const BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.all(
          //   Radius.circular(screenHeight / 19.5),

          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black26,
          //     blurRadius: screenWidth / 36,
          //     offset: Offset(screenWidth / 180, screenWidth / 180),
          //   )
          // ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(screenWidth / 19.5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int i = 0; i < navigationBarIcons.length; i++) ...<Expanded>{
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentNavBarIndex = i;
                      });
                    },
                    child: Center(
                      child: Icon(
                        navigationBarIcons[i],
                        size: currentNavBarIndex == i
                            ? screenHeight / 26
                            : screenWidth / 18,
                        color: currentNavBarIndex == i
                            ? Colors.blue
                            : Colors.blueGrey[900],
                      ),
                    ),
                  ),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
