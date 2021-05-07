import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmSeed extends StatefulWidget {
  final List<String> phrases;

  const ConfirmSeed({Key key, @required this.phrases}) : super(key: key);
  @override
  _ConfirmSeedState createState() => _ConfirmSeedState();
}

class _ConfirmSeedState extends State<ConfirmSeed> {
  List<String> checkStr = [];
  List<Map<String, dynamic>> chipProps = [];
  List<Widget> tappedChips = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chipProps = List.generate(widget.phrases.length,
        (index) => {"label": widget.phrases[index], "isSelected": false});
  }

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
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text('Verify your seed phrase',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black87)),
                  SizedBox(height: 15),
                  Text(
                    'Choose each word in the correct order',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF1D1B1D),
                          borderRadius: BorderRadius.circular(10)),
                      height: 220,
                      width: 375,
                      child: tappedChips.length > 0
                          ? Wrap(
                              spacing: 0,
                              runSpacing: 0,
                              children: tappedChips,
                            )
                          : Container(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(
                      spacing: 0.0, // gap between adjacent chips
                      runSpacing: 0.0, // gap between lines
                      children: List.generate(
                          widget.phrases.length,
                          (index) => chipDesign(widget.phrases[index], index,
                              Color(0xFFF383638)))),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget chipDesign(String label, int index, Color color) => GestureDetector(
        onTap: () {
          setState(() {
            if (!chipProps[index]["isSelected"]) {
              chipProps[index]["isSelected"] = true;
              checkStr.add(label);
              print(checkStr);
              tappedChips.add(Container(
                child: Chip(
                  label: Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: color,
                  elevation: 4,
                  shadowColor: Colors.grey[50],
                  padding: EdgeInsets.all(4),
                ),
                margin: EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
              ));
            }
          });
        },
        child: Container(
          child: Chip(
            label: Text(
              label,
              style: TextStyle(
                color: chipProps[index]["isSelected"]
                    ? Color(0xFFF383638)
                    : Colors.white,
              ),
            ),
            backgroundColor: color,
            elevation: 4,
            shadowColor: Colors.grey[50],
            padding: EdgeInsets.all(4),
          ),
          margin: EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
        ),
      );
}
