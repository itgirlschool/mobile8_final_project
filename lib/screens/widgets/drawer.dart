import 'package:flutter/material.dart';

import '../login_screen.dart';
import '../orders_history_screen.dart';
import '../profile_screen.dart';
import '../support_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              )
            ],
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 10,),
                Text('Профиль'),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.list),
                SizedBox(width: 10,),
                Text('Заказы'),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrdersHistoryScreen()),
              );
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.chat_bubble_outline),
                SizedBox(width: 10,),
                Text('Поддержка'),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SupportScreen()),
              );
            },
          ),
          ListTile(
              title: const Row(
                children: [
                  Icon(Icons.exit_to_app),
                  SizedBox(width: 10,),
                  Text('Выйти'),
                ],
              ),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              }),
        ],
      ),
    );
  }
}