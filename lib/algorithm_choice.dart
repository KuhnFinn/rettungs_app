import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rettungs_app/show_pdf.dart';

import 'main.dart';

class AlgorithmChoice extends StatelessWidget {
  final String disease;

  const AlgorithmChoice(this.disease, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(disease),
        ),
        body: Column(
          children:  <Widget>[
            hasAlgorithm("NUN")?AlgorithmCard("NUN", "Niedersäschische Umsetzung Notfallsanitärgesetz",disease):Container(),
            hasAlgorithm("DBRD")?AlgorithmCard("DBRD", "Deutscher Berufsverband Rettungsdienst e.V.",disease):Container(),
          ],
        ),
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.home_outlined),
      onPressed: (){
        Navigator.popUntil(context, ModalRoute.withName('/'));
      },
    ),);
  }

  bool hasAlgorithm(String algorithm){
    bool returnValue  = false;
    directory.forEach((element) {
      if(element[1] == disease){
        if(element[2] == algorithm){
          returnValue = true;
        }
      }
    });
    return returnValue;
  }
}

class AlgorithmCard extends StatelessWidget{

  final String title, subtitle, disease;
  const AlgorithmCard(this.title,this.subtitle,this.disease,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Card(
          child: InkWell(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>ShowPDF(disease, title)));
              },
              child:  ListTile(
                title: Text(title),
                subtitle:
                Text(subtitle),
              )),
        ));
  }

}
