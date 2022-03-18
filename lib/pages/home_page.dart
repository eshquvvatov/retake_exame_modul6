import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:retake_exame_modul6/pages/add_page.dart';
import '../model/card_model.dart';
import '../service/hive_service.dart';
import '../service/http_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const id = "/home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CardModel> list = [];
  ConnectivityResult _connectionStatus = ConnectivityResult.values[0];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
bool isload=false;
  void loaddata() {
    setState(() {
      isload=true;
    });
    HttpService.GET(HttpService.API_CARDS_LIST, HttpService.paramEmpty())
        .then((value) {
      if (value != null) {
        saveData(value);
      }
    });
  }

  void saveData(String response) {
    setState(() {
      list.addAll(HttpService.parseCards(response));
      isload=false;
    });
  }
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
    if ((_connectionStatus == ConnectivityResult.wifi ||
        _connectionStatus == ConnectivityResult.mobile) ) {
      loaddata();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initConnectivity().then((value) =>loaddata());
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beneficiary",style: TextStyle(color: Colors.black,fontSize: 25),),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.black,size: 40,),
          onPressed: (){},
        ),
      ),
      body:isload?Center(child:CircularProgressIndicator(),): Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                child: TextField(

                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search,size: 35,color: Colors.black,),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      focusedBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none,),
                      border: OutlineInputBorder(borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(" Recipients",style: TextStyle(color: Colors.grey.shade600,fontSize: 20),),
              SizedBox(
                height: 20,
              ),
              if (list.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    //  physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return buildCard(context, list[index]);
                      }),
                ),
            ]
        ),

      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddPage()));
      },
        child: Icon(Icons.add,color: Colors.white,size: 40,),
      ),
    );
  }

  Dismissible buildCard(BuildContext context, CardModel index) {
    return Dismissible(
        key: const ValueKey(0),
        onDismissed: (DismissDirection direction) async {
          list.remove(index);
          await HttpService.DELETE(
              HttpService.API_DELETE + index.id, HttpService.paramEmpty());

          //DeleteoDialog(index);
        },
        direction: DismissDirection.endToStart,
      child: ListTile(
        minLeadingWidth: 0,
        minVerticalPadding: 0,
        shape: RoundedRectangleBorder(),
        focusColor: Colors.blue,
        // minLeadingWidth: 0,
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: Colors.deepPurple,
          child: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("assets/images/boy.jpg"),
          ),
        ),
        contentPadding: EdgeInsets.zero,
        title: Text(index.name),
        subtitle: Text(
          index.phoneNumber,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: MaterialButton(
          onPressed: () {},
          height: 30,
          color: Colors.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.58),
              ),
          child: Text(
            "Send",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),);
  }

}
