import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/orders/order_screen.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/viewed_recently/viewed_recently_screen.dart';
import 'package:grocery_app/widgets/text_widgets.dart';
import 'package:grocery_app/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController =
      TextEditingController(text: "");
  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              RichText(
                  text: TextSpan(
                      text: "Hi, ",
                      style: const TextStyle(
                        color: Colors.cyan,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                    TextSpan(
                      text: 'My Name',
                      style: TextStyle(
                        color: color,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ])),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                text: 'Rawmizthapa@gmail.com',
                color: color,
                textSize: 22,
                // isTitle: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 20,
              ),
              _listTiles(
                  title: 'Address 2',
                  subtitle: 'My Address',
                  icon: IconlyLight.profile,
                  onPressed: () async {
                    await showAddressDialog(context);
                  },
                  color: color),
              _listTiles(
                  title: 'Orders',
                  icon: IconlyLight.bag,
                  onPressed: () {
                    GlobalMethods.navigateTo(
                        ctx: context, routeName: OrdersScreen.routeName);
                  },
                  color: color),
              _listTiles(
                  title: 'Wishlists',
                  icon: IconlyLight.heart,
                  onPressed: () {
                    GlobalMethods.navigateTo(
                        ctx: context, routeName: WishlistScreen.routeNamed);
                  },
                  color: color),
              _listTiles(
                  title: 'Views',
                  icon: IconlyLight.show,
                  onPressed: () {
                    GlobalMethods.navigateTo(
                        ctx: context,
                        routeName: ViewedRecentlyScreen.routeName);
                  },
                  color: color),
              SwitchListTile(
                title: TextWidget(
                  text: themeState.getDarkTheme ? "Dark Mode" : "Light Mode",
                  color: color,
                  textSize: 18,
                  // isTitle: true,
                ),
                secondary: Icon(themeState.getDarkTheme
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined),
                onChanged: (bool value) {
                  setState(() {
                    themeState.setDarkTheme = value;
                  });
                },
                value: themeState.getDarkTheme,
              ),
              _listTiles(
                  title: 'Forget password',
                  icon: IconlyLight.unlock,
                  onPressed: () {},
                  color: color),
              _listTiles(
                  title: 'Logout',
                  icon: IconlyLight.logout,
                  onPressed: () async {
                    await GlobalMethods.warningDialog(
                        title: 'Logout',
                        subtitle: 'Do you wanna logout?',
                        context: context,
                        fct: () {});
                  },
                  color: color),
            ],
          ),
        )),
      ),
    );
  }

  Future<dynamic> showAddressDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update'),
            content: TextField(
              controller: _addressTextController,
              maxLines: 5,
              onChanged: ((value) {
                print(_addressTextController.text);
              }),
              decoration: const InputDecoration(hintText: "Your Address"),
            ),
            actions: [TextButton(onPressed: () {}, child: Text("Update"))],
          );
        });
  }
}

Widget _listTiles({
  required String title,
  String? subtitle,
  required IconData icon,
  required Function onPressed,
  required Color color,
}) {
  return ListTile(
    title: TextWidget(
      text: title,
      color: color,
      textSize: 22,
      // isTitle: true,
    ),
    subtitle: TextWidget(
      text: subtitle == null ? "" : subtitle,
      color: color,
      textSize: 18,
    ),
    leading: Icon(icon),
    trailing: const Icon(IconlyLight.arrowRight2),
    onTap: () {
      onPressed();
    },
  );
}
