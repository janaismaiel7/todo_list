import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/appColors.dart';
import 'package:todo_list/firebaseUtiles.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/provider/authUserProvider.dart';
import 'package:todo_list/provider/listProvider.dart';

class Edittaskbottomsheet extends StatefulWidget {
  final task Task;
  Edittaskbottomsheet({required this.Task});

  @override
  State<Edittaskbottomsheet> createState() => _EdittaskbottomsheetState();
}

class _EdittaskbottomsheetState extends State<Edittaskbottomsheet> {
  final formkey = GlobalKey<FormState>();
  late DateTime selectedDate;
  late String title;
  late String descr;
  late Listprovider listProvider;

  void initState() {
    super.initState();
    title = widget.Task.title;
    descr = widget.Task.descr;
    selectedDate = widget.Task.dateTime;
  }

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<Listprovider>(context);
  

    
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            'Edit Task',
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
                  // validator: (text) {
                  //   if (text == null || text.isEmpty) {
                  //     return 'please enter task title';
                  //   }
                  //   return null;
                  // },
                  decoration: InputDecoration(
                    hintText: 'Edit task title',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (text) {
                    descr = text;
                  },
                  // validator: (text) {
                  //   if (text == null || text.isEmpty) {
                  //     return 'edit task description';
                  //   }
                  //   return null;
                  // },
                  decoration: InputDecoration(
                    hintText: 'edit task description',
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
                      editTask();
                    },
                    child: Text(
                      'Edit',
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

  void editTask() {
    if (formkey.currentState?.validate() == true) {
      final taskupdated = widget.Task.copyWith(
        title: title.isNotEmpty ? title : widget.Task.title,
        descr: descr.isNotEmpty ? descr : widget.Task.descr,
        dateTime: selectedDate,
      );
 var authProvider = Provider.of<Authuserprovider>(context,listen: false);
      Firebaseutiles.editTasktoFireStore(taskupdated,authProvider.currentUser!.id).timeout(
        Duration(seconds: 1),
        onTimeout: () {
          print('Task edited succesfully');
          listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id);
          Navigator.pop(context);
        },
      );
    }
  }
}
