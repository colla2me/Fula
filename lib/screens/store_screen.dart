import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utils/cart_icons.dart';

class StorePage extends StatelessWidget {

  List<Product> addItems() {
    final list =List<Product>();

    final data1 = Product('House Hold', CartIcons.house_hold);
    list.add(data1);
    final data2 = Product('Grocery', CartIcons.grocery);
    list.add(data2);
    final data3 = Product('Liquor', CartIcons.liquor);
    list.add(data3);
    final data4 = Product('Breads', CartIcons.bread);
    list.add(data4);

    return list;
  }

  Widget _buildCategoryList() {
    final items = addItems();
    return Container(
      height: 150,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final data = items[index];
          return Column(
            children: <Widget>[
              Container(
                margin:EdgeInsets.all(10),
                width: 95,
                height: 95,
                alignment: Alignment.center,
                child: Icon(
                  data.image,
                  size: 40,
                  color: Colors.black38,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 5),
                      blurRadius: 15
                    )
                  ]
                ),
              ),
              Row(
                children: <Widget>[
                  Text(data.name),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 14
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 16, top: 4),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            )
          ),
        ),

        Padding(
          padding: EdgeInsets.only(left: 16, top: 4),
          child: FlatButton(
            onPressed: () {},
            child: Text(
              'View All',
              style: TextStyle(color: Colors.yellow),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildDealList() {
    final items = addItems();
    return Container(
      height: 200,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final data = items[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                width: 130,
                height: 140,
                alignment: Alignment.center,
                child: Icon(
                  data.image,
                  size: 40,
                  color: Colors.black38,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 5),
                      blurRadius: 15
                    )
                  ]
                ),
              ),
              Container(
                width: 130,
                alignment: Alignment.centerLeft,
                child: Text(
                  data.name,
                  style:TextStyle(
                    fontSize: 14,
                    color: Colors.black
                  )
                ),
              ),
              Container(
                width: 130,
                margin: EdgeInsets.only(top: 4, left: 4),
                alignment: Alignment.centerLeft,
                child: Text(
                  'RMB.320',
                  style:TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight:FontWeight.bold
                  )
                ),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Store Page',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20
          )
        ),
        backgroundColor: Colors.lightGreen,
      ),
      backgroundColor: Colors.lightBlue,
      body: Container(
        color: const Color(0xf4f7fa),
        child: ListView(
          children: <Widget>[
            _buildSectionHeader('All Categories'),
            _buildCategoryList(),
            _buildSectionHeader('Prime Member Deals'),
            _buildDealList(),
            _buildSectionHeader('Keells Deals'),
            _buildDealList()
          ],
        ),
      ),
    );
  }
}
