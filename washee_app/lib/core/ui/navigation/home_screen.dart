import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/ui/navigation/pages_enum.dart';
import 'package:washee/features/account/presentation/pages/sign_in_page.dart';
import 'package:washee/features/account/presentation/pages/washee_screen.dart';
import 'package:washee/features/account/presentation/provider/account_functionality_provider.dart';
import 'package:washee/features/location/presentation/pages/wash_screen.dart';
import 'package:washee/features/booking/presentation/pages/calendar_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home-screen";
  final int page;

  HomeScreen({
    this.page = PageNumber.WasheeScreen
  });
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _pages = [
  ];

  int _selectedPageIndex = 0;

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
    var accountProvider = Provider.of<AccountFunctionalityProvider>(context, listen: true);
    return !accountProvider.currentUser.loggedIn
        ? SignInPage()
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
