import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/providers/viewed_prod_provider.dart';
import 'package:grocery_app/screen/cart/empty_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/viewed_recently/viewed_recently_widget.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/text_widgets.dart';
import 'package:provider/provider.dart';

class ViewedRecentlyScreen extends StatefulWidget {
  // static const routeNamed = '/ViewedRecentlyScreen';

  static const routeName = '/ViewedRecentlyScreen';

  const ViewedRecentlyScreen({Key? key}) : super(key: key);

  @override
  _ViewedRecentlyScreenState createState() => _ViewedRecentlyScreenState();
}

class _ViewedRecentlyScreenState extends State<ViewedRecentlyScreen> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;

    Size size = Utils(context).getScreenSize;

    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    final viewedProdItemList = viewedProdProvider.getViewedProdlistItems.values
        .toList()
        .reversed
        .toList();

    //      final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    // final viewedProdItemsList = viewedProdProvider.getViewedProdlistItems.values
    //     .toList()
    //     .reversed
    //     .toList();

    if (viewedProdItemList.isEmpty) {
      return const EmptyScreen(
        title: 'Your history is empty',
        subtitle: 'No products has been viewed yet!',
        buttonText: 'Shop now',
        imagePath: 'assets/images/history.png',
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                GlobalMethods.warningDialog(
                    title: 'Empty your history?',
                    subtitle: 'Are you sure?',
                    fct: () {},
                    context: context);
              },
              icon: Icon(
                IconlyBroken.delete,
                color: color,
              ),
            )
          ],
          leading: const BackArrow(),
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: TextWidget(
            text: 'History',
            color: color,
            textSize: 24.0,
          ),
          backgroundColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        ),
        body: ListView.builder(
            itemCount: viewedProdItemList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                child: ChangeNotifierProvider.value(
                    value: viewedProdItemList[index],
                    child: ViewedRecentlyWidget()),
              );
            }),
      );
    }
  }
}
