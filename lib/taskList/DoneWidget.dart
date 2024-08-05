import 'package:flutter/material.dart';
import 'package:todo_list/appColors.dart';
import 'package:todo_list/model/task.dart';

class Donewidget extends StatelessWidget {
  final task t;
  Donewidget({required this.t});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color:  Appcolors.whiteColor),
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
                      color: t.isDone ? Colors.white : Colors.green, fontSize: 22),
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
                  color: Colors.green),
              child: Text(
                'Done',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 22,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}