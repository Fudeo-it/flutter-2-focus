import 'package:flutter/material.dart';
import 'package:food_delivery/app.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'flavors.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  F.appFlavor = Flavor.FOODIE;

  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(const App()),
    storage: storage,
  );
}
