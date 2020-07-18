import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LazyLoading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LazyLoadingState();
  }
}

class _LazyLoadingState extends State<LazyLoading> {
  List list;
  int max = 10;
  ScrollController scrollController = ScrollController();
  void initState() {
    super.initState();
    list = List.generate(10, (index) => "Item : ${index + 1}");
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreData();
      }
    });
  }

  void getMoreData() {
    for (int inc = max; inc < max + 10; inc++) {
      list.add("Item : ${inc + 1}");
    }
    max = max + 10;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length + 1,
        controller: scrollController,
        scrollDirection: Axis.vertical,
        itemExtent: 80,
        itemBuilder: (context, index) {
          if (index == list.length) {
            return CupertinoActivityIndicator();
          }
          {
            return ListTile(
              title: Text(list[index]),
            );
          }
        });
  }
}
