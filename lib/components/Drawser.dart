import 'package:flutter/material.dart';
import 'package:svrkxmdvm/pages/AddUser.dart';
import 'package:svrkxmdvm/pages/Developer.dart';
import 'package:svrkxmdvm/pages/SettingsPage.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),     
           Stack(children: [
            Image.asset('assets/icons/drawer.jpg'),
            Container(
              margin:EdgeInsets.only(top: 170),
              child: Center(child: Text('Svrkømdvm Mvrìng 70 Nǿnggøm Zaywàrì',style: TextStyle(fontFamily: 'Barlow',color: Colors.white,fontWeight: FontWeight.bold),)))
           ],),
         
            
            //list title
            Padding(
              padding: const EdgeInsets.only(left: 25.0,top: 0),
              child: ListTile(
                title: const Text('Home',style: TextStyle(fontWeight: FontWeight.bold)),
                leading: const Icon(Icons.home,color: Color.fromARGB(255, 12, 54, 88),),
                onTap: () => Navigator.pop(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,top: 0),
              child: ListTile(
                title: const Text('Settings',style: TextStyle(fontWeight: FontWeight.bold)),
                leading: const Icon(Icons.settings, color:Color.fromARGB(255, 12, 54, 88)),
                onTap: (){
                  //pop drawser 
                  Navigator.pop(context);
        
                  //navigate to setting page
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,top: 0),
              child: ListTile(
                title: const Text('App Developer',style: TextStyle(fontWeight: FontWeight.bold)),
                leading: const Icon(Icons.phone_android,color:Color.fromARGB(255, 12, 54, 88)),
                onTap: (){
                  //pop drawser 
                  Navigator.pop(context);
        
                  //navigate to setting page
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Developer()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,top: 0),
              child: ListTile(
                title: const Text('Admin Panel',style: TextStyle(fontWeight: FontWeight.bold),),
                leading: const Icon(Icons.person,color:Color.fromARGB(255, 12, 54, 88)),
                onTap: (){
                  //pop drawser 
                  Navigator.pop(context);
        
                  //navigate to setting page
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUser()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,top: 0),
              child: ListTile(
                title: const Text('Contact Us',style: TextStyle(fontWeight: FontWeight.bold),),
                leading: const Icon(Icons.contact_mail,color:Color.fromARGB(255, 12, 54, 88)),
                onTap: (){
                  //pop drawser 
                  Navigator.pop(context);
        
                  //navigate to setting page
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUser()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle role() {
    return TextStyle(
      fontFamily: 'Acme',
      fontWeight: FontWeight.bold,
      fontSize: 17,
    );
  }
   TextStyle name() {
    return TextStyle(
      fontFamily: 'Russ',
      fontWeight: FontWeight.bold,
      fontSize: 19,
      color: Color.fromARGB(255, 30, 65, 94)
    );
  }
}