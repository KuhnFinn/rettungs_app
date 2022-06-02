import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rettungs_app/show_pdf.dart';

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
            AlgorithmCard("NUN", "Niedersäschische Umsetzung Notfallsanitärgesetz",disease),
            AlgorithmCard("DBRD", "Deutscher Berufsverband Rettungsdienst e.V.",disease),
          ],
        ),
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.home_outlined),
      onPressed: (){
        Navigator.popUntil(context, ModalRoute.withName('/'));
      },
    ),);
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
