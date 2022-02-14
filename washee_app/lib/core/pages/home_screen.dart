import 'package:flutter/material.dart';
import 'package:washee/core/pages/options_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home-screen";
  final Object page;
  final bool setBackToOp;

  HomeScreen({this.page = BookingScreen, this.setBackToOp = false});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _pages = [];

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [BookingScreen()];
    _selectedPageIndex = _pages
        .indexWhere((element) => element.toString() == widget.page.toString());
    print(widget.page.toString());

    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.green,
            ),
          ],
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
                icon: Icon(Icons.home),
                label: 'Home',
              ),
            ]),
      ),
    );
  }
}
