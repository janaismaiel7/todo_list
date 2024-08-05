import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/appColors.dart';
import 'package:todo_list/login/loginScreen.dart';
import 'package:todo_list/provider/authUserProvider.dart';
import 'package:todo_list/provider/listProvider.dart';
import 'package:todo_list/settings/settingsTab.dart';
import 'package:todo_list/taskList/addTaskBottomSheet.dart';
import 'package:todo_list/taskList/taskListTab.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});
  static const String routeName = 'homescreen';

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<Authuserprovider>(context);
    var listProvider = Provider.of<Listprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To Do List {${authProvider.currentUser!.name}}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
              onPressed: () {
                listProvider.taskList = [];
                Navigator.of(context)
                    .pushReplacementNamed(Loginscreen.routeName);
              },
              icon: Icon(Icons.logout))
        ],
        backgroundColor: Appcolors.primaryColor,
        // toolbarHeight: MediaQuery.of(context).size.height*0.2,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
            iconSize: 20,
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: 'Task List'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            color: Appcolors.primaryColor,
          ),
          Expanded(child: selectedIndex == 0 ? Tasklisttab() : Settingstab())
        ],
      ),
    );
  }

  List<Widget> Tabs = [Tasklisttab(), Settingstab()];
  void showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => Addtaskbottomsheet());
  }
}
