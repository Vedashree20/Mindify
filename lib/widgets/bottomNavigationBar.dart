import 'package:flutter/material.dart';
import 'package:myfirstapp/pages/notes.dart';
import '../pages/homePage.dart';
import '../pages/bookingPage.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav>
{
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    bookingPage(),
    Noting(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
         child: _widgetOptions.elementAt(_selectedIndex),
       ),
       bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple[100],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label:'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book_online,
            ),
            label:'Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.edit,
            ),
            label:'Journal',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.0,
        selectedItemColor: Colors.white,
        unselectedFontSize: 13.0,
       ),
    );
  }
}


