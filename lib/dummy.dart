import 'package:auto_animated/auto_animated.dart';
import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:votefromhome/consts/participants.dart';

class Dummy extends StatefulWidget {
  @override
  _DummyState createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  ///Page Controller for the PageView
  final controller = PageController(
    initialPage: 0,
  );
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  var scrollDirection = Axis.horizontal;
  var actionIcon = Icons.swap_vert;

  

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF0059a4),
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
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller,
                scrollDirection: scrollDirection,

                ///Enable physics property to provide your PageView with a
                ///custom scroll behaviour
                ///Here BouncingScrollPhysics will pull back the boundary
                ///item (first or last) if the user tries to scroll further.
                //physics: BouncingScrollPhysics(),
                pageSnapping: false,
                children: <Widget>[
                  Container(
                    color: Color(0xFF0059a4),
                    width: MediaQuery.of(context).size.width * .9,
                    child: Card(
                      elevation: 4,
                      // margin: EdgeInsets.all(24),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(19.0),
                          child: Container(
                            child: Stack(
                              children: [
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Text("Voting ends in ",
                                        style: TextStyle(
                                            fontSize: 29,
                                            color: Color(0xFFF003963)))),
                                Padding(
                                  padding: const EdgeInsets.all(22.0),
                                  child: TimeCircularCountdown(
                                    isClockwise: false,
                                    countdownCurrentColor: Colors.white,
                                    countdownRemainingColor: Color(0xFFF003963),
                                    unit: CountdownUnit.second,
                                    strokeWidth: 8,
                                    countdownTotal: 30,
                                    onUpdated: (unit, remainingTime) =>
                                        print('Updated'),
                                    onFinished: () =>
                                        print('Countdown finished'),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: Text("3 h 12 min",
                                        style: TextStyle(
                                            color: Color(0xFFF003963),
                                            fontSize: 40))),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: RoundedLoadingButton(
                                        color: Color(0xFFF003963),
                                        controller: _btnController,
                                        animateOnTap: false,
                                        onPressed: () {
                                          controller.animateToPage(1,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.ease);
                                        },
                                        child: Text("VOTE",
                                            style: TextStyle(fontSize: 21))))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Color(0xFF0059a4),
                    child: Card(
                      // color: Colors.purpleAccent,
                      elevation: 4,
                      // margin: EdgeInsets.all(24),
                      child: Center(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            AnimateIfVisibleExample(),
                            ElevatedButton(
                              onPressed: () => controller.animateToPage(0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInQuad),
                              child: Text("Back"),
                            ),
                          ],
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimateIfVisibleExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AnimateIfVisibleWrapper(
        showItemInterval: Duration(milliseconds: 150),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              for (int i = 0; i < participants.length; i++)
                AnimateIfVisible(
                  key: Key('$i'),
                  builder: animationBuilder(
                    SizedBox(
                      width: double.infinity,
                      height: 250,
                      child: HorizontalItem(
                        title: '$i',
                        partyImage: participants[i]['party-image'],
                        image: participants[i]['image'],
                        name:participants[i]['name'],
                        party:participants[i]['party']
                      ),
                    ),
                    xOffset: i.isEven ? 0.15 : -0.15,
                    padding: EdgeInsets.all(16),
                  ),
                ),
            ],
          ),
        ),
      );

  Widget Function(
    BuildContext context,
    Animation<double> animation,
  ) animationBuilder(
    Widget child, {
    double xOffset = 0,
    EdgeInsets padding = EdgeInsets.zero,
  }) =>
      (
        BuildContext context,
        Animation<double> animation,
      ) =>
          FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(xOffset, 0.1),
                end: Offset.zero,
              ).animate(animation),
              child: Padding(
                padding: padding,
                child: child,
              ),
            ),
          );
}

class HorizontalItem extends StatelessWidget {
  const HorizontalItem({
    @required this.title,
    @required this.name,
    @required this.image,
    @required this.partyImage,
    @required this.party,
    Key key,
  }) : super(key: key);

  final String title, name,image,partyImage,party;

  @override
  Widget build(BuildContext context) => Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 5,
        child: Container(
          width: 140,
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Material(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              image,
                            ),
                          ),
                        ),
                        SizedBox(width:10),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              partyImage,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text("$name".toUpperCase(),
                          style: TextStyle(
                              color: Color(0xFFF003963),
                              fontSize: 19,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("$party",
                            style: TextStyle(
                                color: Color(0xFFF0055a3),
                                fontSize: 19,
                                fontWeight: FontWeight.bold))),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          
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
                                    
                                  },
                                  child: Center(
                                      child: Text("VOTE",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Colors.white)))),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ),
      );
}
