import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer/screens/selection.dart';
import 'package:workout_timer/services/data_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>SelectionData(),
      child: MaterialApp(
        title: 'Workout Timer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const SelectionScreen(hr: 0, min: 0, sec: 0, rep: 0,),
      ),
    );
  }
}
