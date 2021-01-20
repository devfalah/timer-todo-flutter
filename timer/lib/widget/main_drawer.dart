import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timer/screens/todo_screen.dart';
import 'package:timer/widget/drawer_item.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  // ignore: unused_field
  Future<void> _launched;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              duration: Duration(seconds: 1),
              decoration: BoxDecoration(
                color: Colors.grey[900],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[900],
                    radius: 40,
                    backgroundImage:
                        ExactAssetImage("assets/images/app_icon.png"),
                  )
                ],
              )),
          DrawerItem(
            title: " المهام",
            icon: FontAwesomeIcons.clipboardList,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (contex) => TodoScreen(),
                ),
              );
            },
          ),
          DrawerItem(
            title: " شارك التطبيق",
            icon: FontAwesomeIcons.shareAlt,
            onTap: () {},
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.facebook,
                  ),
                  onPressed: () {
                    setState(() {
                      _launched =
                          _launchInBrowser('https://www.facebook.com/devfalah');
                    });
                  }),
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.github,
                  ),
                  onPressed: () {
                    setState(() {
                      _launched =
                          _launchInBrowser('https://github.com/devfalah');
                    });
                  }),
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.instagram,
                  ),
                  onPressed: () {
                    setState(() {
                      _launched = _launchInBrowser(
                          'https://www.instagram.com/devfalah/');
                    });
                  }),
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.twitter,
                  ),
                  onPressed: () {
                    setState(() {
                      _launched =
                          _launchInBrowser('https://twitter.com/devfalah');
                    });
                  }),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
