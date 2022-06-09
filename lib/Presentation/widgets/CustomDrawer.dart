import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = SharedPreferences.getInstance();
    return Container(
      margin: EdgeInsets.all(10),
      child: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Center(
              child: SizedBox(
                height: 250,
                child: DrawerHeader(
                  child: Column(
                    children: [
                      CircleAvatar(
                        // backgroundImage: NetworkImage(
                        //     'https://images.unsplash.com/photo-1575361204480-aadea25e6e68?ixlib=rb-1.2.1&w=1080&fit=max&q=80&fm=jpg&crop=entropy&cs=tinysrgb'),
                        radius: 50,
                      ),
                      SizedBox(height: 25),
                      Text('nmae',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 10),
                      Text('rooney@gmail.com',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 15,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            CustomDivider(),
            ListTile(
              leading: const Icon(Icons.home),
              trailing: Icon(
                Icons.navigate_next_outlined,
                color: Colors.grey.shade600,
              ),
              title: const Text('Home'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushNamed(context, '/home');
              },
            ),
            CustomDivider(),
            ListTile(
              leading: const Icon(Icons.person),
              trailing: Icon(
                Icons.navigate_next_outlined,
                color: Colors.grey.shade600,
              ),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile'); // /login
              },
            ),
            CustomDivider(),
          ],
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0,
      thickness: 0.05,
      indent: 20,
      endIndent: 20,
      color: Colors.grey.shade600,
    );
  }
}
