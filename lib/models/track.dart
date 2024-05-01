class Track {
  int? id;
  String? title,singer,composer,type;

  Track({this.id,this.title,this.singer,this.composer,this.type});

  factory Track.fromJson(dynamic data) {
    return Track(
      id: data['id'],
      title: data['title'],
      singer: data['singer'],
      composer: data['composer'],
      type: data['type'],
    );
  }
}