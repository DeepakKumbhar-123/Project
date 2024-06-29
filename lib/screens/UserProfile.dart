import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class UserProfile extends StatefulWidget {
  final Map<dynamic,dynamic> users;
  const UserProfile({super.key, required this.users});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
body: Padding(
  padding: const EdgeInsets.all(30.0),
  child: Container(
    height: size.height,
    width: size.width,
    decoration: BoxDecoration(
        color: Colors.blue.shade100,

      borderRadius: BorderRadius.circular(25)
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Profile",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25),),
          SizedBox(height: 25,),
          Icon(CupertinoIcons.profile_circled,size: 150,color: CupertinoColors.inactiveGray,),
          SizedBox(height: 20,),

          Text('Name: ${widget.users['Name']}',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
          SizedBox(height: 20,),
          Text('Mobile Number: ${widget.users['Mobile Number']}',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
          
          SizedBox(height: 100,),
          Text("Made with ❤️ by Team INSPIRE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
        ],
      ),
    ),
  ),
),
    );
  }
}
