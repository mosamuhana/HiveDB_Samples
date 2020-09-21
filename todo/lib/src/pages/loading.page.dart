import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  final Widget child;

  const LoadingPage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: child ?? CircularProgressIndicator(),
      ),
    );
  }
}
