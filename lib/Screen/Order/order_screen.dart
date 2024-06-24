import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Widget/sliverAppbar.dart';
import 'delivered_order_display_screen.dart';
import 'order_display_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                sliverAppBar(context,
                    title: '',
                    icon1: IconButton(
                      onPressed: () {
                        // showSearch(context: context, delegate: MySearchDelegate());
                      },
                      icon: const Icon(Icons.search,
                          color: Colors.black, size: 25),
                    ),
                    flexibleChild:
                        const TabBar(indicatorColor: Colors.black, tabs: [
                      Tab(
                        icon: Icon(Icons.delivery_dining),
                        text: 'Orders',
                      ),
                      Tab(
                        icon: Icon(Icons.history),
                        text: 'Delivered',
                      ),
                    ]))
              ];
            },
            body: const TabBarView(
              children: [CurrentOrderDisplay(), DeliveredOrderScreenDisplay()],
            )),
      ),
    );
  }
}
