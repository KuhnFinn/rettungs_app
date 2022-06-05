import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:rettungs_app/algorithmPath.dart';

import 'main.dart';

class ShowPDF extends StatefulWidget {
  final String disease, algorithm;

  ShowPDF(this.disease, this.algorithm, {Key? key}) : super(key: key);

  List<String> tabs = [];

  @override
  State<StatefulWidget> createState() => _ShowPDFState(disease, algorithm);
}

class _ShowPDFState extends State<ShowPDF> with SingleTickerProviderStateMixin {
  final String disease, algorithm;

  _ShowPDFState(this.disease, this.algorithm);

  List<String> tabTitles = [];
  List<Tab> tabs = [];
  List<Widget> tabViews = [];

  final pdfPinchController = PdfController(
    document: PdfDocument.openAsset('assets/DBRGAlgo0522_Web1.pdf'),
  );

  @override
  void initState() {
    super.initState();

    if (hasAlgorithm("NUN")) {
      tabTitles.add("NUN");
    }
    if (hasAlgorithm("DBRD")) {
      tabTitles.add("DBRD");
    }
    tabTitles.forEach((element) {
      tabs.add(Tab(
        child: Text(element),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabTitles.length,
        initialIndex: tabTitles.indexOf(algorithm),
        child: Scaffold(
          appBar: AppBar(
            title: Text(disease),
            bottom: TabBar(tabs: tabs),
          ),
          body: TabBarView(children: getViews()),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.home_outlined),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
        ));
  }

  List<Widget> getViews() {
    List<Widget> returnList = [];
    if (hasAlgorithm("NUN")) {
      returnList.add(
        Center(
          child: FutureBuilder(
            future: getPdfPageAsImage(
                'assets/NUN-Algorithmen-Version-2022-1.1.pdf', getPage("NUN")),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    key: UniqueKey(),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: snapshot.data as MemoryImage)));
              }
              return Container();
            },
          ),
        ),
      );
    }
    if (hasAlgorithm("DBRD")) {
      returnList.add(
        Center(
          child: FutureBuilder(
            future: getPdfPageAsImage(
                'assets/DBRGAlgo0522_Web1.pdf', getPage("DBRD")),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    key: UniqueKey(),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: snapshot.data as MemoryImage)));
              }
              return Container();
            },
          ),
        ),
      );
    }
    return returnList;
  }

  bool hasAlgorithm(String algorithm) {
    bool returnValue = false;
    directory.forEach((element) {
      if (element[1] == disease) {
        if (element[2] == algorithm) {
          returnValue = true;
        }
      }
    });
    return returnValue;
  }

  int getPage(String algorithm) {
    return directory[directory.indexWhere((element) {
      if (element[2] == algorithm) {
        return element[1] == disease;
      }
      return false;
    })][0];
  }

  Future<MemoryImage> getPdfPageAsImage(String name, int pageNumber) async {
    PdfDocument doc = await PdfDocument.openAsset(name);

    PdfPage page = await doc.getPage(pageNumber);

    PdfPageImage? pageImage = await page.render(width: 2100, height: 2970);

    return MemoryImage(pageImage!.bytes);
  }
}
