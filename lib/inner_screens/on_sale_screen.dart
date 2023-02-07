import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/models/product_models.dart';
import 'package:grocery_app/providers/products_provider.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_product.dart';
import 'package:grocery_app/widgets/on_sale_widget.dart';
import 'package:grocery_app/widgets/text_widgets.dart';
import 'package:provider/provider.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeNamed = "/OnSaleScreen";
  const OnSaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    final productProvider = Provider.of<ProductProvider>(context);
    List<ProductModel> productOnSale = productProvider.getOnSaleProducts;

    bool _isEmpty = false;
    return Scaffold(
      appBar: AppBar(
        leading: const BackArrow(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Product on sale',
          color: color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: productOnSale.isEmpty
          ? const EmptyProductWidget(
              text: 'No Product on sale yet!\nStay tuned',
            )
          : GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              // crossAxisSpacing: 10,
              childAspectRatio: size.width / (size.height * 0.45),
              children: List.generate(productOnSale.length, (index) {
                return ChangeNotifierProvider.value(
                    value: productOnSale[index], child: OnSaleWidget());
              })),
    );
  }
}
