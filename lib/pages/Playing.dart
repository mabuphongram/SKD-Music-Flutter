import 'package:flutter/material.dart';
import 'package:svrkxmdvm/models/track.dart';

class Playing extends StatefulWidget {
  final Track? track;
  const Playing({super.key,this.track});

  @override
  State<Playing> createState() => _PlayingState(track);
}

class _PlayingState extends State<Playing> {
  Track? track;
  _PlayingState(this.track);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Now Playing'))),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            children: [
          //       Container(
          //   width: 200,
          //   height: 200,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     image: DecorationImage(
          //       fit: BoxFit.cover,
          //       image: AssetImage('assets/images/korea${track?.id}.jpg'),
          //     ),
          //   ),
          // ),
              
              Text(track?.title?? ""),
              Text(track?.singer?? ""),          
              Text(track?.composer?? ""),  
              SizedBox(height: 30,),
               Slider(
                  min: 0,
                  value: 0.7,
                  // max: duration.inSeconds.toDouble(),
                  // value: position.inSeconds.toDouble(),
                  onChanged: (value) async {
                    // final position = Duration(seconds: value.toInt());
                    // await audioPlayer.seek(position);
                    // await audioPlayer.resume();
                  },
                ), 
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('1'),
                      Text('2')
                      // Text(formatTime(position)),
                      // Text(formatTime(duration - position)),
                    ],
                  ),
                ), 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.skip_previous)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.play_arrow_outlined)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.skip_next)),
                ],)     
            ],
          ),
        ),
      ),
    );
  }
}