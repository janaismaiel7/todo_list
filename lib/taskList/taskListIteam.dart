import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/appColors.dart';
import 'package:todo_list/firebaseUtiles.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/provider/authUserProvider.dart';
import 'package:todo_list/provider/listProvider.dart';
import 'package:todo_list/taskList/editTaskBottomSheet.dart';

class Tasklistitem extends StatelessWidget {
  final task t;
  Tasklistitem({required this.t});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var listProvider = Provider.of<Listprovider>(context, listen: false);
      var authProvider = Provider.of<Authuserprovider>(context);

    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              flex: 1,
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                Firebaseutiles.deleteTaskFromFireStore(t,authProvider.currentUser!.id)
                .then((value){
                   print('task deleted successfully');
                  listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id);
                })
                    .timeout(Duration(milliseconds: 500), onTimeout: () {
                  print('task deleted successfully');
                  listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id);
                });
              },
              backgroundColor: Appcolors.redColor,
              foregroundColor: Appcolors.whiteColor,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext) {
                    return Edittaskbottomsheet(
                      Task: t,
                    );
                  },
                );
              },
              backgroundColor: Colors.green,
              foregroundColor: Appcolors.whiteColor,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Appcolors.whiteColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(12),
                color:  t.isDone ? Colors.green : Appcolors.primaryColor,
                width: width * 0.01,
                height: height * 0.1,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: t.isDone ? Colors.green : Appcolors.primaryColor,
                        fontSize: 22),
                  ),
                  Text(
                    t.descr,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Appcolors.blackColor,
                        fontSize: 22),
                  ),
                ],
              )),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                   color: t.isDone ? Colors.white : Appcolors.primaryColor),
                
                child: t.isDone
                    ? Text(
                        'Done!',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.green, fontSize: 30),
                      )
                    : IconButton(
                        onPressed: () async {
                          task updatedTask = t.copyWith(isDone: !t.isDone);
                          await Firebaseutiles.updateTaskInFireStore(updatedTask,authProvider.currentUser!.id)
                             .then((value){
                                 listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id);
                             })
                              .timeout(Duration(milliseconds: 500), onTimeout: () {
                            listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id);
                          });
                        },
                  icon: Icon(
                    Icons.check,
                    size: 35,
                    color: Appcolors.whiteColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
