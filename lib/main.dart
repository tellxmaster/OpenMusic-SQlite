import 'package:flutter/material.dart';
import 'package:test_02/src/services/SQLiteService.dart';
import 'package:test_02/src/widgets/FormSong.dart';
import 'package:test_02/src/widgets/ListSong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotifake',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _itemSeleccionado = 0;
  String title = 'Spotifake';

  static const TextStyle _optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    SQLiteService.createDatabase();
  }

  static final List<Widget> _content = <Widget>[SongForm(), SongListScreen()];

  void _onItemTarget(int index) {
    //ONcLICK MENU
    setState(() {
      _itemSeleccionado = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.play_circle),
        ),
      ),
      body: Center(
        //child: _opcionesPantalla.elementAt(_itemSeleccionado),
        child: _content.elementAt(_itemSeleccionado),
      ),
      backgroundColor: Colors.white,
      /*floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),*/
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.my_library_add), label: 'Agregar Canciones'),
          BottomNavigationBarItem(icon: Icon(Icons.my_library_music), label: 'Listado Canciones'),
        ],
        currentIndex: _itemSeleccionado,
        selectedItemColor: Colors.green,
        onTap: _onItemTarget,
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
