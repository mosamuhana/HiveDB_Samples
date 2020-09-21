import 'package:flutter/material.dart';

class FuturePage extends StatelessWidget {
  static Widget Function(BuildContext, dynamic) defaultErrorBuilder;
  static Widget Function(BuildContext) defaultLoadingBuilder;

  final Future future;
  final Widget Function(BuildContext) builder;

  const FuturePage({
    Key key,
    this.future,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return _buildLoading(context);
        }

        if (snapshot.error != null) {
          return _buildError(context, snapshot.error);
        }

        return builder(context);
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    if (defaultLoadingBuilder != null) {
      return defaultLoadingBuilder(context);
    }

    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildError(BuildContext context, dynamic err) {
    print(err);
    if (defaultErrorBuilder != null) {
      return defaultErrorBuilder(context, err);
    }

    return Scaffold(
      body: Center(child: Text('Error: ${err.toString()}')),
    );
  }
}
