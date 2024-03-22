import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shovel_smart_afg/settings.dart';
import 'package:shovel_smart_afg/template.dart';
import 'package:shovel_smart_afg/weatherPage.dart';
import 'appState.dart';
import 'package:provider/provider.dart'; 
import 'package:shovel_smart_afg/services/weather_services.dart';
import 'package:shovel_smart_afg/model/weather.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shovel Smart',
      theme: ThemeData(
    
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home'),
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
  int currentIndex = 0;
  
  WeatherService weatherService = WeatherService();
  Weather weather = Weather();

  String currentWeather = "";
  double tempC = 0;
  double tempF = 0;

   @override
  void initState() {
    super.initState();
    getWeather();
  }

  void getWeather() async {
    weather = await weatherService.getWeatherData("01571");

    setState(() {
      currentWeather = weather.condition;
      tempF = weather.temperatureF;
      tempC = weather.temperatureC;
    });
    print(weather.temperatureC);
    print(weather.temperatureF);
    print(weather.condition);
  }
// working on implementing a method to get the user's corrdinates using this tutorial: https://www.youtube.com/watch?v=WVNYG_ESGKo&t=2s

  Future<Position> _getPosition() async{
    LocationPermission permission; 

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission(); 

      if(permission == LocationPermission.deniedForever){
        return Future.error("Location not available"); 
      }
    } else{
      print('Location not available'); 
    }

    return await Geolocator.getCurrentPosition(); 
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /* Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => weatherPage(),
                    ),
                  );
                },
                child: const Text('To weather page'),
              ),
            ),*/

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          
          Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => settings(),
                    ),
                  );
                },
                child: const Text('Settings'),
              ),
            ),
Text("From the api:"),
            Text(currentWeather),
            Text(tempC.toString() + " degrees C"),
            Text(tempF.toString() + " degrees F"),
          ],
        ),
      ),
      //credits to HeyFlutter on Youtube for Navigation Bar Tutorial: https://www.youtube.com/watch?v=xoKqQjSDZ60
      bottomNavigationBar: BottomNavigationBar(
        type : BottomNavigationBarType.fixed,
        backgroundColor : Colors.white,
        unselectedItemColor : const Color.fromRGBO(187, 207, 242, 1),
        selectedItemColor : const Color.fromRGBO(152, 174, 212, 1),
        currentIndex : currentIndex,
        onTap : (index) => setState(() => currentIndex = index),
        items : [
          BottomNavigationBarItem (
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor : const Color.fromRGBO(187, 207, 242, 1), ), //home navigation button
          BottomNavigationBarItem (
            icon: Icon(Icons.cloud),
            label: 'Weather',
            backgroundColor : const Color.fromRGBO(187, 207, 242, 1), ), //weather navigation button
          BottomNavigationBarItem (
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor : const Color.fromRGBO(187, 207, 242, 1), ), //settings navigation button
        ],
      )
    );
  }
}
