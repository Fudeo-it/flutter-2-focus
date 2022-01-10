import 'package:flutter/material.dart';
import 'package:social_network/misc/bubble_indicator_painter.dart';
import 'package:social_network/pages/widgets/sign_in.dart';
import 'package:social_network/pages/widgets/sign_up.dart';
import 'package:social_network/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late PageController _pageController;

  Color signInColor = Colors.black;
  Color signUpColor = Colors.white;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  CustomTheme.gradientStart,
                  CustomTheme.gradientEnd,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 1.0),
              ),
            ),
            child: Column(
              children: [
                _logoWidget(),
                _selectorWidget(),
                _pageViewWidget(),
              ],
            ),
          ),
        ),
      );

  Widget _logoWidget() => Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Image(
          image: AssetImage('assets/images/login_logo.png'),
          height: 100.0,
        ),
      );

  Widget _selectorWidget() => Container(
        width: 300.0,
        height: 50.0,
        margin: const EdgeInsets.only(top: 32.0),
        decoration: const BoxDecoration(
          color: Color(0x552B2B2B),
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
        child: CustomPaint(
          painter: BubbleIndicatorPainter(pageController: _pageController),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      Colors.transparent,
                    ),
                  ),
                  child: Text(
                    'Accedi',
                    style: TextStyle(
                      color: signInColor,
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () => _pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.decelerate,
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      Colors.transparent,
                    ),
                  ),
                  child: Text(
                    'Registrati',
                    style: TextStyle(
                      color: signUpColor,
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () => _pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.decelerate,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _pageViewWidget() => Expanded(
        child: PageView(
          onPageChanged: (index) {
            setState(() {
              signInColor = index == 0 ? Colors.black : Colors.white;
              signUpColor = index == 1 ? Colors.black : Colors.white;
            });
          },
          controller: _pageController,
          children: const [
            SignIn(),
            SignUp(),
          ],
        ),
      );
}
