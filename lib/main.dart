import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_data_app/logo_page.dart';
import 'package:pokemon_data_app/pocket_zoo_controller.dart';
import 'package:pokemon_data_app/pocket_zoo_modal.dart';
import 'pocket_zoo_detail.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Color(0xFF616161),
      home: LogoScreen(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PocketModal> pocketData = List<PocketModal>();
  List<PocketModal> updatedPocketData = [];

  @override
  void initState() {
    super.initState();
    PocketController().getFeedList().then((pocketData) {
      setState(() {
        this.pocketData = pocketData;
        print("buyer Data: ${pocketData[0].toJson()}");
      });
      for (int i = 0; i < pocketData.length - 1; i++) {
        updatedPocketData.add(pocketData[i]);
      }
    });
  }

  void fetchData() {
    updatedPocketData.clear();
    PocketController().getFeedList().then((pocketData) {
      setState(() {
        this.pocketData = pocketData;
        print("buyer Data: ${pocketData[0].toJson()}");
      });
      for (int i = 0; i < pocketData.length - 1; i++) {
        updatedPocketData.add(pocketData[i]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD7CCC8),
      appBar: AppBar(
        elevation: 6.0,
        title: Text(
          'Pocket Zoo',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF9E9E9E),
      ),
      body: updatedPocketData.length < 1
          ? Center(
              child: SpinKitSquareCircle(
                color: Colors.lightBlueAccent,
                size: 50.0,
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              children: updatedPocketData
                  .map((poke) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PocketZooDetail(
                                      pocketAnimal: poke,
                                    )));
                      },
                      child: Hero(
                        transitionOnUserGestures: true,
                        tag: poke.image,
                        child: Card(
                          elevation: 5.1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0)),
                          ),
                          color: Color(0xFFD7CCC8),
                          child: Column(
//
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
//                                  height:
//                                      MediaQuery.of(context).size.height * 0.4,
//                                  width:
//                                      MediaQuery.of(context).size.width * 0.2,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    fit: BoxFit.scaleDown,
                                    image: NetworkImage(poke.image),
                                  )),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  poke.name,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )))
                  .toList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchData();
        },
        backgroundColor: Color(0xFF9E9E9E),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
