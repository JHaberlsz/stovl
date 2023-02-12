import 'package:flutter/material.dart';

class WorkoutDay extends StatefulWidget {
  WorkoutDay({Key? key,}) : super(key: key);

  @override
  State<WorkoutDay> createState() => _WorkoutDayState();

  
  late List<Uebung> list = _WorkoutDayState().ubungen;
}

class _WorkoutDayState extends State<WorkoutDay> {
  List<Uebung> ubungen = [
    Uebung(),
  ];

  TextEditingController textcontroller = TextEditingController();
  String dropdownvalueUbung = '1 Übung';
  int ubung = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Theme.of(context).primaryColor,
        elevation: 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
              child: TextField(
                controller: textcontroller,
                decoration: InputDecoration(
                    hintText: "Tagesbezeichnung:",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        textcontroller.clear();
                      },
                    )),
              ),
            ),
            Column(
              children: ubungen.map( (ub) {
                return ub;
              }).toList(),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      ubung++;
                      ubungen.add(Uebung());

                      widget.list = List<Uebung>.from(ubungen);
                      print(widget.list);
                    });
                  },
                  child: const Text('Übung hinzufügen'),
                ),
                OutlinedButton(
                  //textColor: const Color(0xFF6200EE),
                  onPressed: () {
                    // Perform some action
                    setState(() {
                      if (ubung > 1) {
                        ubung--;
                      }
                      if(ubungen.isNotEmpty){
                        ubungen.removeLast();
                      }
                      widget.list = List<Uebung>.from(ubungen);
                      print(widget.list);
                    });
                  },
                  child: const Text('Übung entfernen'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  List<Uebung> getUbungen() {
    return ubungen;
  }
}


class Uebung extends StatefulWidget {
  Uebung({Key? key,}) : super(key: key);

  @override
  State<Uebung> createState() => _UebungState();

  late int set = _UebungState().sets;
  late String name = _UebungState().textcontroller.text;
}

class _UebungState extends State<Uebung> {
  int sets = 1;
  String dropdownvalueSatz = '1 Satz';
  final textcontroller = TextEditingController();
  var enable = false;

  @override
  Widget build(BuildContext context) {

    var satze = [
      '1 Satz',
      '2 Sätze',
      '3 Sätze',
      '4 Sätze',
      '5 Sätze',
    ];

    return Padding(
      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: TextField(
                    controller: textcontroller,
                    decoration: InputDecoration(
                      hintText: "Übungsname:",
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          textcontroller.clear();
                          setState(() {
                            enable = false;
                          });
                        },
                      ),
                    ),
                    onChanged: (value) {
                      if(textcontroller.text.isEmpty){
                        setState(() {
                          enable = false;
                        });
                      }
                      else {
                        setState(() {
                          enable = true;
                        });
                      }
                    },
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black26,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButton(
                        itemHeight: 58,
                        isExpanded: true,
                        alignment: Alignment.center,
                        value: dropdownvalueSatz,
                        items: satze.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            alignment: Alignment.center,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: enable ? (String? newValue) {
                          setState(() {
                            dropdownvalueSatz = newValue!.toString();
                            sets = int.parse(newValue[0]);
                          });
                        } : null,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}
