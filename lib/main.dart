import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;

const List<String> stateList = <String>[
  'Alabama',
  'Alaska',
  'Arizona',
  'Arkansas',
  'California',
  'Colorado',
  'Connecticut',
  'Delaware',
  'Florida',
  'Georgia',
  'Hawaii',
  'Idaho',
  'Illinois',
  'Indiana',
  'Iowa',
  'Kansas',
  'Kentucky',
  'Louisiana',
  'Maine',
  'Maryland',
  'Massachusetts',
  'Michigan',
  'Minnesota',
  'Mississippi',
  'Missouri',
  'Montana',
  'Nebraska',
  'Nevada',
  'New Hampshire',
  'New Jersey',
  'New Mexico',
  'New York',
  'North Carolina',
  'North Dakota',
  'Ohio',
  'Oklahoma',
  'Oregon',
  'Pennsylvania',
  'Rhode Island',
  'South Carolina',
  'South Dakota',
  'Tennessee',
  'Texas',
  'Utah',
  'Vermont',
  'Virginia',
  'Washington',
  'West Virginia',
  'Wisconsin',
  'Wyoming',
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HowMich',
      theme: ThemeData(
        primarySwatch: primaryBlack,
      ),
      home: const MyHomePage(title: 'HowMich'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // data for website

  String dropdownValue = stateList.first;

  String cityValue = '';
  String interestValue = '';
  String educationValue = '';
  String kidsNumValue = '';
  String incomeValue = '';
  String workTypeValue = '';
  String hoursValue = '';

  Future<http.Response> getData() async {
    return Future.delayed(Duration(seconds: 2), () {
      // if cityValue or other variables are empty, return prompt to fill out
      if (cityValue == '' ||
          interestValue == '' ||
          educationValue == '' ||
          kidsNumValue == '' ||
          incomeValue == '' ||
          workTypeValue == '' ||
          hoursValue == '') {
        return 'Please fill out all fields';
      } else {
        // new call api
        var url = Uri.https(
                                  'us-central1-brainwaive-76ded.cloudfunctions.net',
                                  '/gptinput');
                              var response = await http.post(url,
                                  headers: {"Content-Type": "application/json"},
                                  body: json.encode({
                                    'question': quizTitle,
                                    'howManyQuestions': 5,
                                    'isQuestion': 'true'
                                  }));

                              mainViewModel.quizQuestions =
                                  json.decode(response.body);

                              return response;


        // call api
        http.post(
          Uri.parse('https://jsonplaceholder.typicode.com/albums'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'City': cityValue,
            'State': stateList.first,
            'interest': interestValue,
            'NumberOfkids': kidsNumValue,
          }),
        );

    return 'List of jobs';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
        child: Column(
          children: <Widget>[
            // create header text that is left aligned
            Row(children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'HowMich',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // horizontal expanded space
              const Expanded(
                child: SizedBox(),
              ),
              // accounts icon
              const Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.account_circle,
                  size: 40,
                ),
              ),
            ]),
            // horizontal line
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            // create column
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      // create text
                      // make left aligned
                      const Align(
                        alignment: Alignment.topLeft,
                        // text that is larger and bold
                        child: Padding(
                          padding: EdgeInsets.only(left: 70.0),
                          child: Text(
                            'Where do you want to work?',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // spacing
                      const SizedBox(
                        height: 10,
                      ),

                      // create row with city question and textEntry
                      Row(
                        children: <Widget>[
                          // create text
                          const Text(
                            'City: ',
                          ),

                          // create space between text and textEntry
                          const SizedBox(
                            width: 100,
                          ),

                          // create textEntry
                          // containder with 200 width
                          Container(
                              width: 200,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Enter your city',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 5.0),
                                ),
                                onChanged: (text) {
                                  setState(() {
                                    cityValue =
                                        text; // Update the cityValue variable with the updated text
                                  });
                                },
                              )),
                        ],
                      ),

                      // spacing
                      const SizedBox(
                        height: 5,
                      ),

                      Row(
                        children: <Widget>[
                          // create text
                          const Text(
                            'State: ',
                          ),

                          // create space between text and textEntry
                          const SizedBox(
                            width: 90,
                          ),

                          // create textEntry
                          // containder with 200 width
                          SizedBox(
                            width: 200.0,
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                isExpanded: true,
                                elevation: 16,
                                style: const TextStyle(
                                    color: primaryBlack, fontSize: 14),
                                underline: Container(),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                },
                                items: stateList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(value),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // spacing
                      const SizedBox(
                        height: 5,
                      ),

                      // ask user for their interests in row
                      Row(
                        children: <Widget>[
                          // create text
                          const Text(
                            'Interests: ',
                          ),

                          // create space between text and textEntry
                          const SizedBox(
                            width: 70,
                          ),

                          // create textEntry
                          // containder with 200 width
                          Container(
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter your interests',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 5.0),
                              ),
                              onChanged: (text) {
                                setState(() {
                                  interestValue = text;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      //spacing
                      const SizedBox(
                        height: 5,
                      ),
                      // ask user for education background in row
                      Row(
                        children: <Widget>[
                          // create text
                          const Text(
                            'Education: ',
                          ),

                          // create space between text and textEntry
                          const SizedBox(
                            width: 63,
                          ),

                          // create textEntry
                          // containder with 200 width
                          Container(
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter your education',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 5.0),
                              ),
                              onChanged: (text) {
                                setState(() {
                                  educationValue = text;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      // spacing
                      const SizedBox(
                        height: 5,
                      ),

                      // ask user for number of kids
                      Row(
                        children: <Widget>[
                          // create text
                          const Text(
                            'Number of Kids:',
                          ),

                          // create space between text and textEntry
                          const SizedBox(
                            width: 30,
                          ),

                          // create textEntry
                          // containder with 200 width
                          Container(
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter number of kids',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 5.0),
                              ),
                              onChanged: (text) {
                                setState(() {
                                  kidsNumValue = text;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      // spacing
                      const SizedBox(
                        height: 5,
                      ),

                      // ask user for preferred income
                      Row(
                        children: <Widget>[
                          // create text
                          const Text(
                            'Preferred Income:',
                          ),

                          // create space between text and textEntry
                          const SizedBox(
                            width: 20,
                          ),

                          // create textEntry
                          // containder with 200 width
                          Container(
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter preferred income',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 5.0),
                              ),
                              onChanged: (text) {
                                setState(() {
                                  incomeValue = text;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      // spacing
                      const SizedBox(
                        height: 5,
                      ),

                      // ask user for what kind of work they're looking for
                      Row(
                        children: <Widget>[
                          // create text
                          const Text(
                            'Work Type:',
                          ),

                          // create space between text and textEntry
                          const SizedBox(
                            width: 65,
                          ),

                          // create textEntry
                          // containder with 200 width
                          Container(
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter work type',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 5.0),
                              ),
                              onChanged: (text) {
                                setState(() {
                                  workTypeValue = text;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      // spacing
                      const SizedBox(
                        height: 5,
                      ),

                      // ask user for how many hours they want to work
                      Row(
                        children: <Widget>[
                          // create text
                          const Text(
                            'Hours:',
                          ),

                          // create space between text and textEntry
                          const SizedBox(
                            width: 93,
                          ),

                          // create textEntry
                          // containder with 200 width
                          Container(
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter hours',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 5.0),
                              ),
                              onChanged: (text) {
                                setState(() {
                                  hoursValue = text;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      // spacing
                      const SizedBox(
                        height: 20,
                      ),

                      // button to search jobs
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          // edge insets from left
                          padding: const EdgeInsets.only(left: 100.0),
                          child: Container(
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                // call getData
                                getData();
                                setState(() {});
                              },
                              child: const Text('Search Jobs'),
                            ),
                          ),
                        ),
                      ),
                      // create container
                      Container(
                        height: 190,
                        // make color blue
                      ),
                    ],
                  ),
                ),

                // SECOND HALF

                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 13.0),
                        child: FutureBuilder(
                          builder: (ctx, snapshot) {
                            // Checking if future is resolved or not
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              // If we got an error
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    '${snapshot.error} occurred',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                );

                                // if we got our data
                              } else if (snapshot.hasData) {
                                // if any value is empty return message to fill out all fields
                                if (cityValue == '' ||
                                    interestValue == '' ||
                                    educationValue == '' ||
                                    kidsNumValue == '' ||
                                    incomeValue == '' ||
                                    workTypeValue == '' ||
                                    hoursValue == '') {
                                  return Center(
                                    child: Text(
                                      'Please fill out all fields',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  );
                                }
                                // Extracting data from snapshot object
                                final data = snapshot.data as String;
                                return Center(
                                  child: Container(
                                    height:
                                        615.0, // Set a fixed height for the container
                                    child: Expanded(
                                      child: ListView.builder(
                                        itemCount: 10,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Card(
                                            elevation:
                                                5.0, // Adjust the elevation to control the shadow
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    10.0)), // Adjust the shape of the card
                                            child: ListTile(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Job ${index}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15.0),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          5.0), // Add a gap of 10.0 pixels between the title and subtitle
                                                ],
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Very cool description of this epic job!',
                                                    style: TextStyle(
                                                        fontSize: 12.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }

                            // Displaying LoadingSpinner to indicate waiting state
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },

                          // Future that needs to be resolved
                          // inorder to display something on the Canvas
                          future: getData(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // start footer
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            // text for footer
            const Text(
              'Made with ❤️ in Boston, MA',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
