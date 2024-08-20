import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/firebaseUtiles.dart';
import 'package:todo_list/provider/authUserProvider.dart';
import 'package:todo_list/provider/listProvider.dart';
import 'package:todo_list/taskList/taskListIteam.dart';

import '../model/task.dart';

class Tasklisttab extends StatefulWidget {
  @override
  State<Tasklisttab> createState() => _TasklisttabState();
}

class _TasklisttabState extends State<Tasklisttab> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<Listprovider>(context);
    var authProvider = Provider.of<Authuserprovider>(context);
    if (listProvider.taskList.isEmpty) {
      listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id);
    }
    List<task> donetasks =
        listProvider.taskList.where((task) => task.isDone).toList();
    List<task> notdoneTasks =
        listProvider.taskList.where((task) => !task.isDone).toList();

   

    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: listProvider.selectDate,
          onDateChange: (selectedDate) {
            listProvider.changeSelectDate(
                selectedDate, authProvider.currentUser!.id);
          },
          headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: DateFormatter.fullDateDMY(),
          ),
          dayProps: const EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
            activeDayStyle: DayStyle(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff3371FF),
                    Color(0xff8426D6),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
            child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(tabs: [
                      Tab(
                        text: 'Not Done',
                      ),
                      Tab(
                        text: 'Done',
                      )
                    ]),
                    Expanded(
                        child: TabBarView(children: [
                      ListView.builder(
                        itemBuilder: (context, index) {
                          return Tasklistitem(t: notdoneTasks[index]);
                        },
                        itemCount: notdoneTasks.length,
                      ),
                      ListView.builder(itemBuilder: (context, index) {
                        return Tasklistitem(t: donetasks[index]);
                      },
                      itemCount: donetasks.length,
                      )
                    ]))
                  ],
                )))
      ],
    );
  }
}
