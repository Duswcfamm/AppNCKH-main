import 'package:flutter/material.dart';
import 'package:my_flutter_project/services/base_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}
String printToken='';

class _HomePageState extends State<HomePage> {

  @override
  void initState(){
    loadToken();
    super.initState();
  }
  void loadToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      printToken = prefs.getString('token') ?? 'no key received';
    });
  }
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Demo w Token',
            style: TextStyle(
                fontSize: 30,
                color: Colors.black
            ),
          ),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
            child: Text(
              '$printToken',
              style: TextStyle(
                fontSize: 20
              ),
            ),
          ),
        ),
      ),
    );
  }
}
