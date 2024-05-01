import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svrkxmdvm/components/Drawser.dart';
import 'package:svrkxmdvm/models/song.dart';
import 'package:svrkxmdvm/pages/AddUser.dart';
import 'package:svrkxmdvm/pages/Song.dart';
import 'package:svrkxmdvm/providers/PlaylistProvider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final dynamic playlistProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //get playlist provider
    playlistProvider = Provider.of<PlayListProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    //update current song index
    playlistProvider.currentSongIndex = songIndex;

    //navigate to song page
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SongPage()));
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      // drawer: const MyDrawer(),
      // appBar: AppBar(
      //   elevation: 0,
      //   leading: IconButton(
      //       onPressed: () {
      //         _scaffoldKey.currentState?.openDrawer();
      //       },
      //       icon: Icon(Icons.grid_view)),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => AddUser()));
      //         },
      //         icon: Icon(Icons.add))
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25,right: 28),
        child: Consumer<PlayListProvider>(
          builder: (context, value, child) {
            //get the playlist
            final List<Song> playlist = value.playlist;
            return Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Center(child: Text('ဝယ်ယူအားပေးမှုအတွက် အထူးကျေးဇူးတင်ပါသည်')),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: GridView.builder(
                        itemCount: playlist.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 8,
                            childAspectRatio: 0.9
                            ),
                        itemBuilder: (context, index) =>
                            _buildCard(playlist[index], index)))
              ],
            );
          },
        ),
      ),
    );
  }

  GestureDetector _buildCard(song, index) {
    return GestureDetector(
      onTap: () {
        goToSong(index);
      },
      child: Card(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('${song.imagePath}'),
                ),
              ),
            ),
            Text(
              '${song.songName}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text('${song.artistName}'),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [

            //     IconButton(onPressed: (){

            //     }, icon: Icon(Icons.file_download_outlined,size: 20,)),
            //     IconButton(onPressed: (){

            //     }, icon: Icon(Icons.share_sharp,size: 18,)),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
