import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotVerified extends StatefulWidget {
  @override
  _NotVerifiedState createState() => _NotVerifiedState();
}

class _NotVerifiedState extends State<NotVerified> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
            body: Center(
              child: Container(
          child:Column(
              children:[
                Lottie.asset('assets/images/waiting.json'),
                Text('Please wait for our issuer to verify your documents'),
                SizedBox(height:70),
                Material(
                            borderRadius: BorderRadius.circular(20),
                            clipBehavior: Clip.antiAlias,
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFFF0055a3),
                              ),
                              width: 200,
                              height: 40,
                              child: InkWell(
                                  onTap: () {},
                                  child: Center(
                                      child: Text("Chat with our bot",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Colors.white)))),
                            ),
                          )
              ]
          )
        ),
            ),
      ),
    );
  }
}