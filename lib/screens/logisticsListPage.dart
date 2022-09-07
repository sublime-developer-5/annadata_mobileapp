import 'package:annadata/widgets/logisticsListCard.dart';
import 'package:flutter/material.dart';

class LogisticsListPage extends StatefulWidget {
  LogisticsListPage({Key? key, this.produtId}) : super(key: key);

  String? produtId = "";

  @override
  State<LogisticsListPage> createState() => _LogisticsListPageState();
}

class _LogisticsListPageState extends State<LogisticsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logistic List"),
      ),
      body: LogisticsListCard(productId: widget.produtId.toString()),
    );
  }
}
