import 'package:flutter/material.dart';
import 'package:svrkxmdvm/components/NeuBox.dart';
import 'package:svrkxmdvm/pages/SettingsPage.dart';
import 'package:url_launcher/url_launcher.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
     void _launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: SingleChildScrollView(
        child: Column(
          children: [
        
            SizedBox(height: 50,),
           // logo
            // DrawerHeader(
              
            //   child: Center(child: Icon(
            //   Icons.music_note,
            //   size: 40,
            //   color: Theme.of(context).colorScheme.inversePrimary,
            // ),)),
        
            //list title
            Padding(
              padding: const EdgeInsets.only(left: 25.0,top: 0),
              child: ListTile(
                title: const Text('HOME'),
                leading: const Icon(Icons.home),
                onTap: () => Navigator.pop(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,top: 0),
              child: ListTile(
                title: const Text('SETTINGS'),
                leading: const Icon(Icons.settings),
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
                title: const Text('CONTACT US'),
                leading: const Icon(Icons.phone),
                onTap: (){
                  //pop drawser 
                  Navigator.pop(context);
        
                  //navigate to setting page
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
                },
              ),
            ),
            Divider(color: Colors.grey),
            SizedBox(height: 15,),
            Column(
              children: [
                Text('Arrangement & Guitar',style:role(),),
                Text('Yaku RD',style: name(),),
                const SizedBox(height: 10,),
                Text('Bass Guitar',style:role()),
                Text('P Dørvm',style: name()),
                const SizedBox(height: 10,),
                Text('Drummer',style:role()),
                Text('K Ah Søn',style: name()),
                const SizedBox(height: 10,),
                Text('Keyboard',style:role()),
                Text('ZM Rvmsing',style: name()),
                const SizedBox(height: 10,),
                Text('Audio Mixing & Mastering',style:role()),
                Text('Kyaw Gyi',style: name()),
                const SizedBox(height: 10,),
                Text('Studio',style:role()),
                Text('MGL(PTO & YGN)',style: name()),
                Text('LMC',style: name()),
                Text('Bramai',style: name()),
              ],
            ),
            SizedBox(height: 15,),
             Divider(color: Colors.grey),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: () => _launchURL('https://www.facebook.com/mbpong.ram.9'),
              child: NeuBox(child: Column(
                children: [
                 Container(width: 150,
                 child: Column(
                  children: [
                    Text('App Developer',style: TextStyle(fontFamily: 'Acme'),),
                    Text('---------------------------------'),
                    Text('Mvbxq Pongrvm',style: TextStyle(fontFamily: 'Acme'),),
                    Text('( 09954395321 )',style: TextStyle(fontFamily: 'Acme'),),
                    
                  ],
                 ))
                ],
              )),
            )
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