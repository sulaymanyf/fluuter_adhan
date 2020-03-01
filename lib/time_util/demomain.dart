import 'package:flutter/material.dart';
import 'package:flutter_adhan/time_util/calculation_method.dart';
import 'package:flutter_adhan/time_util/calculation_parameters.dart';
import 'package:flutter_adhan/time_util/coordinates.dart';
import 'package:flutter_adhan/time_util/data/date_components.dart';
import 'package:flutter_adhan/time_util/enum_class/calculation_method_names.dart';
import 'package:flutter_adhan/time_util/enum_class/madhab.dart';
import 'package:flutter_adhan/time_util/paryer_times.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paryer Time',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Paryer Time'),
    );
  }
}

class ParyerTime extends StatefulWidget {
  @override
  createState() => new ParyerTimeState();
}

class ParyerTimeState extends State<ParyerTime> {
  PrayerTimes prayerTimes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final Coordinates coordinates = new Coordinates(24.46, 118.1);
    var time = DateTime.now();
    final DateComponents dateComponents =
        DateComponents(time.year, time.month, time.day);
    final CalculationParameters parameters =
        CalculationMethod.getCalculationMethodParams(
            CalculationMethodNames.NORTH_AMERICA);
    parameters.madhab = Madhab.HANAFI;
    var dateTime = DateTime.now();
    prayerTimes = PrayerTimes(coordinates, dateComponents, parameters);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
//        Card(
//          child: ListTile(
//            leading: FlutterLogo(),
//            title: Text('fajr                 '+formatDate(this.prayerTimes.fajr,[HH, ':', nn,])),
//          ),
//        ),
//        Card(
//          child: ListTile(
//            leading: FlutterLogo(),
//            title: Text('sunrise          '+formatDate(this.prayerTimes.sunrise,[HH, ':', nn,])),
//          ),
//        ),
//        Card(
//          child: ListTile(
//            leading: FlutterLogo(),
//            title: Text('dhuhr             '+formatDate(this.prayerTimes.dhuhr,[HH, ':', nn,])),
//          ),
//        ),
//        Card(
//          child: ListTile(
//            leading: FlutterLogo(),
//            title: Text('asr                  '+formatDate(this.prayerTimes.asr,[HH, ':', nn,])),
//          ),
//        ),
//        Card(
//          child: ListTile(
//            leading: FlutterLogo(),
//            title: Text('maghrib         '+formatDate(this.prayerTimes.maghrib,[HH, ':', nn,])),
//          ),
//        ),
//        Card(
//          child: ListTile(
//            leading: FlutterLogo(),
//            title: Text('isha                '+formatDate(this.prayerTimes.isha,[HH, ':', nn,])),
//          ),
//        ),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new ParyerTime(),
      )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// Text(
//                "fajr : " +this.prayerTimes.fajr.toString()
//            ),
//            Text(
//                "sunrise : " +this.prayerTimes.sunrise.toString()
//            ),
//            Text(
//                "dhuhr : " +this.prayerTimes.dhuhr.toString()
//            ),
//            Text(
//                "asr : " +this.prayerTimes.asr.toString()
//            ),
//            Text(
//                "maghrib : " +this.prayerTimes.maghrib.toString()
//            ),
//            Text(
//                "isha : " +this.prayerTimes.isha.toString()
//            ),
