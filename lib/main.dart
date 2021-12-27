import 'package:flutter/material.dart';
import 'home_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
      title: 'OnTrack Todo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blueGrey[100],
          cardTheme: CardTheme(
              elevation: 1,
              color: Colors.blue[200],
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20)),
          primaryColor: Colors.blueAccent,
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.blue[900],
          )),
      
    ),
  );
}
