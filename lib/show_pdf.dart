import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowPDF extends StatelessWidget {
  final String disease, algorithm;

  const ShowPDF(this.disease, this.algorithm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(disease),
            bottom: const TabBar(
                tabs: <Tab>[Tab(child: Text("NUN")), Tab(child: Text("DBRD"))]),
          ),
          body: const TabBarView(
            children: [Text("NUN"), Text("DBRD")],
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.home_outlined),
            onPressed: (){
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
        ));
  }
}
