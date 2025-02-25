import 'package:dwigasindo/views/menus/component_sales/component_proyeksi_profit.dart';
import 'package:flutter/material.dart';
import 'package:dwigasindo/views/menus/component_sales/component_data_master_customer.dart';
import 'package:dwigasindo/views/menus/component_sales/component_menu_catatan_master_customer.dart';
import 'package:dwigasindo/views/menus/component_sales/component_menu_produk_master_customer.dart';

class ComponentMenuDataMasterCustomer extends StatelessWidget {
  const ComponentMenuDataMasterCustomer(
      {super.key, required this.title, required this.id});
  final String title;
  final int id;

  @override
  Widget build(BuildContext context) {
    print(id);
    final List<Tab> tabs = [
      const Tab(text: 'Edit Data Customer'),
      const Tab(text: 'Catatan Customer'),
      const Tab(text: 'Produk'),
      const Tab(text: 'Proyeksi Profit'),
      const Tab(text: 'Review'),
      const Tab(text: 'History'),
    ];

    final List<Widget> tabViews = [
      ComponentEditDetail(
        id: id,
      ),
      ComponentMenuCatatanMasterCustomer(
        id: id,
      ),
      ComponentMenuProdukMasterCustomer(
        id: id,
      ),
      ComponentProyeksiProfitUI(
        id: id,
      ),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(kToolbarHeight + kTextTabBarHeight),
          child: AppBar(
            title: Text(title, style: const TextStyle(color: Colors.black)),
            backgroundColor: Colors.grey.shade100,
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: tabs,
            ),
          ),
        ),
        body: TabBarView(
          children: tabViews,
        ),
      ),
    );
  }
}
