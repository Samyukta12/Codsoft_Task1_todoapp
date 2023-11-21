import 'package:flutter/material.dart';
import 'package:todo/dashboard.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

void main() => runApp(MaterialApp(
  // await Hive.initFlutter();


  debugShowCheckedModeBanner: false,

    home: MyApp()));

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    Future.delayed(Duration(seconds: 1),(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(



          child:
          Text(
            'Welcome',
            style: TextStyle(
              color: Colors.black,
            ),
          ),



      ),
    );
  }
}
