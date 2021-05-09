import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:votefromhome/loginScreen.dart';

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
RoundedLoadingButtonController btnController;

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
    print(phrase);
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
          SizedBox(height: 20),
          Material(
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.antiAlias,
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:
                    enteredPhrase == phrase ? Color(0xFFF0055a3) : Colors.grey,
              ),
              width: 200,
              height: 40,
              child: InkWell(
                  onTap: enteredPhrase == phrase
                      ? () {
                          Alert(
                              title: '',
                              onWillPopActive: true,
                              buttons: [
                                
                              ],
                              context: context,
                              content: FutureBuilder(
                                  future: Future.delayed(Duration(seconds: 5)),
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      case ConnectionState.done:
                                        return Center(
                                            child: Column(
                                          children: [
                                            Lottie.asset(
                                                'assets/images/done.json'),
                                            SizedBox(height: 5),
                                            Text('Successfully voted'),
                                            ElevatedButton(
                                    child: Text('Close'),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    })
                                          ],
                                        ));
                                      default:
                                        return Text('OOps');
                                    }
                                  })).show();
                        }
                      : null,
                  child: Center(
                      child: Text("Vote",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white)))),
            ),
          )
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
              onChanged: (val) {
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
