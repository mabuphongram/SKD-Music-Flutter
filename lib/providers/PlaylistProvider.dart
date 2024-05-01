import "dart:io";
import 'dart:typed_data';
import "package:audioplayers/audioplayers.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:path_provider/path_provider.dart";
import "package:share/share.dart";
import "package:svrkxmdvm/models/song.dart";

class PlayListProvider extends ChangeNotifier {
  //playlist of songs
  final List<Song> _playlist = [
    //song 1
    Song(
        songName: "Gvray Nemv̀r",
        artistName: "SW Rvmshvr",
        composerName: "composer1",
        imagePath: "assets/images/img_1.png",
        audioPath: "audios/song_1.mp3"),
    Song(
        songName: "vjúrøtshø̀nge",
        artistName: "KD Duno",
        composerName: "composer2",
        imagePath: "assets/images/img_2.png",
        audioPath: "audios/song_2.mp3"),
    Song(
        songName: "Shvlá vtvng lòng",
        artistName: "Chan Zamishvr",
        composerName: "composer3",
        imagePath: "assets/images/img_3.png",
        audioPath: "audios/song_3.mp3"),
    Song(
        songName: "Tu èbùmà",
        artistName: "Mercy Shin",
        composerName: "composer4",
        imagePath: "assets/images/img_4.png",
        audioPath: "audios/song_4.mp3"),
    Song(
        songName: "Vshø̀mgǿ tiq Gvray",
        artistName: "WN Døngang",
        composerName: "composer5",
        imagePath: "assets/images/img_5.png",
        audioPath: "audios/song_5.mp3"),
    Song(
        songName: "Laqyà Shvlá",
        artistName: "KT Zakiu",
        composerName: "composer6",
        imagePath: "assets/images/img_6.png",
        audioPath: "audios/song_6.mp3"),
    Song(
        songName: "Àng Wurtaq",
        artistName: "Chan Kin",
        composerName: "composer7",
        imagePath: "assets/images/img_7.png",
        audioPath: "audios/song_7.mp3"),
    Song(
        songName: "Mòngkà Dvyø̀",
        artistName: "Kong Pong @ YT Yamasu",
        composerName: "composer8",
        imagePath: "assets/images/img_8.png",
        audioPath: "audios/song_8.mp3"),
    Song(
        songName: "Èzø̀mà",
        artistName: "MK Sønwi",
        composerName: "composer9",
        imagePath: "assets/images/img_9.png",
        audioPath: "audios/song_9.mp3"),
    Song(
        songName: "Roqshú Shvlá",
        artistName: "Svrkømdvm Zìlàngrérì",
        composerName: "composer10",
        imagePath: "assets/images/img_10.png",
        audioPath: "audios/song_10.mp3"),
    Song(
        songName: "Gónggi Mvrà",
        artistName: "MJ Burvm",
        composerName: "composer11",
        imagePath: "assets/images/img_11.png",
        audioPath: "audios/song_11.mp3"),
    Song(
        songName: "Shvmná",
        artistName: "MN Lewi",
        composerName: "composer12",
        imagePath: "assets/images/img_12.png",
        audioPath: "audios/song_12.mp3"),
    Song(
        songName: "Nà Móngsv̀ng",
        artistName: "Dsh Døshvr",
        composerName: "composer13",
        imagePath: "assets/images/img_13.png",
        audioPath: "audios/song_13.mp3"),
  ];

  int? _currentSongIndex;
   /* 

  A U D I O P L A Y E R

  */
  //audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  //durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constructor 
  PlayListProvider() {
    listenToDuration();
  }

  //initially not playing 
  bool _isPlaying = false;

  //play the song 
  void play() async {
    final String path = _playlist[currentSongIndex!].audioPath;
    await _audioPlayer.stop(); //stop current song 
    await _audioPlayer.play(AssetSource(path)); // play the new song 
    _isPlaying=true;
    notifyListeners();
  }

  //pause current song 
  void pause() async{
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume playing 
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying=true;
    notifyListeners();
  }

  //pause or resume 
  void pauseOrResume() async{
    if(_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  //seek to a specific position in the current song 
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  //play next song 
  void playNextSong() async {
    if(currentSongIndex !=null){
      if(_currentSongIndex! < _playlist.length-1){
        //go to the next song if it's not the last song 
        currentSongIndex = _currentSongIndex!+1;
        // notifyListeners();

      }else {
        //if it's the last song, loop back to the first song 
        currentSongIndex = 0;
      }
    }
  }

  //play previous song 
  void playPreviousSong() async{
    //if more than 2 seconds have passed,restart the current song 
    if(_currentDuration.inSeconds > 2 ){
      seek(Duration.zero);
    } 
    //if it's within first 2 seconds of the song, go to the previous song 
    else {
      if(_currentSongIndex! > 0 ){
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        //if it's the first song, loop back to the last song 
        currentSongIndex = _playlist.length-1;
      }
    }
  }

  //list to duration
  void listenToDuration(){
    //listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) { 
      _totalDuration = newDuration;
      notifyListeners();
    });
    //listen for current duration
    _audioPlayer.onPositionChanged.listen((newDuration) { 
      _currentDuration = newDuration;
      notifyListeners();
    });

    //listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {playNextSong(); });

  }

  //share audio to other platform 
 void shareCurrentSong() async {
  if (_currentSongIndex != null) {
    final String audioPath = _playlist[_currentSongIndex!].audioPath;
    final String songTitle = _playlist[_currentSongIndex!].songName;

    try {
      final fileBytes = await rootBundle.load('assets/$audioPath');
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/$songTitle.mp3');
      await tempFile.writeAsBytes(
          fileBytes.buffer.asUint8List(fileBytes.offsetInBytes, fileBytes.lengthInBytes));
      print(tempFile.path);
      // Use the share package to share the temporary file
      await Share.shareFiles([tempFile.path], text: 'Check out this cool song: $songTitle');
    } catch (e) {
      print('Error sharing song: $e');
    }
  }
}

  //download audio to my device
Future<void> downloadCurrentSong() async {

  if(_currentSongIndex != null) {
    final String path = 'assets/${_playlist[currentSongIndex!].audioPath}';
  final String songTitle = _playlist[currentSongIndex!].songName;
  // Get the path to the Download folder
  String downloadPath = '/storage/emulated/0/Music';

  // URL of the audio file in your assets folder
  String audioAssetPath = path; // Change this to your audio file path

  try {
    // Load the audio file from assets
    ByteData byteData = await rootBundle.load(audioAssetPath);

    // Create a file in the download directory
    File audioFile = File("$downloadPath/$songTitle.mp3");

    // Write the audio file to the download directory
    await audioFile.writeAsBytes(byteData.buffer.asUint8List());

     Fluttertoast.showToast(
      msg: "Downloading Audio ....",
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.grey.shade600
    );
    // Show toast
    Fluttertoast.showToast(
      msg: "Downloaded audio!",
      backgroundColor: Colors.grey.shade600
    );
  } catch (e) {
    // Handle errors
    print("Error downloading audio: $e");
  }
  }
}

  //dispose audio player


  /* 

  G E T T E R S

  */
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying=> _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

   /* 

  S E T T E R S 
  */
  set currentSongIndex(int? newIndex){
    //update current song index
    _currentSongIndex = newIndex;
    if(newIndex!=null){
      play(); // play the song at the new index
    }

    //update ui
    notifyListeners();
  }
}
