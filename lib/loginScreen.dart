import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:votefromhome/dummy.dart';
import 'package:votefromhome/models/user.dart';
import 'package:votefromhome/providers/userProvider.dart';

import 'homeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final regForm = GlobalKey<FormState>();
  String username = "", password = "", auth = "Sign In";
  final RoundedLoadingButtonController _authBtnController =
      new RoundedLoadingButtonController();
  List<String> textFields = ["Username", "Password"];
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFF0059a4),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png', height: 100),
                  auth == "Sign Up"
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Create an account to get started with Vote From Home",
                              style: TextStyle(fontSize: 24)),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Sign In to get started with Vote From Home",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                  Container(
                      width: 300,
                      height: 300,
                      child: Lottie.asset("assets/images/vote.json")),
                  Form(
                    key: regForm,
                    child: Column(
                      children: List.generate(
                          2,
                          (int index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: buildTextFormField(textFields[index]),
                              )),
                    ),
                  ),
                  RoundedLoadingButton(
                      controller: _authBtnController,
                      color: Colors.white,
                      onPressed: () async {
                        try {
                          var response = await Dio().post(
                              "https://votefromhome.herokuapp.com/api/${auth == "Sign Up" ? "signup" : "signin"}",
                              data: {
                                "username": username,
                                "password": password
                              });
                          User _user = User.fromMap(username, response.data);
                          userProvider.currentUser = _user;
                          print("userprovider set - " +
                              userProvider.currentUser.username);
                          _authBtnController.success();
                          _authBtnController.reset();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => HomeScreen()));
                        } catch (e) {
                          _authBtnController.error();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Something went wrong!")));
                          Timer(Duration(seconds: 2), () {
                            _authBtnController.reset();
                          });
                        }
                      },
                      child: Text(
                        auth.toUpperCase(),
                        style:
                            TextStyle(color: Color(0xFF0059a4), fontSize: 20),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (auth == "Sign Up")
                            auth = "Sign In";
                          else
                            auth = "Sign Up";
                          username = password = "";
                        });
                      },
                      child: auth == "Sign Up"
                          ? Text("Already have an account? Sign In!",
                              style: TextStyle(color: Colors.white))
                          : Text(
                              "Don't have an account? Sign Up",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget buildTextFormField(String label) {
    return Center(
      child: Container(
          width: MediaQuery.of(context).size.width * .75,
          height: 54,
          decoration: BoxDecoration(
              color: Colors.white,
              // border: Border.all(color: Color(0xFFF313039), width: 3),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (val) {
                  setState(() {
                    if (label == "Username")
                      username = val;
                    else
                      password = val;
                  });
                },
                style: TextStyle(color: Color(0xFFF191720)),
                cursorColor: Colors.black,
                obscureText: label == "Password",
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    border: InputBorder.none,
                    hintText: label,
                    hintStyle: TextStyle(
                      color: Color(0xFFF7c7d89),
                    )),
              ))),
    );
  }
}
