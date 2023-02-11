import 'package:flutter/material.dart';
import '../models/Song.dart';
import '../services/SQLiteService.dart';
import 'dart:developer' as developer;

class SongListScreen extends StatefulWidget {
  SongListScreen({Key? key}) : super(key: key);

  @override
  _SongListScreenState createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  List<Song> _songs = [];

  @override
  void initState() {
    super.initState();
    _listSongs();
  }

  Future<void> _listSongs() async {
    // Call the service method here to get the list of songs
    List<Song> result = await SQLiteService.listSongs();
    setState(() {
      _songs = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _songs.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            leading: Icon(Icons.audiotrack),
            title: Text(_songs[index].title),
            subtitle: Text(_songs[index].artist + " - " + _songs[index].album),
            trailing: Icon(Icons.more_vert),
            onTap: (){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Reproduciendo...'),
                ),
              );
            },

        );
      },
    );
  }
}
