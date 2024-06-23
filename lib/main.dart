import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_toe/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(

    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play("music.ogg");
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home:  const HomeScreen(),
    );
  }
}
/*
//import'package:flutter/material.dart';
class drpdwn extends StatefulWidget {
  @override
  _drpdwnState createState() => _drpdwnState();
}

class _drpdwnState extends State<drpdwn> {
  String? dropdownValue = 'Green';
  List<String> dropdownItems = <String>[
    'Green',
    'Red',
    'Yellow',
    'Blue',
    "Pink",
    "Orange"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: _getColor(dropdownValue!),
        child: Center(
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 36,
            elevation: 8,
            style: TextStyle(color: Colors.deepPurple, fontSize: 36),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Color _getColor(String _color) {
    if (_color.compareTo("Green") == 0) {
      return Colors.green;
    } else if (_color.compareTo("Red") == 0) {
      return Colors.red;
    } else if (_color.compareTo("Yellow") == 0) {
      return Colors.yellow;
    } else if (_color.compareTo("Pink") == 0) {
      return Colors.pink;
    } else if (_color.compareTo("Orange") == 0) {
      return Colors.orange;
    } else if (_color.compareTo("Blue") == 0) {
      return Colors.blue;
    } else {
      return Colors.white;
    }
  }
}


 */
