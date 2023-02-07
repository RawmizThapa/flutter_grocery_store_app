import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/screen/cart/cart_widget.dart';
import 'package:grocery_app/screen/cart/empty_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widgets.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;

    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemList =
        cartProvider.getCartItems.values.toList().reversed.toList();

    //        final cartProvider = Provider.of<CartProvider>(context);
    // final cartItemsList =
    //     cartProvider.getCartItems.values.toList().reversed.toList();

    return cartItemList.isEmpty
        ? const EmptyScreen(
            title: 'Your cart is empty!',
            subtitle: 'Add something and make me happy!!',
            buttonText: 'Browse Products',
            imagePath: 'assets/images/cart.png',
          )
        // ignore: dead_code
        : Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: TextWidget(
                  text: 'Cart(${cartItemList.length})',
                  color: color,
                  textSize: 22,
                  isTitle: true,
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        GlobalMethods.warningDialog(
                            title: 'Empty your cart?',
                            subtitle: 'Are you sure?',
                            context: context,
                            fct: () {
                              cartProvider.clearCart();
                            });
                      },
                      icon: Icon(
                        IconlyBroken.delete,
                        color: color,
                      ))
                ]),
            body: Column(
              children: [
                _checkout(ctx: context),
                Expanded(
                  child: ListView.builder(
                      itemCount: cartItemList.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: cartItemList[index],
                            child: CartWidget(
                              q: cartItemList[index].quantity,
                            ));
                      }),
                ),
              ],
            ),
          );
  }

  Widget _checkout({required BuildContext ctx}) {
    Size size = Utils(ctx).getScreenSize;
    final Color color = Utils(ctx).color;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            Material(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                    text: 'Order Now',
                    color: Colors.white,
                    textSize: 20,
                  ),
                ),
              ),
            ),
            const Spacer(),
            FittedBox(
              child: TextWidget(
                text: 'Total: \$8.90',
                color: color,
                textSize: 18,
                isTitle: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
