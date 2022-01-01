// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/home_view.dart';

class NewTask extends StatelessWidget {
  NewTask({Key? key}) : super(key: key);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'New Task',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomeView()));
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          children: [
            TextFormField(
              controller: _titleController,
              maxLines: 2,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                hintText: 'Please Enter Todo Title',
                labelText: 'Title',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.blue[900]),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Title is required";
                }
              },
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                hintText: 'Please Enter Todo Description',
                labelText: 'Description',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.blue[900]),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Description is required";
                }
              },
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextFormField(
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(Duration(days: 360)))
                          .then((selectedDate) {
                        final DateFormat _dateFormat = DateFormat.yMMMMEEEEd();
                        _dateController.text =_dateFormat.format(selectedDate!) ;
                      });
                    },
                    controller: _dateController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      hintText: 'Please Enter Todo Date',
                      labelText: 'Date',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.blue[900]),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Date is required";
                      }
                    },
                  ),
                ),
                SizedBox(width: 40),
                Expanded(
                  child: TextFormField(
                    controller: _timeController,
                    maxLines: 1,
                    keyboardType: TextInputType.none,
                    onTap: () {
                      showTimePicker(
                              context: context, initialTime: TimeOfDay.now())
                          .then((selectedTime) {
                        _timeController.text = selectedTime!.format(context);
                      });
                    },
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      hintText: 'Please Enter Todo Time',
                      labelText: 'Time',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.blue[900]),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Time is required";
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  padding: EdgeInsets.symmetric(vertical: 15),
                  elevation: 5,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //send to backend
                    print('success');
                  } else {
                    // validation failed
                    print('failed');
                  }
                },
                child: Text('Create',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )))
          ],
        ),
      ),
    ));
  }
}
