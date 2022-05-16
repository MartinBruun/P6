import 'package:flutter/material.dart';
import 'package:washee/core/account/user.dart';
import 'package:washee/core/pages/pages_enum.dart';
import 'package:washee/core/pages/washee_screen.dart';
import 'package:washee/features/sign_in/presentation/pages/sign_in_screen.dart';
import 'package:washee/features/unlock/presentation/pages/wash_screen.dart';
import 'package:washee/features/booking/presentation/pages/calendar_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home-screen";
  final int page;

  HomeScreen({
    this.page = PageNumber.WasheeScreen,
  });
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _pages = [
  ];

  int _selectedPageIndex = 0;

  ActiveUser user = ActiveUser();

  @override
  void initState() {
    _pages = [
      WashScreen(),
      WasheeScreen(),
      CalendarScreen(),
    ];
    _selectedPageIndex = widget.page;

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
        ? SignInScreen()
        : Scaffold(
            body: _pages[_selectedPageIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border(top: BorderSide(color: Colors.white, width: 2.0)),
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
}
