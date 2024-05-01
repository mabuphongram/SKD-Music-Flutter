import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:svrkxmdvm/models/track.dart';



class TrackProvider extends ChangeNotifier{
  final List<Track> tracks = [];
  
  Future<List<Track>> loadTrack() async{
    String jsonData  = await rootBundle.loadString('assets/data/track.json');
    var tracks = json.decode(jsonData);
    List<dynamic> trackList = tracks['svrkxmdvm'];
    tracks = trackList.map((track) => Track.fromJson(track)).toList();
    notifyListeners();

    return tracks;

  }


}