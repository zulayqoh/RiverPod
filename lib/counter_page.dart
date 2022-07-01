import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/main.dart';


class CounterPage extends ConsumerWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int counter = ref.watch(counterProvider);
    final AsyncValue<int> counters = ref.watch(countersProvider);
    ref.listen(counterProvider, (previous, next) {
      if (next == 5) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('WARNING'),
                content: Text('Counter equals 5! Consider resetting counter'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        ref.refresh(counterProvider);
                      },
                      child: Text('Reset')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Continue'))
                ],
              );
            });
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
        actions: [
          IconButton(
              onPressed: () {
                ref.refresh(counterProvider);
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(counter.toString(),
                style: Theme.of(context).textTheme.displayMedium),
            Text(counters.when(data: (data) => data, error: (e, _) => e , loading: () => 0) .toString(),
                style: Theme.of(context).textTheme.displayMedium),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
