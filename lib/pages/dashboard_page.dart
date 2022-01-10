import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/cubits/dark_mode_cubit.dart';
import 'package:food_delivery/mocks.dart';
import 'package:food_delivery/pages/food_page.dart';
import 'package:food_delivery/widgets/bab_item.dart';
import 'package:food_delivery/widgets/food_app_bar.dart';
import 'package:food_delivery/widgets/food_item.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<DarkModeCubit, bool>(
        builder: (context, darkModeEnabled) => Scaffold(
          extendBodyBehindAppBar: true,
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.search,
            ),
            elevation: 2.0,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: _bottomAppBar(),
          appBar: FoodAppBar(
            child: _appBar(),
          ),
          body: _body(context),
          drawer: _drawer(
            context,
            darkModeEnabled: darkModeEnabled,
          ),
        ),
      );

  Widget _appBar() => Builder(
      builder: (context) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.menu),
                  padding: const EdgeInsets.all(8),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.place,
                    color: Theme.of(context).primaryColor,
                    size: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Roma, Lazio',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 10,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.person),
                padding: const EdgeInsets.all(8),
              ),
            ],
          ));

  Widget _drawer(
    BuildContext context, {
    bool darkModeEnabled = false,
  }) =>
      Drawer(
        child: ListView(
          children: [
            _accountHeader(
              context,
              darkModeEnabled: darkModeEnabled,
            ),
          ],
        ),
      );

  Widget _accountHeader(
    BuildContext context, {
    bool darkModeEnabled = false,
  }) =>
      Stack(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.transparent),
            accountName: Text(
              'Angelo Cassano',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            accountEmail: Text(
              'angelo.cassano@example.it',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            currentAccountPicture: CircleAvatar(
                child: Text(
                  'AC',
                  style: Theme.of(context).textTheme.headline6,
                ),
                backgroundColor: Theme.of(context).primaryColor),
          ),
          Positioned(
            right: 4,
            top: 4,
            child: IconButton(
              onPressed: () => context.read<DarkModeCubit>().toggle(),
              icon: Icon(
                darkModeEnabled ? Icons.wb_sunny : Icons.brightness_3,
              ),
            ),
          )
        ],
      );

  Widget _body(BuildContext context) => ListView(
        padding: const EdgeInsets.only(
          top: 128,
          bottom: 16,
        ),
        children: [
          _jumbotron(context),
          _categories(context),
          _popularNow(context),
        ],
      );

  Widget _jumbotron(BuildContext context) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        elevation: 0,
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                  vertical: 24.0,
                ),
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'I Più Veloci Nel Consegnare ',
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        children: [
                          TextSpan(
                            text: 'Cibo',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                        ),
                        onPressed: () {},
                        child: const Text('Ordina Ora'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(child: Image.asset('assets/images/on_the_way.png')),
          ],
        ),
      );

  Widget _categories(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Categorie',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              height: 50,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                itemBuilder: (_, index) => Mocks.categories[index],
                separatorBuilder: (_, __) => Container(width: 16),
                itemCount: Mocks.categories.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      );

  Widget _popularNow(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Popolari',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Text(
                    'Mostra tutto',
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 4),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Icon(
                      FontAwesomeIcons.chevronRight,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 4,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 16),
                height: 240,
                child: () {
                  onTap() => Navigator.of(context).push(
                        PageRouteBuilder(
                            pageBuilder: (context, a1, a2) => const FoodPage(),
                            transitionsBuilder: (context, a1, a2, child) {
                              const begin = Offset(
                                1.0,
                                0.0,
                              );
                              const end = Offset.zero;
                              const curve = Curves.ease;

                              final tween = Tween(begin: begin, end: end).chain(
                                CurveTween(curve: curve),
                              );

                              return SlideTransition(
                                position: a1.drive(tween),
                                child: child,
                              );
                            }),
                      );

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    itemBuilder: (_, index) => Mocks.foods[index].copyWith(
                      onTap: onTap,
                    ),
                    separatorBuilder: (_, __) => Container(width: 8),
                    itemCount: Mocks.foods.length,
                    scrollDirection: Axis.horizontal,
                  );
                }()),
          ],
        ),
      );

  Widget _bottomAppBar() => BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              BottomAppBarItem(
                icon: Icons.dashboard,
                selected: true,
                onTap: () {},
              ),
              BottomAppBarItem(
                icon: Icons.favorite_border,
                onTap: () {},
              ),
              BottomAppBarItem.spacer(),
              BottomAppBarItem(
                icon: Icons.notifications_outlined,
                onTap: () {},
              ),
              BottomAppBarItem(
                icon: Icons.shopping_cart_outlined,
                count: 4,
                onTap: () {},
              ),
            ],
          ),
        ),
        shape: const CircularNotchedRectangle(),
      );
}
