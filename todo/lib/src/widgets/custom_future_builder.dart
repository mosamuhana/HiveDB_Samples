import 'package:flutter/material.dart';

class CustomFutureBuilder<T> extends StatelessWidget {
  static Widget Function(BuildContext, dynamic) defaultErrorBuilder;
  static Widget Function(BuildContext) defaultLoadingBuilder;

  final Future<T> future;
  final T initialData;
  final Widget Function(BuildContext, T) done;
  final Widget Function(BuildContext, dynamic) error;
  final Widget Function(BuildContext) loading;

  const CustomFutureBuilder({
    Key key,
    this.future,
    this.initialData,
    @required this.done,
    this.error,
    this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      initialData: initialData,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return _buildLoading(context);
        }

        if (snapshot.error != null) {
          return _buildError(context, snapshot.error);
        }

        return done(context, snapshot.data);
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    if (loading != null) {
      return loading(context);
    }

    if (defaultLoadingBuilder != null) {
      return defaultLoadingBuilder(context);
    }

    return Center(child: CircularProgressIndicator());
  }

  Widget _buildError(BuildContext context, dynamic err) {
    print(err);
    if (error != null) {
      return error(context, err);
    }

    if (defaultErrorBuilder != null) {
      return defaultErrorBuilder(context, err);
    }

    return Center(child: Text('Error: ${err.toString()}'));
  }
}
