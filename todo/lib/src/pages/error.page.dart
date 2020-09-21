import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final dynamic error;

  const ErrorPage({Key key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _error ?? Text('Error'),
      ),
    );
  }

  Widget get _error {
    if (error == null) return null;
    return Text(
      'Error: ${error.toString()}',
      style: TextStyle(color: Colors.red),
    );
  }
}
