import 'dart:io';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:votefromhome/helpers/db.dart';
import 'package:votefromhome/notVerified.dart';

import 'providers/userProvider.dart';

class RegisterVC extends StatefulWidget {
  @override
  _RegisterVCState createState() => _RegisterVCState();
}

RoundedLoadingButtonController controller = RoundedLoadingButtonController();

class _RegisterVCState extends State<RegisterVC> {
  File _image, _image2;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF0059a4),
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                  width: 120, child: Image.asset('assets/images/logo.png')),
              Text('Enter details to submit to verifier'),
            ],
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Color(0xFF0059a4),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              SizedBox(height: 10),
              buildTextField('Enter your name', TextInputType.name),
              SizedBox(height: 13),
              buildTextField('Enter your Aadhar number', TextInputType.number),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => openSheet(isAfter: true),
                child: DottedBorder(
                  strokeWidth: 2,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        _image == null
                            ? Image.asset(
                                'assets/images/aadhar.png',
                                width: 250,
                                height: 250,
                              )
                            : Image.file(_image, width: 250, height: 250),
                        // SizedBox(height: 1,),
                        Text(
                          'Add your Aadhar document ',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 3,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => openSheet(isAfter: false),
                child: DottedBorder(
                  strokeWidth: 2,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        _image2 == null
                            ? Image.asset('assets/images/hold2.png',
                                height: 250, width: 250)
                            : Image.file(
                                _image2,
                                width: 250,
                                height: 250,
                              ),
                        Text(
                          'Add a image of yourself holding your Aadhar',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              RoundedLoadingButton(
                  controller: controller,
                  onPressed: () async {
                    final ipv4 = await Ipify.ipv4();
                    await DB().addImages(userProvider, _image, _image2,ipv4);
                    controller.success();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NotVerified()));
                  },
                  child: Text('Submit to verify'))
            ]),
          ),
        ),
      ),
    );
  }

  void openSheet({bool isAfter}) {
    PlatformActionSheet().displaySheet(context: context, actions: [
      ActionSheetAction(
        text: "Take Picture",
        onPressed: () => getImage(ImageSource.camera, context, isAfter),
      ),
    ]);
  }

  Future getImage(
      ImageSource source, BuildContext context, bool isAfter) async {
    final result = await ImagePicker.platform.pickImage(source: source);
    Navigator.pop(context);
    if (result != null) {
      print("file picked");
      File file = File(result.path);
      if (isAfter) {
        setState(() {
          _image = file;
        });
      } else {
        setState(() {
          _image2 = file;
        });
      }
    }
  }

  Widget buildTextField(String label, TextInputType type) {
    return Center(
      child: Container(
          width: MediaQuery.of(context).size.width * .75,
          height: 54,
          decoration: BoxDecoration(
              color: Colors.white,
              //border: Border.all(color: Color(0xFFF313039), width: 3),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: type,
              style: TextStyle(color: Color(0xFFF191720)),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  border: InputBorder.none,
                  hintText: label,
                  hintStyle: TextStyle(
                    color: Color(0xFFF7c7d89),
                  )),
            ),
          )),
    );
  }
}
