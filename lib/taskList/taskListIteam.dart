import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/appColors.dart';
import 'package:todo_list/firebaseUtiles.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/provider/listProvider.dart';

class Tasklistiteam extends StatelessWidget {
  task t;
  Tasklistiteam({required this.t});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var listProvider = Provider.of<Listprovider>(context);

    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        
        startActionPane: ActionPane(
        
        //  extentRatio: 0.5,
          // A motion is a widget used to control how the pane animates.
          motion: const DrawerMotion(),

          // A pane can dismiss the Slidable.

          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              flex: 1,
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                Firebaseutiles.deleteTaskFromFireStore(t)
                    .timeout(Duration(milliseconds: 500), onTimeout: () {
                  print('task deleted succesfully');
                  listProvider.getAllTasksFromFireStore();
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
                Firebaseutiles.deleteTaskFromFireStore(t)
                    .timeout(Duration(milliseconds: 500), onTimeout: () {
                  print('task deleted succesfully');
                  listProvider.getAllTasksFromFireStore();
                });
              },
              backgroundColor: Colors.green,
              foregroundColor: Appcolors.whiteColor,
              icon: Icons.edit,
              label: 'edit',
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
                  color: Appcolors.primaryColor,
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
                          color: Appcolors.primaryColor, fontSize: 22),
                    ),
                    Text(
                      t.descr,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 22),
                    ),
                  ],
                )),
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Appcolors.primaryColor),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.check,
                        size: 35,
                        color: Appcolors.whiteColor,
                      )),
                )
              ],
            )),
      ),
    );
  }
   
}
