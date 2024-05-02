import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svrkxmdvm/components/NeuBox.dart';
import 'package:svrkxmdvm/providers/PlaylistProvider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});



    // convert duration to min: second
  String formatTime(Duration duration){
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2,'0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(
      builder: (context, value, child) {
        //get playlist 
        final playlist = value.playlist;

        //get current song index
        final currentSong = playlist[value.currentSongIndex?? 0];

        //return scaffold ui
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //app bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () =>Navigator.pop(context), icon: Icon(Icons.arrow_back)),
                        Text('N O W   P L A Y I N G',style: TextStyle(color: Color.fromARGB(255, 30, 65, 94),fontWeight: FontWeight.bold),),
                        IconButton(onPressed: (){ value.shareCurrentSong();}, icon: Icon(
                                        Icons.share_sharp,
                                       
                                        color:Color.fromARGB(255, 30, 65, 94),
                                      ),),
                      ],
                    ),
                    const SizedBox(height: 27,),
                    //album artwork
                    NeuBox(
                        child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset('assets/images/background.jpg')),
                        const SizedBox(height: 5,),
                        //song and artist name
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentSong.songName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                                 const SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Icon(Icons.mic,size: 22,color: Colors.purple,),
                                    SizedBox(width: 6,),
                                    Text(currentSong.artistName)
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Icon(Icons.note_alt_outlined,size: 20,color: Colors.pinkAccent,),
                                    SizedBox(width: 6,),
                                    Text(currentSong.composerName)
                                  ],
                                ),
                                
                              ],
                            ),
                            //download icon
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  SizedBox(height: 40,),
                                  Row(
                                    children: [
                                      const SizedBox(width: 40,),
                                     IconButton(onPressed: (){
                                      value.downloadCurrentSong();
                                     }, icon: Icon(
                                    Icons.file_download_outlined,
                                     size: 30,
                                    color:Color.fromARGB(255, 30, 65, 94),
                                  ),)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
                    const SizedBox(
                      height: 25,
                    ),
                    //song duration progress
                    Column(
                      children: [
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //start time
                              Text(formatTime(value.currentDuration)),
                              //shuffule icon
                            //  const Icon(Icons.file_download_outlined,size: 27,),
                            //   //repeat icon
                            //   const Icon(Icons.share_sharp),
                              //endtime
                              Text(formatTime(value.totalDuration))
                            ],
                          ),
                        ),
              
                        //song duration progress
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 6)),
                          child: Slider(
                            activeColor: Color.fromARGB(255, 30, 65, 94),
                            min: 0,
                            max: value.totalDuration.inSeconds.toDouble(),
                            value: value.currentDuration.inSeconds.toDouble(),
                            onChanged: (double double) {
                              //during when the user is sliding around
                            
                            
                            },
                            onChangeEnd: (double double) {
                              //sliding has finished, go to that position in song duration
                            value.seek(Duration(seconds: double.toInt()));
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
              
                    //playback control
                    Row(
                      children: [
                        //skip previous
                        Expanded(child: GestureDetector(
                          onTap: value.playPreviousSong,
                          child: NeuBox(child: Icon(Icons.skip_previous)))),
                        const SizedBox(width: 20,),
                        //play and pause
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: value.pauseOrResume,
                            child: NeuBox(
                              child: Icon(
                                (value.isPlaying)? Icons.pause: Icons.play_arrow
                              )
                              )
                              )
                              ),
                         const SizedBox(width: 20,),
                        //skip next
                        Expanded(child: GestureDetector(
                          onTap: value.playNextSong,
                          child: NeuBox(child: Icon(Icons.skip_next))))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
