import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase/supabase.dart' as sp;
import 'package:votefromhome/notVerified.dart';
import 'package:votefromhome/providers/userProvider.dart';
import 'package:votefromhome/registerVC.dart';

import 'voteDashboard.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final client = sp.SupabaseClient('https://159.138.49.122:3000',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyMDI5MjE2MywiZXhwIjoxOTM1ODY4MTYzfQ.0PsatQBg8KDw9gcHM7XTIWdLuQ2TVCsCBi1sP6O6fCQ');

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);
    final subscription =
        client.from('users').on(sp.SupabaseEventTypes.all, (x) {
    }).subscribe((String event, {String errorMsg}) {
    });
    return Scaffold(
        body: SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFFF0F0EF),
          body: FutureBuilder(
              future: client
                  .from('users')
                  .select(userProvider.currentUser.username)
                  .execute(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    return wgd(snapshot, context);
                  default:
                    return Text('Oops! Something went wrong');
                }
              })),
    ));
  }

  Widget wgd(AsyncSnapshot snapshot, BuildContext context) {
    if (snapshot.data.docs.length > 0) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          if (snapshot.data.docs[0]['isVerified'] == true) {
            return VoteDashboard();
          } else {
            return NotVerified();
          }
        }));
      });
    } else {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/character.gif'),
          Text(
              'Uh Oh! Looks like you are UNREGISTERED! \n \tContinue to register with our partner',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Please note that your current IP and location will be noted and you can vote only when you are connected to the same network and if you are within 50 meter radius of you current location.\n Please make arrangements according that and proceed to apply for registration ',
                style: TextStyle(fontSize: 16)),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterVC()));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Continue', style: TextStyle(fontSize: 19.0)),
            ),
          )
        ],
      ));
    }
  }
}
