import 'package:flutter/material.dart';

class CountdownList extends StatefulWidget {
  const CountdownList({Key? key}) : super(key: key);

  @override
  _CountdownListState createState() => _CountdownListState();
}

class _CountdownListState extends State<CountdownList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Coundown List"),
      ),
    );
  }
}
