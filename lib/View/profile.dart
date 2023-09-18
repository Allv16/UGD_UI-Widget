import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('P R O F I L E'),
          ),
          body: Column(
            children: [
              const TabBar(
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    text: 'Alvian',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    text: 'Andreas',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    text: 'Stella',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    text: 'Kristin',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    text: 'Sebastian',
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  //tab 1
                  Container(
                    color: Colors.lightBlue.shade100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'images/Alvian.jpg',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Text(
                            '\nYohanes Alvian' '\nNPM : 210711047',
                            style: TextStyle(fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                  //tab 2
                  Container(
                    color: Colors.lightBlue.shade100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'images/profile-Ayas.JPG',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Text('\nAndreas Margono' '\nNPM : 210711135',
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                  //tab 3
                  Container(
                    color: Colors.lightBlue.shade100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'images/stel.jpg',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Text('\nRhema Stella' '\nNPM : 210711071',
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                  //tab 4
                  Container(
                    color: Colors.lightBlue.shade100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'images/kristin.jpg',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Text('\nKristina Adine' '\nNPM : 210711102',
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                  //tab 5
                  Container(
                    color: Colors.lightBlue.shade100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'images/yiyi.JPG',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Text('\nSebastian Gautama' '\nNPM : 210711172',
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ));
  }
}
