import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PlacePickerScreen(),
    );
  }
}

class PlacePickerScreen extends StatelessWidget {
  const PlacePickerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> places = [
      'Kuchyňa',
      'Kúpeľňa',
      'Záchod',
      'Zem',
      'Schody + stoly'
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final boxWidth = (screenWidth - 30) / 2; // 30 is the total horizontal padding and spacing for two boxes
    final boxHeight = 150.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jednotlivé miestnosti'),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFB9A5E2), // Set background color here
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              spacing: 10.0,
              runSpacing: 20.0,
              children: places.sublist(0, 4).map((String place) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaceDetailScreen(place: place),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      color: Colors.deepPurple.shade100,
                      width: boxWidth,
                      height: boxHeight,
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          place,
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20.0), // Add spacing between rows
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlaceDetailScreen(place: places.last)),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  color: Colors.deepPurple.shade100,
                  width: boxWidth,
                  height: boxHeight,
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      places.last,
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TaskAssignerScreen()),
                  );
                },
                child: const Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceDetailScreen extends StatelessWidget {
  final String place;

  const PlaceDetailScreen({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> tasks = [];

    // Define tasks based on the selected place
    switch (place) {
      case 'Kuchyňa':
        tasks = [
          'Umyť sporák',
          'Umyť drez a plastový sušič na riady',
          'Pretrieť kuchynskú plochu',
          'Pretrieť vnútro mikrovlnky',
          'Vyhodiť komunálne smeti',
          'Pretrieť kachličky, digestor, rúčky od dvierok',
        ];
        break;
      case 'Kúpeľňa':
        tasks = [
          'Umyť vaňu',
          'Umyť umývadlo',
          'Vytrieť zrkadlo',
          'Odstrániť pleseň v rohoch',
          'Pretrieť kelímok s kefkami',
        ];
        break;
      case 'Záchod':
        tasks = [
          'Vyčistiť WC misu',
          'Oprať koberčeky',
          'Doplniť toaletný papier',
        ];
        break;
      case 'Zem':
        tasks = [
          'Pozametať podlahu v obývačke, špajzi, kuchyni, kúpeľni a na chodbe',
          'Taktiež umyť mopom',
        ];
        break;
      case 'Schody + stoly':
        tasks = [
          'Vytretie schodov',
          'Vytretie stolov',
          'Vyhodiť plasty, papier a sklo',
        ];
        break;
      default:
        tasks = [];
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('$place'),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFB9A5E2), // Set background color here
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            // Display the list of tasks with checkboxes
            ListView.builder(
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: false, // Initial value for checkbox
                    onChanged: (bool? value) {
                      // Handle checkbox state change
                      // Implement your logic here
                    },
                  ),
                  title: Text(tasks[index]), // Display the task
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskAssignerScreen()),
                );
              },
              child: const Text('Vyber si rolu ->'),
            ),
          ],
        ),
      ),
    );
  }
}


class TaskAssignerScreen extends StatefulWidget {
  const TaskAssignerScreen({Key? key}) : super(key: key);

  @override
  _TaskAssignerScreenState createState() => _TaskAssignerScreenState();
}

class _TaskAssignerScreenState extends State<TaskAssignerScreen> {
  String selectedPlace = 'Kuchyňa';
  String selectedPerson = 'Vítek';
  final List<String> places = ['Kuchyňa', 'Kúpeľňa', 'Záchod', 'Zem', 'Schody + stoly'];
  final List<String> people = ['Vítek', 'Adam', 'Pája', 'Míša', 'Frede'];
  final Map<String, String> assignedTasks = {}; // Map to store assigned tasks

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color(0xFFB9A5E2);
    Color doneColor = const Color(0xFFD1C1F2);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Prideľovač rolí'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 10),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10.0,
                children: places.map((String place) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedPlace = place;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(selectedPlace == place ? Colors.deepPurple.shade100 : Colors.deepPurple.shade300),
                    ),
                    child: Text(place),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10.0,
                children: people.map((String person) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedPerson = person;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(selectedPerson == person ? Colors.deepPurple.shade100 : Colors.deepPurple.shade300),
                    ),
                    child: Text(person),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Check if the task is already assigned to someone
                  if (!assignedTasks.containsKey(selectedPlace)) {
                    setState(() {
                      assignedTasks[selectedPlace] = selectedPerson;
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('POZOR!'),
                          content: const Text('Túto rolu má už niekto priradenú. Vyber si inú.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Vziať si rolu'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Priradené role:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: assignedTasks.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: doneColor,
                      child: ListTile(
                        title: Text('${assignedTasks.keys.toList()[index]} - ${assignedTasks.values.toList()[index]}'),
                        trailing: Checkbox(
                          value: false,
                          onChanged: (bool? value) {
                            if (value == true) {
                              setState(() {
                                assignedTasks.remove(assignedTasks.keys.toList()[index]);
                              });
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}