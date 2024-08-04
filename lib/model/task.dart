import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class task {
  static const String colllecationName = 'tasks';
  String id;
  String title;
  String descr;
  DateTime dateTime;
  bool isDone;

  task(
      {this.id = '',
      required this.title,
      required this.descr,
      required this.dateTime,
      this.isDone = false});

  task copyWith({
    String? title,
    String? descr,
    DateTime? dateTime,
    bool? isDone,
  }) {
    return task(
      id: this.id,
      title: title ?? this.title,
      descr: descr ?? this.descr,
      dateTime: dateTime ?? this.dateTime,
      isDone: isDone ?? this.isDone,
    );
  }


//json to object
  task.fromfireStore(Map<String, dynamic> data)
      : this(
            id: data['id'] as String,
            title: data['title'] as String,
            descr: data['descr'] as String,
            dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
            isDone: data['isDone']);

//object to json
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'descr': descr,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'isDone': isDone
    };
  }
}
