import 'package:flutter/material.dart';
import 'package:washee/core/account/user.dart';
import 'package:washee/core/pages/washee_screen.dart';
import 'package:washee/features/sign_in/presentation/pages/sign_in_screen.dart';
import 'package:washee/features/unlock/presentation/pages/wash_screen.dart';
import 'package:washee/features/booking/presentation/pages/calendar_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home-screen";
  final Object page;

  HomeScreen({
    this.page = WashScreen,
  });
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _pages = [];

  int _selectedPageIndex = 2;

  ActiveUser user = ActiveUser();

  @override
  void initState() {
    _pages = [
      WashScreen(),
      WasheeScreen(),
      CalendarScreen(),
    ];

<<<<<<< HEAD
    _selectedPageIndex = 2;

    // _pages
    //     .indexWhere((element) => element.toString() == widget.page.toString());
    // print(widget.page.toString());
=======
      _selectedPageIndex = 1;
>>>>>>> 4c1fcfe8f154a0ac67a76aae1f5cbfacd796a4ed

    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !user.loggedIn 
    ? SignInScreen(callback)
    : Scaffold(
      body: _pages[_selectedPageIndex],        
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.white, width: 2.0)),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: _selectPage,
          backgroundColor: Theme.of(context).canvasColor,
          unselectedItemColor: Colors.white54,
          selectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_add_outlined),
              label: 'Wash',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Calendar',
            ),
          ],
        ),
      ),
    );
  }

  void callback() {
    setState(() {
      this._selectedPageIndex = 1;
    });
  }
}
