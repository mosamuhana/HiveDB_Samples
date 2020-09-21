import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../hive.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive Counter Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            SizedBox(height: 8),
            ValueListenableBuilder<Box<int>>(
              valueListenable: hive.counter.listenable(),
              builder: (context, box, _) {
                return Text(
                  'Counter: ${HiveCounter.counter}',
                  style: Theme.of(context).textTheme.headline5,
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => HiveCounter.counter--,
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
          SizedBox(
            width: 8,
          ),
          FloatingActionButton(
            onPressed: () => HiveCounter.counter++,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  final text = kIsWeb ? 'Refresh this tab to test persistence' : 'Restart the app to test persistence';
}

const COUNTER = 'counter';
