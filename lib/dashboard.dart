import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _MyAppState();
}

class _MyAppState extends State<Dashboard> {
  List<Model> items = [];

  // textformfiel controller store garene
  late TextEditingController comingtext;
  late SharedPreferences sp;

// textediting controllerlai initialize gareko
  @override
  void initState() {
    comingtext = TextEditingController();

    super.initState();
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
              child: Text(
                'Todo',
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
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
                                Row(
                                  children: [
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
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: CupertinoTextField(
                    textCapitalization: TextCapitalization.words,
                    placeholderStyle: TextStyle(fontSize: 15),
                    controller: comingtext,
                    placeholder: 'Enter task name', //hint text
                    suffix: Container(
                      color: Colors.purple[100],
                      child: GestureDetector(
                          onTap: () {
                            items.add(Model(comingtext.text, false));
                            Navigator.pop(context);
                            setState(() {});
                            comingtext.clear();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Add ",
                              style: TextStyle(color: Colors.black),
                            ),
                          )),
                    ),
                  ))
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
}