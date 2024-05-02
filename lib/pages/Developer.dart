import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svrkxmdvm/components/NeuBox.dart';
import 'package:svrkxmdvm/components/Painter.dart';
import 'package:svrkxmdvm/themes/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Developer extends StatefulWidget {
  const Developer({super.key});

  @override
  State<Developer> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<Developer> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          title: Text('App Developer'),
        ),
        body: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: ClipPath(
                clipper: WaveCliper(),
                child: Container(
                  color: Color.fromARGB(255, 30, 65, 94),
                  height: 300,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / 8, vertical: size.height / 4),
              child: NeuBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                        child: Image.asset(
                      'assets/icons/mbpongram.png',
                      width: 100,
                    )),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async{
                               
                            },
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.facebook,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('MB Phong Ram'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: ()  {
                                 
                             
                            },
                            child: Row(
                              //  mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.green.shade500,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('09954395321'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              final Uri emailLaunchUri = Uri(
                                scheme: 'mailto',
                                path: 'mabuphongram171@.com',
                                query: encodeQueryParameters(<String, String>{
                                  'subject':
                                      'Example Subject & Symbols are allowed!',
                                }),
                              );
                              launchUrl(emailLaunchUri);
                            },
                            child: Row(
                              //  mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.email,
                                  color: Colors.purpleAccent,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('mabuphongram171@gmail.com'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
        //
        );
  }
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

