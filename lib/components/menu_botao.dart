import 'package:flutter/material.dart';

class BotaoMenu extends StatelessWidget {
  final String _action;
  final IconData _icon;
  final Function() onClick;

  BotaoMenu(this._action, this._icon, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8),
        child: Material(
          color: Theme.of(context).primaryColor,
          child: InkWell(
              onTap: onClick,
              child: Container(
                padding: EdgeInsets.all(8),
                width: 150,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      _icon,
                      color: Colors.white,
                      size: 24,
                    ),
                    Text(_action,
                        style: TextStyle(color: Colors.white, fontSize: 16))
                  ],
                ),
              )),
        ));
  }
}
