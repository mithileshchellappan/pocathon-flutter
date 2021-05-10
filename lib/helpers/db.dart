import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:supabase/supabase.dart';
import 'package:votefromhome/providers/userProvider.dart';

class DB {
  
  final client = SupabaseClient('https://159.138.49.122:3000',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyMDI5MjE2MywiZXhwIjoxOTM1ODY4MTYzfQ.0PsatQBg8KDw9gcHM7XTIWdLuQ2TVCsCBi1sP6O6fCQ');
  Future<void> addImages(
      UserProvider userProvider, File img1, File img2, var ip) async {
    var res = await Dio()
        .post('https://votefromhome.herokuapp.com/api/createVC', data: {
      'did': userProvider.currentUser.did,
      'username': userProvider.currentUser.username
    });
    final storageRes = await client.storage
        .from(userProvider.currentUser.username)
        .upload('${userProvider.currentUser.username}-aadhar.jpg', img1);
    final storageRes2 = await client.storage
        .from(userProvider.currentUser.username)
        .upload('${userProvider.currentUser.username}-user.jpg', img2);

    final response = await client.from('users').insert({
      'isVerified': false,
      'username': userProvider.currentUser.username,
      'got_seed': false
    });
    final response2 = await client.from('unsignedVC').insert({
      'username': userProvider.currentUser.username,
      'unverified_vc': res.data['unsignedVC'],
      'user_image': storageRes,
      'aadhar_image': storageRes2,
      'ip': ip
    });
  }
}
