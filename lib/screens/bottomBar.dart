// import 'package:analyzebuddy/screens/homePage.dart';
// import 'package:analyzebuddy/screens/userProfile.dart';
import 'package:alertify/screens/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:analyzebuddy/src/constants/colors.dart';


class appBottom extends StatefulWidget {
  const appBottom({super.key});

  @override
  State<appBottom> createState() => _appBottomState();
}

class _appBottomState extends State<appBottom> {
  int SelectedPageIndex =0;

  static final List<Widget> _WidgetsOptions = <Widget>[
    // HomeScreen(),
    HomePage(),

    const Text("Biller"),
    const Text("Data"),
    const Text("Profile"),

    // userProfile(),
  ];

  void onItemTapped(int index) {
    setState((){
      SelectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.black.,
          title: Text("Alertify")
        ),
        body: Center(child: _WidgetsOptions[SelectedPageIndex]),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onItemTapped,
          currentIndex: SelectedPageIndex,
          elevation: 10,
          unselectedItemColor: CupertinoColors.systemGrey2,
          selectedItemColor: Colors.blue,
          items: [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),
                activeIcon: Icon(Icons.home),
                label: "Home"),

            BottomNavigationBarItem(icon: Icon(Icons.money),
                activeIcon: Icon(CupertinoIcons.money_dollar_circle_fill),
                label: "Biller"),
            BottomNavigationBarItem(icon: Icon(Icons.data_saver_off_sharp),
                activeIcon: Icon(Icons.data_saver_on_sharp),
                label: "Data"),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.person),
                activeIcon: Icon(Icons.person),
                label: "Profile"),

          ],
        ));
  }
}
