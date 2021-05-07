import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmSeed extends StatefulWidget {
  final List<String> phrases;

  const ConfirmSeed({Key key, @required this.phrases}) : super(key: key);
  @override
  _ConfirmSeedState createState() => _ConfirmSeedState();
}
List<String> checkStr = [''];
class _ConfirmSeedState extends State<ConfirmSeed> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            color: Color(0xFF0059a4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/logo.png'),
                    )),
              ],
            ),
          ),
          Expanded(
            child: 
              Container(
                child: Column(
                  children: [
                    SizedBox(height:10),
                    Text('Verify your seed phrase',style:TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.black87)),
                    SizedBox(height:15),
                  Text('Choose each word in the correct order',style: TextStyle(fontSize:16,fontWeight: FontWeight.w500),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF1D1B1D),
                            borderRadius: BorderRadius.circular(10)),
                        height: 200,
                        width: 375,
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('wow',
                              style: GoogleFonts.firaCode(
                                  color: Colors.white, fontSize: 25)),
                        )),
                      ),
                    ),
                    SizedBox(height: 10,),
                    
                    
                  ],
                ),
              ),
            
          ),
        ],
      )),
    );
  }
}
