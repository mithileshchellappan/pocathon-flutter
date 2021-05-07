import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:votefromhome/providers/userProvider.dart';

class DB{
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void>  addImages(UserProvider userProvider,File img1,File img2,var ip) async {
    await _firebaseAuth.signInAnonymously();
    Reference reference = _storage.ref().child('aadhar-img').child(userProvider.currentUser.username+DateTime.now().toString());
    Reference reference2 = _storage.ref().child('aadhar-holding').child(userProvider.currentUser.username+DateTime.now().toString());
    UploadTask up1 = reference.putFile(img1);
    UploadTask up2 = reference2.putFile(img2);
    Set<String> dl1 = await up1.then((res)async=>{await res.ref.getDownloadURL()});
    Set<String> dl2 = await up2.then((res) async => {await res.ref.getDownloadURL()});
    var res = await Dio().post('https://votefromhome.herokuapp.com/api/createVC',data: {
      'did':userProvider.currentUser.did,
      'username':userProvider.currentUser.username
    });
    
    print(dl1.first);
    print(res.data['unsignedVC']);
    firestore.collection('users').doc(userProvider.currentUser.username).set({
      'isVerified':false,
      'username':userProvider.currentUser.username,
    });
    firestore.collection('unsignedVC').doc(userProvider.currentUser.username).set({
      'username':userProvider.currentUser.username,
      'unverified_vc': res.data['unsignedVC'],
      'user_image':dl1.first,
      'aadhar_image':dl2.first,
      'ip':ip
    });
  }

}