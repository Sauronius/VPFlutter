import 'package:dc_video_player/VideoRoute.dart';
import 'package:flutter/material.dart';
import 'package:dc_video_player/FilePickRoute.dart';
import 'package:dc_video_player/SettingsRoute.dart';
import 'package:dc_video_player/FavouritesRoute.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DC Video Player',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FullBottomNavigationBar(title: 'Video Player DC'),
      routes: {VideoRoute.routeName: (context) => VideoRoute()},
    );
  }
}

class FullBottomNavigationBar extends StatefulWidget {
  FullBottomNavigationBar({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FullBottomNavigationBarState createState() =>
      _FullBottomNavigationBarState();
}

class _FullBottomNavigationBarState extends State<FullBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    FilePickRoute(),
    SettingsRoute(),
    FavouritesRoute(),
  ];

  void onTappedOption(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 10,
        selectedFontSize: 15,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
