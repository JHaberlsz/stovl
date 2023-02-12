import 'package:flutter/material.dart';
import 'Workout_day.dart';

class Workout extends StatefulWidget {
  const Workout({Key? key}) : super(key: key);

  @override
  State<Workout> createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  int haufigkeit = 1;
  List<WorkoutDay> workoutTage = [
    WorkoutDay(),
  ];


  @override
  Widget build(BuildContext context) {

    return Builder(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Workout"),
          ),

          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            if(haufigkeit >= 7){
                              showDialog(
                                  context: context,
                                  builder: (builder) => AlertDialog(
                                    title: const Text("Limit erreicht!"),
                                    content: const Text("Limit von 7 Tage in der Woche kann nicht überschritten werden!"),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () => {
                                            Navigator.of(builder).pop()
                                          },
                                          child: const Text("Verstanden"),
                                      )
                                    ],
                                  ),
                              );
                            }
                            else{
                              workoutTage.add(WorkoutDay());
                              haufigkeit = haufigkeit + 1;
                            }
                          });
                        },
                        child: const Text('Trainingstag hinzufügen'),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            if(haufigkeit>0){
                              haufigkeit--;
                            }
                            if(workoutTage.isNotEmpty){
                              workoutTage.removeLast();
                            }
                          });
                        },
                        child: const Text('Trainingstag entfernen'),
                      ),
                    ],
                  ),
                ],
              ),
              Flexible(
                fit: FlexFit.loose,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: workoutTage.map((tage){
                    return WorkoutDay();
                  }).toList(),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 12.0,
                      textStyle: const TextStyle(color: Colors.white)),
                  child: const Text('Speichern'),
                  onPressed: () {
                    workoutTage.forEach((elementFirst) {
                      elementFirst.list.forEach((element) {
                        print(elementFirst.list);
                      });
                    });
                    //Navigator.pop(context);

                  },
                ),
              ),
            ],
          ));
    });
  }
}
