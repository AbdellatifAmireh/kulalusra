import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kulalusra/screens/home_page.dart';

void main() {
  //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  /*SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.amber,
      statusBarBrightness: Brightness.dark,
    ),
  );*/
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      //statusBarColor: Colors.white, // Color for Android
      statusBarBrightness:
          Brightness.dark, // Dark == white status bar -- for IOS.
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const HomePage(),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

//------------------------------------------
class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
