import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/providers/wishlist_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/text_widgets.dart';
import 'package:grocery_app/wishlist/wishlist_widget.dart';
import 'package:grocery_app/screen/cart/empty_screen.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  static const routeNamed = "/WishlistScreen";
  WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;

    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemList =
        wishlistProvider.getWishlistItems.values.toList().reversed.toList();

    return wishlistItemList.isEmpty
        ? const EmptyScreen(
            title: 'Your Wishlist Is Empty',
            subtitle: 'Explore more and shortlist some items',
            imagePath: 'assets/images/wishlist.png',
            buttonText: 'Add a wish',
          )
        : Scaffold(
            appBar: AppBar(
                centerTitle: true,
                leading: const BackArrow(),
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: TextWidget(
                  text: 'WishList(${wishlistItemList.length})',
                  color: color,
                  textSize: 22,
                  isTitle: true,
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        GlobalMethods.warningDialog(
                            title: 'Empty your wishlist?',
                            subtitle: 'Are you sure?',
                            context: context,
                            fct: () {
                              wishlistProvider.clearWishlist();
                            });
                      },
                      icon: Icon(
                        IconlyBroken.delete,
                        color: color,
                      ))
                ]),
            body: MasonryGridView.count(
              itemCount: wishlistItemList.length,
              crossAxisCount: 2,
              // mainAxisSpacing: 16,
              // crossAxisSpacing: 20,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: wishlistItemList[index],
                    child: const WishlistWidget());
              },
            ));
  }
}
