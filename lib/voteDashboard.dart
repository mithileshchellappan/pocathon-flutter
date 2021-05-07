import 'package:flutter/material.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:google_fonts/google_fonts.dart';
import 'confirmSeed.dart';
class VoteDashboard extends StatefulWidget {
  @override
  _VoteDashboardState createState() => _VoteDashboardState();
}
String phrase;
List<String> seedPhrases = [];
String warningMess = 'NOTE: This is the only way to access your vote.This phrase cannot be recovered by any means and it is only for you.Please note it down in a secured place';
class _VoteDashboardState extends State<VoteDashboard> {
  @override
  void initState() {
    phrase = bip39.generateMnemonic();
    seedPhrases=phrase.split(' ');
    print(seedPhrases);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
        body:Column(
          children: [Container(
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
            Expanded(child: 
              Container(
                child: Column(children: [
                  SizedBox(height:40),
                  Text('Write down your seed phrase',style:TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.black87)),
                  SizedBox(height:15),
                  Text('You\'ll confirm this sequence on the next screen.',style: TextStyle(fontSize:16,fontWeight: FontWeight.w400),),
                  SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(color:Color(0xFF1D1B1D),borderRadius: BorderRadius.circular(10)),
                      height:200,
                      width:375,
                      
                      child: Center(child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(phrase,style:GoogleFonts.firaCode(color: Colors.white,fontSize: 25)),
                      )),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color:Colors.red.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color:Colors.red)

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(warningMess,style:GoogleFonts.firaMono(color: Colors.red,fontWeight:FontWeight.bold)),
                      ),
                    ),
                  ),
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
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ConfirmSeed(phrases: seedPhrases,phrase:phrase)));
                                  },
                                  child: Center(
                                      child: Text("Continue",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Colors.white)))),
                            ),
                          )

                ],),
              )
            )
            
            ],
        )
        
        
      ),
    );
  }
}