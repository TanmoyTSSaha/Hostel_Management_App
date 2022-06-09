import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hostel_management_app/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController wardenIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;
  bool isTapped = true;
  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenHeight = MediaQuery.of(context).size.height; //780
    screenWidth = MediaQuery.of(context).size.width; //360
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            isKeyboardVisible
                ? SizedBox(height: screenHeight / 7)
                : SizedBox(
                    width: screenWidth,
                    height: screenHeight / 2.25,
                    child: Image.asset(
                      "assets/images/5293.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
            Text(
              "Login",
              style: TextStyle(
                fontSize: screenWidth / 7.2,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight / 23),
              child: Column(
                children: [
                  TextFormField(
                    controller: wardenIdController,
                    decoration: const InputDecoration(
                      icon: Icon(CupertinoIcons.person),
                      labelText: "Warden ID",
                      hintText: "Enter Warden ID",
                    ),
                  ),
                  SizedBox(height: screenHeight / 35),
                  TextFormField(
                    controller: passwordController,
                    obscureText: isTapped,
                    decoration: InputDecoration(
                      icon: const Icon(CupertinoIcons.lock),
                      labelText: "Password",
                      hintText: "Enter Password",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isTapped = !isTapped;
                          });
                        },
                        child: isTapped == true
                            ? const Icon(
                                CupertinoIcons.eye,
                              )
                            : const Icon(CupertinoIcons.eye_slash),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight / 25),
                  ElevatedButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      String id = wardenIdController.text.trim();
                      String password = passwordController.text.trim();

                      if (id.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Warden ID is Empty"),
                          ),
                        );
                      } else if (password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Password is Empty"),
                          ),
                        );
                      } else {
                        QuerySnapshot snap = await FirebaseFirestore.instance
                            .collection("Warden")
                            .where("id", isEqualTo: id)
                            .get();

                        try {
                          if (password == snap.docs[0]['password']) {
                            // ignore: use_build_context_synchronously
                            sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences
                                .setString("WardenId", id)
                                .then((_) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Password is not correct!"),
                              ),
                            );
                          }
                        } catch (e) {
                          String error = "";
                          if (e.toString() ==
                              "RangeError (index): Invalid value: Valid value range is empty: 0") {
                            setState(() {
                              error = "Warden ID doesn't exist";
                            });
                          } else {
                            setState(() {
                              error = "Error occurred!";
                            });
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(screenHeight / 2.78, screenWidth / 7.2)),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: screenWidth / 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
