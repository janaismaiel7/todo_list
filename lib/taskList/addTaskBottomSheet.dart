import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/appColors.dart';
import 'package:todo_list/firebaseUtiles.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/provider/listProvider.dart';

class Addtaskbottomsheet extends StatefulWidget {
  const Addtaskbottomsheet({super.key});

  @override
  State<Addtaskbottomsheet> createState() => _AddtaskbottomsheetState();
}

class _AddtaskbottomsheetState extends State<Addtaskbottomsheet> {
  var selectedDate = DateTime.now();
  var formkey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late Listprovider listProvider;
  @override
  Widget build(BuildContext context) {
   listProvider = Provider.of<Listprovider>(context);
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            'Add New Task',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  onChanged: (text) {
                    title = text;
                  },
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'please enter task title';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter task title',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (text) {
                    description = text;
                  },
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'please enter task description';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter task description',
                  ),
                  maxLines: 4,
                ),
                Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: Text(
                    'Select Date',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      showCalender();
                    },
                    child: Text(
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Appcolors.primaryColor)),
                    onPressed: () {
                      addtask();
                    },
                    child: Text(
                      'add',
                      style: Theme.of(context).textTheme.titleLarge,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    selectedDate = chosenDate ?? selectedDate;
    setState(() {});
  }

  void addtask() {
    if (formkey.currentState?.validate() == true) {
      task t = task(
          title: title,
          descr: description,
          dateTime: selectedDate,
          isDone: true);

      Firebaseutiles.addTaskToFireStore(t).timeout(
        Duration(seconds: 1),
        onTimeout: () {
          print('Task added succesfully');
          listProvider.getAllTasksFromFireStore();
          Navigator.pop(context);
        },
      );
    }
  }
}
//timeout offline
//then online