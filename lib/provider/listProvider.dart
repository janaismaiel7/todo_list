import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/firebaseUtiles.dart';
import 'package:todo_list/model/task.dart';

class Listprovider extends ChangeNotifier {
  List<task> taskList = [];
  DateTime selectDate = DateTime.now();
  //get all tasks
  void getAllTasksFromFireStore() async {
    QuerySnapshot<task> querySnapshot =
        await Firebaseutiles.getTaskCollection().get();
    //List<QueryDocumentSnapshot<T>> = List<Task>
    taskList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    taskList = taskList.where((task) {
      if (selectDate.day == task.dateTime.day &&
          selectDate.month == task.dateTime.month &&
          selectDate.year == task.dateTime.year) {
        return true;
      }
      return false;
    }).toList();

    taskList.sort((task task1, task task2) {
      return task1.dateTime.compareTo(task2.dateTime);
    });

    notifyListeners();
  }

  void changeSelectDate(DateTime nwSelectedDate) {
    selectDate = nwSelectedDate;
    getAllTasksFromFireStore();
  }
}
