import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text('Drawer Header')),
          ListTile(
            title: Text('Item1'),
            onTap: (){},
          ),
          ListTile(
            title: Text('Item2'),
            onTap: (){},
          ),
          ListTile(
            title: Text('Item3'),
            onTap: (){},
          )
        ],
      )
    );
  }
}