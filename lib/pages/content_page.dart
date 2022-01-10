import 'package:auto_route/auto_route.dart';
import 'package:auto_route_example/cubits/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContentPage extends StatelessWidget with AutoRouteWrapper {
  final String content;

  const ContentPage(this.content, {Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (_) => CounterCubit(),
        child: this,
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<CounterCubit>().increment(),
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text(content),
        ),
        body: Center(child: BlocBuilder<CounterCubit, int>(
          builder: (context, count) => Text(
              count.toString(),
              style: Theme.of(context).textTheme.headline1,
            ),
        )),
      );
}
