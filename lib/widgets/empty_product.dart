import 'package:flutter/cupertino.dart';
import 'package:grocery_app/services/utils.dart';

class EmptyProductWidget extends StatelessWidget {
  const EmptyProductWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Image.asset('assets/images/box.png'),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: color, fontSize: 40, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
