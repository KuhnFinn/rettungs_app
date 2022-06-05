import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rettungs_app/algorithm_choice.dart';
import 'package:csv/csv.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rettungsapp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(title: 'Rettungsapp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchBarController = TextEditingController();

  List<String> searchedDiseases = diseases;

  @override
  void initState() {
    super.initState();
    getDiseaseList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                    onChanged: (value) => filterDiseases(value),
                    controller: searchBarController,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.search), hintText: "Krankheit")),
            ),
            Expanded(child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchedDiseases.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(searchedDiseases[index]),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                  AlgorithmChoice(searchedDiseases[index]))));
                        },
                      );
                    }))),
          ],
        ),
      ),
    );
  }

  filterDiseases(String searchValue) {
    List<String> newList = [];
    if (searchValue.isEmpty) {
      newList = diseases;
    } else {
      diseases.forEach((String disease) {
        if (disease.toLowerCase().contains(searchValue.toLowerCase())) {
          newList.add(disease);
        }
      });
    }
    setState(() {
      searchedDiseases = newList;
    });
  }

  getDiseaseList()async{
    String rawData = await rootBundle.loadString("assets/rettungsInhaltsverzeichnis.csv");
    List<List<dynamic>> _listData = const CsvToListConverter().convert(rawData);
    directory = _listData;
    List<String> newList = [];
    _listData.forEach((element) {
      newList.add(element[1]);
    });
    diseases = newList;
    filterDiseases("");
  }
}

List<String> diseases = [];
List<List<dynamic>> directory = [];
