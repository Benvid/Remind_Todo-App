import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:to_do_app/utils.dart';
import 'package:to_do_app/views/add_new.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedItem = "todo";

  final List<Map<String, dynamic>> _completedData = [];

  final List<Map<String, dynamic>> _uncompletedData = [];

  final List<Map<String, dynamic>> data = [
    {
      'title': 'Job Interview',
      'description': 'Maintenance Officer postion',
      'date_time': 'Tomorrow',
      'status': false,
    },
    {
      'title': 'Estate Conferrence',
      'description': 'Real Estate program at Age Hotel',
      'date_time': 'Yesterday',
      'status': true,
    },
    {
      'title': 'safety summit',
      'description': ' program at Acra Hall',
      'date_time': 'Yesterday',
      'status': true,
    },
    {
      'title': 'Executive meeting',
      'description': 'venue Age Hotel',
      'date_time': 'Tomorrow',
      'status': false,
    },
    {
      'title': 'Year group meeting',
      'description': 'venue Age Hotel',
      'date_time': '5pm',
      'status': false,
    },
    {
      'title': 'WRC Esport competetion',
      'description': 'aiming to win this time',
      'date_time': 'Today',
      'status': false,
    },
    {
      'title': 'Hack A Day competetion',
      'description': 'aiming to win this time',
      'date_time': 'Today',
      'status': true,
    },
  ];

  @override
  initState() {
    for (Map<String, dynamic> element in data) {
      if (!element['status']) {
        _uncompletedData.add(element);
      } else {
        _completedData.add(element);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          actions: [
            PopupMenuButton<String>(
                icon: Icon(Icons.menu),
                onSelected: (value) {
                  setState(() {
                    selectedItem = value;
                  });
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(child: Text('Todo'), value: "todo"),
                    PopupMenuItem(child: Text('Completed'), value: "completed")
                  ];
                }),
            IconButton(onPressed: () {}, icon: Icon(Icons.search))
          ],
          leading: Center(
            child: FlutterLogo(
              size: 15,
            ),
          ),
          title: Text(
            'My Tasks',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return TaskCardWidget(
                dateTime:  selectedItem == 'todo'
              ? _uncompletedData[index]['date_time']
              : _completedData[index]['date_time'],
              description:  selectedItem == 'todo'
              ? _uncompletedData[index]['description']
              : _completedData[index]['description'],
              title:  selectedItem == 'todo'
              ? _uncompletedData[index]['title']
              : _completedData[index]['title'],);
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 6,
            );
          },
          itemCount: selectedItem == 'todo'
              ? _uncompletedData.length
              : _completedData.length),
      bottomNavigationBar: SafeArea(
        top: false,
        left: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: InkWell(
            onTap: () {
              showBarModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          return TaskCardWidget(
                              dateTime: _completedData[index]['date_time'],
                              title: _completedData[index]['title'],
                              description: _completedData[index]['description']);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 20);
                        },
                        itemCount: _completedData.length);
                  });
            },
            child: Material(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blue[800],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    Text(
                      'Completed',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${_completedData.length}'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.blue[900],
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewTask()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  ButtomNavigationBar() {}
}

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({Key? key, required this.title, required this.description, required this.dateTime}) : super(key: key);

  final String title;
  final String description;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          description,
          maxLines: 3,
          style: TextStyle(
              color: customColor(
                  date: dateTime)),
        ),
        leading: Icon(
          Icons.check_circle_outline_outlined,
          color: customColor(
              date: dateTime),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              dateTime,
              style: TextStyle(
                  color: customColor(
                      date: dateTime)),
            ),
            Icon(Icons.notifications_active_outlined,
                color: customColor(
                    date: dateTime))
          ],
        ),
      ),
    );
  }
}
