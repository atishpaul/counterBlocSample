import 'package:flutter/material.dart';

import 'counterBloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'Bloc Pattern Counter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counterBloc = CounterBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

@override
  void dispose() {
  counterBloc.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('WIDGET TREE');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',style: Theme.of(context).textTheme.bodyText1,
            ),
            StreamBuilder<int>(
              stream: counterBloc.streamState,
              initialData: 0,
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data.toString()}',
                  style: Theme.of(context).textTheme.headline1,
                );
              }
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            color: Color(0xFFcaf7e3),
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: FloatingActionButton(
                    elevation: 2,
                    onPressed: () {
                      counterBloc.sinkEvent.add(CounterAction.Increment);
                    },
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
                  ),
                ),
                Expanded(
                  child: FloatingActionButton(
                    elevation: 2,
                    onPressed: () {
                      counterBloc.sinkEvent.add(CounterAction.Decrement);
                    },
                    tooltip: 'Decrement',
                    child: Icon(Icons.remove),
                  ),
                ),
                Expanded(
                  child: FloatingActionButton(
                    elevation: 2,
                    onPressed: () {
                      counterBloc.sinkEvent.add(CounterAction.Reset);
                    },
                    tooltip: 'Reset',
                    child: Icon(Icons.restore),
                  ),
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
