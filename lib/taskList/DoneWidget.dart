import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/appColors.dart';
import 'package:todo_list/firebaseUtiles.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/provider/listProvider.dart';
import 'package:todo_list/taskList/editTaskBottomSheet.dart';

class Donewidget extends StatefulWidget {
  task t;
  Donewidget({required this.t});

  @override
  State<Donewidget> createState() => _DonewidgetState();
}

class _DonewidgetState extends State<Donewidget> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
   

    return Container(
      margin: EdgeInsets.all(12),
     
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
                      widget.t.title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                           color:Colors.green, fontSize: 22),
                    ),
                    Text(
                      widget.t.descr,
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
                     color:Colors.green),
                  child: Text(
                    'Done',style:Theme.of(context).textTheme.bodyLarge?.copyWith(
                           color:Colors.green, fontSize: 22 ,
                  )
                ))
              ],
            )),
      
    );

  }
}
