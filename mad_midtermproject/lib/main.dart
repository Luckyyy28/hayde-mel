import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mad_midtermproject/box.dart';
import 'package:mad_midtermproject/homeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  hscore = await Hive.openBox("HighScore");
  runApp(Midterm());
}

class Midterm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FilipiKnows',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
       debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      builder: EasyLoading.init(),
    );
  }
}
