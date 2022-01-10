import 'package:flutter/material.dart';
import 'package:food_delivery/misc/clippers/oval_top_border_clipper.dart';
import 'package:food_delivery/pages/dashboard_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            _imageWidget(),
            _actionWidget(context),
          ],
        ),
      );

  Widget _imageWidget() => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        top: 0,
        child: Image.asset(
          'assets/images/splash.jpeg',
          fit: BoxFit.fitHeight,
        ),
      );

  Widget _actionWidget(BuildContext context) => Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: ClipPath(
          clipper: OvalTopBorderClipper(),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 64.0,
              vertical: 48.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'I Più Veloci Nel Consegnare ',
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                    children: [
                      TextSpan(
                        text: 'Cibo',
                        style: TextStyle(
                          color: Colors.red[700],
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Il nostro obiettivo è riempire la tua pancia con del cibo delizioso consegnando alla velocità della luce.',
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[700],
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 64,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, a1, a2) => const DashboardPage(),
                      transitionsBuilder: (context, a1, a2, child) =>
                          FadeTransition(
                        opacity: a1,
                        child: child,
                      ),
                      transitionDuration: const Duration(
                        milliseconds: 500,
                      ),
                    ),
                  ),
                  child: const Text('Iniziamo!'),
                )
              ],
            ),
          ),
        ),
      );
}
