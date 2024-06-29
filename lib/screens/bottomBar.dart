import 'package:alertify/screens/Chatting.dart';
import 'package:alertify/screens/UserProfile.dart';
import 'package:alertify/screens/addIndident.dart';
import 'package:flutter/material.dart';
import 'package:alertify/screens/homePage.dart';

class appBottom extends StatefulWidget {
  final Map<dynamic, dynamic> users;

  const appBottom({Key? key, required this.users}) : super(key: key);

  @override
  State<appBottom> createState() => _appBottomState();
}

class _appBottomState extends State<appBottom> {
  int selectedPageIndex = 0;
  late List<Widget> _widgetsOptions;

  @override
  void initState() {
    super.initState();
    _widgetsOptions = <Widget>[
      HomePage(users: widget.users), // Pass users data to HomePage
      AddIncident(users: widget.users),
      UserProfile(users: widget.users),
    ];
  }

  void onItemTapped(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text("Alertify"),
              SizedBox(width: 120,),
              Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.green,
                  ),
                  child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Chatting(users: widget.users,) // Replace with your next screen widget
                          ),
                        );
                      },
                      child: Icon(Icons.mark_unread_chat_alt,color: Colors.white,))),
              SizedBox(width: 10,),
              Container(
                height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.red,
                  ),
                  child: InkWell(
                    onTap: (){
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) =>  // Replace with your next screen widget
                      //   ),
                      // );
                    },
                      child: Icon(Icons.call_end,color: Colors.white,))),
            ],
          ),
        ),
      ),
      body: Center(child: _widgetsOptions[selectedPageIndex]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onItemTapped,
        currentIndex: selectedPageIndex,
        elevation: 10,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
         BottomNavigationBarItem(
            icon: Icon(Icons.add),
            activeIcon: Icon(Icons.add),
            label: "ReportIncident",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
