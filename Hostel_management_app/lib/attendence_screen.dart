import 'package:flutter/material.dart';

class AttendenceScreen extends StatefulWidget {
  const AttendenceScreen({Key? key}) : super(key: key);

  @override
  State<AttendenceScreen> createState() => _AttendenceScreenState();
}

class _AttendenceScreenState extends State<AttendenceScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool? studentAttendance;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Attendence Sheet",
          style: TextStyle(fontSize: screenWidth / 12, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 40,
            right: 10,
            left: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: screenWidth / 18,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: screenWidth / 30),
                          height: screenHeight / 11.142,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(screenWidth / 36),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: screenWidth / 36,
                                  offset: Offset(
                                      screenWidth / 180, screenWidth / 180),
                                )
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: screenHeight / 11.142,
                                    width: screenHeight / 11.142,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          screenWidth / 36),
                                      child: Image.asset(
                                        "assets/images/student1.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: screenWidth / 36),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Student ${index + 1}",
                                        style: TextStyle(
                                          fontSize: screenWidth / 18,
                                        ),
                                      ),
                                      Text(
                                        "Phone No. 1234567890",
                                        style: TextStyle(
                                          fontSize: screenWidth / 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  AnimatedContainer(
                                    height: screenWidth / 9,
                                    width: screenWidth / 9,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: studentAttendance == false
                                            ? Colors.red[800]
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(5)),
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.bounceIn,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          studentAttendance = false;
                                          print("index is ${index}");
                                          print("false");
                                        });
                                      },
                                      icon: Icon(
                                        Icons.close_rounded,
                                        color: studentAttendance == false
                                            ? Colors.white
                                            : Colors.black,
                                        size: screenWidth / 18,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: screenWidth / 36),
                                  AnimatedContainer(
                                    height: screenWidth / 9,
                                    width: screenWidth / 9,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: studentAttendance == true
                                            ? Colors.green[800]
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(5)),
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.bounceIn,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          studentAttendance = true;
                                          print("index is ${index}");
                                          print("true");
                                        });
                                      },
                                      icon: Icon(
                                        Icons.check_rounded,
                                        color: studentAttendance == true
                                            ? Colors.white
                                            : Colors.black,
                                        size: screenWidth / 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: getColor(
                                      Colors.white, Colors.green.shade800),
                                  foregroundColor: getColor(
                                      Colors.green.shade800, Colors.white),
                                  side: getBorder(
                                      Colors.black, Colors.green.shade800),
                                ),
                                onPressed: () {
                                  setState(() {
                                    studentAttendance = true;
                                    print(studentAttendance);
                                  });
                                },
                                child: Icon(
                                  Icons.check_rounded,
                                  size: screenWidth / 18,
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth / 36),
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: getColor(
                                    studentAttendance == false
                                        ? Colors.red.shade800
                                        : Colors.white,
                                    studentAttendance == false
                                        ? Colors.white
                                        : Colors.red.shade800,
                                  ),
                                  foregroundColor: getColor(
                                    studentAttendance == false
                                        ? Colors.white
                                        : Colors.red.shade800,
                                    studentAttendance == false
                                        ? Colors.red.shade800
                                        : Colors.white,
                                  ),
                                  side: getBorder(
                                      Colors.black, Colors.red.shade800),
                                ),
                                onPressed: () {
                                  setState(() {
                                    studentAttendance = false;
                                    print(studentAttendance);
                                  });
                                },
                                child: Icon(
                                  Icons.close_rounded,
                                  size: screenWidth / 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  MaterialStateProperty<Color> getColor(Color color, Color colorPressed) {
    // ignore: prefer_function_declarations_over_variables
    final getColor = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    };

    return MaterialStateProperty.resolveWith(getColor);
  }

  MaterialStateProperty<BorderSide> getBorder(Color color, Color colorPressed) {
    // ignore: prefer_function_declarations_over_variables
    final getBorder = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return BorderSide(color: color, width: 1);
      } else {
        return BorderSide(color: colorPressed, width: 1);
      }
    };

    return MaterialStateProperty.resolveWith(getBorder);
  }
}
