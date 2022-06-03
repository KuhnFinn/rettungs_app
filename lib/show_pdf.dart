import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:rettungs_app/algorithmPath.dart';

class ShowPDF extends StatefulWidget {
  final String disease, algorithm;

  const ShowPDF(this.disease, this.algorithm, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShowPDFState(disease, algorithm);
}

class _ShowPDFState extends State<ShowPDF> with SingleTickerProviderStateMixin {
  final String disease, algorithm;


  _ShowPDFState(this.disease, this.algorithm);

  final pdfPinchController = PdfController(
    document: PdfDocument.openAsset('assets/DBRGAlgo0522_Web1.pdf'),
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: algorithms.indexOf(algorithm) ,
        child: Scaffold(
          appBar: AppBar(
            title: Text(disease),
            bottom: const TabBar(
                tabs: <Tab>[Tab(child: Text("NUN")), Tab(child: Text("DBRD"))]),
          ),
          body: TabBarView(
            children: [
              Center(
                child: FutureBuilder(
                  future: getPdfPageAsImage(
                      'assets/NUN-Algorithmen-Version-2022-1.1.pdf'),
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
              Center(
                  child: FutureBuilder(
                    future: getPdfPageAsImage(
                        'assets/DBRGAlgo0522_Web1.pdf'),
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
                  ),),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.home_outlined),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
        ));
  }

  Future<MemoryImage> getPdfPageAsImage(String name) async {
    PdfDocument doc = await PdfDocument.openAsset(name);

    PdfPage page = await doc.getPage(1);

    PdfPageImage? pageImage = await page.render(width: 2100, height: 2970);

    return MemoryImage(pageImage!.bytes);
  }
}
