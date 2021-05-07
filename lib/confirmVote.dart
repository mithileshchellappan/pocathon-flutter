import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmVote extends StatefulWidget {
  final String canName, partyName, partyPhoto, canPhoto;

  const ConfirmVote(
      {Key key,
      @required this.canName,
      @required this.partyName,
      @required this.partyPhoto,
      @required this.canPhoto})
      : super(key: key);
  @override
  _ConfirmVoteState createState() => _ConfirmVoteState();
}
String enteredPhrase = '';
String phrase;
TextEditingController controller;

class _ConfirmVoteState extends State<ConfirmVote> {
  @override
  void initState() {
    super.initState();
    getPhrase();
  }

  Future<String> getPhrase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ph = prefs.getString('phrase');
    setState(() {
      phrase = ph;
    });
  }

  var myStramBuilder;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: body(context, phrase),
    ));
  }

  Widget body(BuildContext context, String phrase) {
    return SingleChildScrollView(
          child: Column(
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
          SizedBox(
            height: 30,
          ),

          Text('You are voting for:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Center(
              child: Text(
                  '${widget.canName.toUpperCase()}\n \t \t \t \t${widget.partyName.toUpperCase()}',
                  style: TextStyle(fontSize: 40))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                    widget.canPhoto,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                    widget.partyPhoto,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Text('Enter your seed phrase below to confirm your vote',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 37),
          buildTextField(),
          Container(height:10,width:10,color:phrase==enteredPhrase?Colors.red:Colors.blue)
        ],
      ),
    );
  }

  Widget buildTextField() {
    return Center(
      child: Container(
          width: MediaQuery.of(context).size.width * .75,
          // height: 54,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFFF313039), width: 3),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              maxLines: 2,
              onChanged: (val){
                setState(() {
                  enteredPhrase = val;
                });
              },
              initialValue: '',
              controller: controller,
              // keyboardType: type,
              style: TextStyle(color: Color(0xFFF191720)),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  border: InputBorder.none,
                  hintText: 'Enter your phrase here',
                  hintStyle: TextStyle(
                    color: Color(0xFFF7c7d89),
                  )),
            ),
          )),
    );
  }
}
