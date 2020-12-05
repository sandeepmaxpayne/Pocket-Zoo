import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_data_app/pocket_zoo_modal.dart';

class PocketZooDetail extends StatefulWidget {
  final PocketModal pocketAnimal;
  PocketZooDetail({this.pocketAnimal});

  @override
  _PocketZooDetailState createState() => _PocketZooDetailState();
}

class _PocketZooDetailState extends State<PocketZooDetail>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  AnimationStatus animationStatus = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        animationStatus = status;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9E9E9E),
      appBar: AppBar(
        title: Text(widget.pocketAnimal.name),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFF9E9E9E),
      ),
      body: bodyWidget(context),
    );
  }

  bodyWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width - 20,
          top: MediaQuery.of(context).size.height * 0.1,
          left: 10.0,
          child: Container(
            child: Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(1, 3, 2)
                ..rotateY(2 * pi * animation.value),
              child: GestureDetector(
                onTap: () {
                  print(animation.value);
                  if (animationStatus == AnimationStatus.dismissed) {
                    animationController.forward();
                  } else {
                    animationController.reverse();
                  }
                },
                child: animation.value < 0.5
                    ? Card(
                        elevation: 12,
                        color: Color(0xffD7CCC8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(
                              color: Color(0xFF757575),
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              height: 40.0,
                            ),
                            Text(
                              widget.pocketAnimal.name,
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Height: ${widget.pocketAnimal.height}",
                              style: TextStyle(
                                fontFamily: "Acme",
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.2,
                              ),
                            ),
                            Text(
                              "Weight: ${widget.pocketAnimal.weight}",
                              style: TextStyle(
                                fontFamily: "Acme",
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.2,
                              ),
                            ),
                            Text(
                              "Types",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.pocketAnimal.type,
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            Text(
                              "Weakness",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.pocketAnimal.weakness,
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      )
                    : Card(
                        elevation: 12,
                        color: Color(0xffD7CCC8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              widget.pocketAnimal.name,
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Color(0xFF757575))),
                      ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            transitionOnUserGestures: true,
            tag: widget.pocketAnimal.image,
            child: Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: NetworkImage(widget.pocketAnimal.image),
                    alignment: Alignment.topCenter),
              ),
            ),
          ),
        )
      ],
    );
  }
}
