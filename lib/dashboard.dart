import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:todo/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _MyAppState();
}

class _MyAppState extends State<Dashboard> {
  List<Model> items = [];
  // TimeOfDay dates = TimeOfDay.now();

  // textformfiel controller store garne
  late TextEditingController comingtext;
  late TextEditingController optionalcomingtext;

  late SharedPreferences sp;

  List<String> listofvalue = [];

  Map mapvalue = {};

  List<String>? listofstring;

  initilize() async {
    sp = await SharedPreferences.getInstance();

    List<String>? cominglist = await sp.getStringList("data");

    items= cominglist!.map((e) => Model.fromMap(json.decode(e))).toList();
    setState(() {});
  }

// textediting controllerlai initialize gareko
  @override
  void initState() {
    initilize();

    comingtext = TextEditingController();
    optionalcomingtext = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {


    listofvalue = items.map((save) {
      return json.encode(save.toMap());
    }).toList();

    sp.setStringList("data", listofvalue);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.amber,
            backgroundColor: Colors.purple,
            title: Center(
              child: GestureDetector(
                onTap: (){
                  listofvalue = items.map((save) {
                    return json.encode(save.toMap());
                  }).toList();

                  sp.setStringList("data", listofvalue);

                },
                child: Text(
                  'Todo',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.purple,
            onPressed: createNewTask,
            child: Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.purple[200],
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    Checkbox(
                                        activeColor: Colors.white,
                                        checkColor: Colors.purple,
                                        focusColor: Colors.white,
                                        value: items[index].check,
                                        onChanged: (value) {
                                          items[index].check = value!;
                                          setState(() {});
                                        }),


                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Text(
                                        items[index].description.toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Row(
                                //     children: [
                                //       Text(
                                //         // dates.format(context).toString(),
                                //         // // items[index].dates.toString(),
                                //         "${(items[index].dates.hour + 5) % 24}:${(items[index].dates.minute + 45) % 60}",
                                //
                                //         style: TextStyle(
                                //             fontSize: 18,
                                //             fontWeight: FontWeight.w500,
                                //             color: Colors.black87),
                                //       ),
                                //     ],
                                //   ),
                                // ),



                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(items[index]
                                      .optionaldiscription
                                      .toString()),
                                ),



                                Row(
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.all(15.0),
                                    //   child: ElevatedButton(
                                    //       onPressed: timePick,
                                    //       child: Icon(Icons.timer)),
                                    // ),




                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.purple[100]),
                                      onPressed: () {
                                        EditTask(index);
                                      },
                                      child: Icon(Icons.edit),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.purple[100]),
                                          onPressed: () {
                                            items.removeAt(index);

                                            setState(() {});
                                          },
                                          child: Icon(Icons.delete)),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      );
                    })),
          ),
        ));
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8,top: 25),
                child: CupertinoTextField(
                  maxLength: 27,
                  textCapitalization: TextCapitalization.words,
                  placeholderStyle: TextStyle(fontSize: 15),
                  controller: comingtext,
                  placeholder: 'Enter task name',
                  //hint text
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoTextField(
                  textCapitalization: TextCapitalization.words,
                  placeholderStyle: TextStyle(fontSize: 15),
                  controller: optionalcomingtext,
                  placeholder: 'Enter optional description',
                  //hint text
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      if (comingtext.text != "") {
                        items.add(Model(comingtext.text, false,
                             optionalcomingtext.text));
                        Navigator.pop(context);

                        setState(() {});
                        optionalcomingtext.clear();
                        comingtext.clear();
                      } else {
                        //  adding show(context) method to display the Flushbar
                        Flushbar(
                          message: "Please add todo name",
                          icon: Icon(
                            Icons.error,
                            size: 28.0,
                            color: Colors.blue[300],
                          ),
                          duration: Duration(seconds: 3),
                          leftBarIndicatorColor: Colors.blue[300],
                        )..show(context);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Add"),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void EditTask(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: CupertinoTextField(
                    textCapitalization: TextCapitalization.words,
                    controller: comingtext,
                    suffix: Container(
                      child: GestureDetector(
                          onTap: () {
                            items[index].description = comingtext.text;
                            Navigator.pop(context);
                            setState(() {});
                            comingtext.clear();
                          },
                          child: Text("Edit ")),
                    ),
                  ))
            ],
          );
        });
  }

  // void timePick() async {
  //   await showTimePicker(context: context, initialTime: TimeOfDay.now())
  //       .then((value) {
  //     setState(() {
  //       dates = value!;
  //     });
  //     setState(() {});
  //   });
  // }
}
