import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NavegacionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NotificationModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text('Notifications Page'),
        ),
        floatingActionButton: BotonFlotante(),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int numero = Provider.of<_NotificationModel>(context).numero;

    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.pink,
      items: [
        BottomNavigationBarItem(
          title: Text('Bones'),
          icon: FaIcon(FontAwesomeIcons.bone),
        ),
        BottomNavigationBarItem(
          title: Text('Notifications'),
          icon: Stack(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.bell),
              Positioned(
                top: 0,
                right: 0,
                child: BounceInDown(
                  from: 10,
                  animate: numero > 0 ? true : false,
                  child: Bounce(
                    from: 10,
                    controller: (controller) => Provider.of<_NotificationModel>(context).bounceController = controller,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                          color: Colors.redAccent, shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: Text(
                        '$numero',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        BottomNavigationBarItem(
          title: Text('My Dog'),
          icon: FaIcon(FontAwesomeIcons.dog),
        ),
      ],
    );
  }
}

class BotonFlotante extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.pink,
      child: FaIcon(FontAwesomeIcons.play),
      onPressed: () {

        final notiModel = Provider.of<_NotificationModel>(context, listen: false);

        int numero =
            notiModel.numero;
        numero++;
        notiModel.numero = numero;

        if(numero >= 2) {
          final controller = notiModel.bounceController;
          controller.forward(from: 0.0);
        }

      },
    );
  }
}

class _NotificationModel with ChangeNotifier {
  int _numero = 0;

  AnimationController _bounceController;

  int get numero => _numero;
  set numero(int n) {
    _numero = n;
    notifyListeners();
  }

  AnimationController get bounceController => _bounceController;
  set bounceController(AnimationController controller) {
    _bounceController = controller;
  }

}
